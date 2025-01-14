# Create EC2 Instances based on a List Variable

## Introduction

In this exercise, we will learn how to create multiple EC2 instances in Terraform based on a list of configurations. We
will define the desired EC2 instance properties such as instance type and AMI in a list variable and then use Terraform
to create these instances. This exercise will provide you with practical experience in handling complex configurations
and manipulating data sources and resources in Terraform.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview
of what the created solution should deploy:

- Create a list of EC2 instances based on a specified configuration list variables.
- The configuration list includes details such as the instance type and AMI.
- The AMI property should receive a user-friendly value, such as "ubuntu", and retrieve the DMI ID based on a data
  source.
- The instances are distributed across different subnets.

--- 

## Step-by-Step Guide

- Create a new variable `ec2_instance_config_list` under the file `variables.tf`. This variable is of type list, which
  contains objects with specific keys. The keys include `instance_type` and `ami`, both of type string. The default
  value for this variable is an empty list.

  ```hcl
  variable "ec2_instance_config_list" {
    type = list(object({
      instance_type = string
      ami           = string
    }))
  
    default = []
  }
  ```

- Add an entry for the variable in the `terraform.tfvars` file. The list should contains one object with the
  `instance_type` set to "t2.micro" (or whatever type falls under your free tier), and the `ami` set to "ubuntu". Also
  make sure to set the `ec2_instance_count` variable to `0` so that we do not create any additional ec2 instances.

  ```hcl
  # object array 
  ec2_instance_config_list = [
    {
      instance_type = "t2.micro",
      ami           = "ubuntu"
    }
  ]
  ```

- In the `compute.tf` file, add a new resource `aws_instance.from_list` which iterates over the list by using a
  `count=length(var.ec2_instance_config_list)` meta-argument. Retrieve the information from the configuration object.
  How can we use the `ubuntu` value to get the AMI ID? (Hint: Try to use a local map to stor ethe AMI ID coming form the
  data source).

```hcl
locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # Canonical is the owner

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "from_list" {
  count = length(var.ec2_instance_config_list)
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.main[
  # distribute subnet ids to all aws ec2 instance
  count.index % length(aws_subnet.main)
  ].id

  tags = {
    Name    = "${local.project}-${count.index}"
    Project = local.project
  }
}

```

- Run a `terraform plan` and inspect the proposed changes.