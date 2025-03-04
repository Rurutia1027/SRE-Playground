# Customizing EC2 Instance Size and Volume Data

## Introduction

In this exercise, we will guide you through customizing the size and volume data of an EC2 instance. You will learn how
to define variables for the EC2 instance type, add validation to these variables, and create additional variables for
volume type and size. With these skills, you'll be able to create an EC2 instance that efficiently utilizes the
resources according to your specifications.

--- 

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview
of what the created solution should deploy:

- Create a variable named `ec2_instance_type` that specifies the type of the EC2 instance. This variable should be of
  type string and default to `t2.micro`.
- Add validation to the instance type variable to ensure that the instance type is either `t2.micro` or `t3.micro`. If a
  different value is used, Terraform should return an error message stating that "Only t2.micro and t3.micro instances
  are supported".
- Create two additional variables to receive both the EC2 volume type and volume size. These variables should have the
  correct types, sensible defaults, and relevant descriptions.
- Create an EC2 instance that leverage that the variables we have created. This instance should retrieve the AMI ID via
  a data source and use the previously defined variables for the instance type and the root block device settings.

--- 

## Step-by-Step Guide

- Define a `variable "ec2_instance_type"` that specifies the type of the EC2 instance. Set its type to `string` and its
  default to `"t2.micro"`. Also add a helpful descrption.
- Add validation to the instance type variable: Add a `validation` block within the variable to ensure that the instance
  type is either `t2.micro` or `t3.micro`. If a different value is used, Terraform should return an error message
  stating that "Only t2.micro and t3.micro instances are supported". This helps maintain the consistency and integrity
  of the infrastructure.
- Add two more variables to receive both the ec2 volume type and volume size. Use the correct type, set sensible
  defaults, and add a relevant description.
  ```hcl
  variable "ec2_volume_type" {
    type = string 
    description = "The size and type of the root block volume for EC2 instances."
    default = "gp3"
  }
  
  variable "ec2_volume_size" {
    type = number 
    descrption = "The size and type of the root block volume for EC2 instances."
    default = 10
  }
  ```
- Create an EC2 instance that leverages the variables we have created. Retrieve the AMI ID via a data source. It uses
  the previously defined variables for the instance type and the root block device settings. This means that the type
  and root block device of the instance can be easily customized by adjusting the variables.

  ```hcl
  resource "aws_instance" "compute" {
    ami = data.aws_ami.ubuntu.id 
    instance_type = var.ec2_instance_type 
    
    root_block_device {
      delete_on_termination = true 
      volume_size = var.ec2_volume_size 
      volume_type = var.ec2_volume_type 
    }
  }
  ```


