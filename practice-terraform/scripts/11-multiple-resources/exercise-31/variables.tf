variable "subnet_count" {
  type    = number
  default = 2
}

variable "ec2_instance_count" {
  type    = number
  default = 2
}

variable "ec2_instance_config_list" {
  type = list(
    object({
      instance_type = string
      ami           = string
  }))

  default = []

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instances are allowed."
  }

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["nginx", "ubuntu"], config.ami)
    ])

    error_message = "At least one of the provided \"ami\" values is not supported. \nSupported \"ami\" values : \"nginx\", \"ubuntu\". "
  }
}