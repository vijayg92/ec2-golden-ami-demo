variable "app_role" { type = string }
variable "app_version" { type = string }
variable "instance_type" { type = string }
variable "root_volume_size" { type = string }
variable "aws_region" { type = string }
variable "aws_access_key" { default = "${env("aws_access_key")}" }
variable "aws_secret_key" { default = "${env("aws_secret_key")}" }

locals {
    timestamp = regex_replace(timestamp(), "[- TZ:]", "")
    ami_name  = lower("${var.app_role}-${var.app_version}")
}

source "amazon-ebs" "webserver" {
  region                  = "${var.aws_region}"
  ami_name                = "${local.ami_name}-${local.timestamp}"
  ami_description         = "Golden AMI To Deploy WebServer"
  ssh_username            = "ec2-user"
  ssh_wait_timeout        = "10000s"
  instance_type           = "${var.instance_type}"
  source_ami              = "ami-052f483c20fa1351a"
  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = "${var.root_volume_size}"
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.app_role}"
  }
}

build {

  sources = ["source.amazon-ebs.webserver"]

  provisioner "file" {
    source          = "test_apache.py"
    destination     = "/tmp/"
  }

  provisioner "ansible" {
    playbook_file = "webserver.yaml"
  }

  provisioner "shell" {
    execute_command  = "{{.Vars}} sudo -E -S bash '{{.Path}}'"
    inline = [
      "python3 -m pytest /tmp/test_apache.py",
    ]
  }
}
