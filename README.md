# Building Golden AMI with Packer

This repository provides a set of Packer configurations to build an Amazon Machine Image (AMI) using different provisioners.

## Prerequisites

Make sure you have the following prerequisites installed on your system:

* Packer - Install Packer according to the official documentation.
* AWS account access to build AMIs and launch EC2 instances.

## Usage

Follow the steps below to build an AMI using Packer:
1. Clone this repository to your local machine:
```bash
git clone https://github.com/vijayg92/ec2-golden-ami-demo.git
```
2. In this repository, you'll find separate directories for each provisioner, such as ansible, shell, etc.

3. Choose the desired provisioner configuration, and navigate to the repository directory:

```
cd ansible_provisioner                                          
or
cd shell_provisioner
```

4. Customise the provisioner configuration as per your requirements. Modify the necessary files, scripts, or configuration files in the provisioner directory.

5. Open the `webserver.pkr.hcl` file in the provisioner directory and review/update the configuration options as needed.

6. Build the AMI using Packer command:
```
packer build -var-file=templates/webserver.pkrvars.hcl templates/webserver.pkr.hcl

amazon-ebs.webserver: output will be in this color.
==> amazon-ebs.webserver: Prevalidating any provided VPC information
==> amazon-ebs.webserver: Prevalidating AMI Name: webserver-2.4-20230520103143
==> amazon-ebs.webserver: Provisioning with Ansible...
    amazon-ebs.webserver: Setting up proxy adapter for Ansible....
    amazon-ebs.webserver: PLAY [WebApp Playbook] *********************************************************
    amazon-ebs.webserver:
    amazon-ebs.webserver: TASK [Gathering Facts] *********************************************************
    amazon-ebs.webserver: [WARNING]: Platform linux on host default is using the discovered Python
    amazon-ebs.webserver: ok: [default]
    amazon-ebs.webserver: interpreter at /usr/bin/python, but future installation of another Python
    amazon-ebs.webserver: interpreter could change this. See https://docs.ansible.com/ansible/2.9/referen
    amazon-ebs.webserver: ce_appendices/interpreter_discovery.html for more information.
    amazon-ebs.webserver:
    amazon-ebs.webserver: TASK [install_httpd] ***********************************************************
    ......
```

In this example, Ansible is used to bake the AMI. Packer will start the build process and execute the specified provisioner to create the AMI.

7. Once the build process completes, the generated AMI ID will be displayed in the output. You can use this AMI ID to launch EC2 instances in AWS.
```
==> amazon-ebs.webserver: Provisioning with shell script: /tmp/packer-shell1563525277
    amazon-ebs.webserver: ============================= test session starts ==============================
    amazon-ebs.webserver: platform linux -- Python 3.7.16, pytest-7.3.1, pluggy-1.0.0
    amazon-ebs.webserver: rootdir: /tmp
    amazon-ebs.webserver: plugins: testinfra-7.0.0
    amazon-ebs.webserver: collected 4 items
    amazon-ebs.webserver:
    amazon-ebs.webserver: ../../tmp/test_apache.py ....                                            [100%]
    amazon-ebs.webserver:
    amazon-ebs.webserver: ============================== 4 passed in 0.20s ===============================
```
## Contributing

If you'd like to contribute to this project, please follow the standard guidelines for pull requests.

## License

This project is licensed under the MIT License.

Feel free to modify and extend the code as per your needs.
