variable "app_role" {
  type = string
  default = "webserver"
}

variable "app_version" {
  type = string
  default = "2.4"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "root_volume_size" {
  type = string
  default = "25"
}

variable "aws_region" {
  type = string
  default = "ap-south-1"
}

variable "aws_access_key" {
  type    = string
  default = "${env("aws_access_key")}"
}

variable "aws_secret_key" {
  type    = string
  default = "${env("aws_secret_key")}"
}

locals {
    timestamp = regex_replace(timestamp(), "[- TZ:]", "")
    ami_name  = lower("${var.app_role}-${var.app_version}")
}

source "amazon-ebs" "webserver" {
  region                      = "${var.aws_region}"
  ami_name                    = "${local.ami_name}-${local.timestamp}"
  ami_description             = "Golden AMI To Deploy WebServer"
  ssh_username                = "ec2-user"
  instance_type               = "${var.instance_type}"
  ssh_wait_timeout            = "10000s"
  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = "${var.root_volume_size}"
    volume_type           = "gp3"
    delete_on_termination = true
  }
  source_ami = "ami-052f483c20fa1351a"

  tags = {
    Name = "${var.app_role}"
  }
}

build {

  sources = ["source.amazon-ebs.webserver"]

  provisioner "file" {
    source          = "tests/test_apache.py"
    destination     = "/tmp/"
  }

  provisioner "ansible" {
    playbook_file = "provioners/ansible/webserver.yaml"
  }
  provisioner "shell" {
    execute_command  = "{{.Vars}} sudo -E -S bash '{{.Path}}'"
    inline = [
      "python3 -m pytest /tmp/test_apache.py",
    ]
  }
}
