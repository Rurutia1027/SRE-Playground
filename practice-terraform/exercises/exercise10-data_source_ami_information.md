# Using Data Sources to Fetch AMI Information

## Introduction

In this exercise, we will be exploring the use of AWS data sources in Terraform to retrieve the most recent Ubuntu
Amazon Machine Image (AMI). We'll define an output variable to print the ID of the retrieved AMI and use this ID to
configure an AWS instance resource. This hands-on exercise is designed to give you practical experience in handling AWS
AMIs and configuring AWS instances using Terraform.

--- 

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview
of what the created solution should deploy:

- Define an AWS data source to retrieve the most recent Ubuntu AMI.
- Create an output to print the ID of the retrieved AMI.
- Create an AWS EC2 instance, using the retrieved Ubuntu AMI ID. Use an instance type that is included in your free
  tier. Most of the times, this will be a `t2.micro` instance, but it can also be `t3.micro` in regions that do not have
  `t2.micro` instances available. Make sure to check that beforehand to avoid any unwanted charges!
- Configure the instance's root block device with a volume size of 10, a volume type of `gp3`, and set it to be deleted
  on termination.

--- 

## Useful Resources

* [AWS AMI Data Source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)

--- 

## Step-by-Step Guide

- First, define a data source to retrieve the most recent Ubuntu AMI from AWS. The owner of the AMI is Canonical, the
  company behind Ubuntu. We use filters to only retrieve the AMIs that match our criteria.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # owner is Canonical

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

}
```

- Then, define an output variable to print the ID of the AMI we have retrieved

```hcl
output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}
```

- Finally, define an AWS instance resource. Use the ID of the Ubuntu AMI we have retrieved on the AMI for the instance.
  Specify the instance type to be `t2.micro`. Also specify the root block device configuration to have a volume size of
  10, a volume type of 'gp3', and set it to be deleted on termination.

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}
```

- Run `terraform apply` to create the infrastructure. If everything is configured correctly, it should create a new
  `t2.micro` instance in your AWS account using the most recent Ubuntu AMI.
- Make sure to destroy the resources after you complete all the steps. 