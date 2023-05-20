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
2. Navigate to the repository directory:
```
cd ansible_provisioner                                          
or
cd shell_provisioner
```

3. Choose the desired provisioner configuration. In this repository, you'll find separate directories for each provisioner, such as ansible, chef, shell, etc.

4. Customize the provisioner configuration as per your requirements. Modify the necessary files, scripts, or configuration files in the provisioner directory.

5. Open the packer.json file in the provisioner directory and review/update the configuration options as needed.

6. Build the AMI using Packer:
```
CODE
```

Packer will start the build process and execute the specified provisioner to create the AMI.

7. Once the build process completes, the generated AMI ID will be displayed in the output. You can use this AMI ID to launch EC2 instances in AWS.

## Contributing

If you'd like to contribute to this project, please follow the standard guidelines for pull requests.

## License

This project is licensed under the MIT License.

Feel free to modify and extend the code as per your needs.
