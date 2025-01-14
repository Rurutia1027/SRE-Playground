variable "vpc_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The vpc_dir must contain a valid CIDR block."
  }
}

variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config option must contain a valid CIDR block."
  }
}


variable "subnet_config" {
  type = map(object({
    cidr_block = string
    az         = optional(string)
  }))

  validation {
    condition = alltrue([
      for config in var.subnet_config : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The cidr_block option must contain a valid CIDR block"
  }
}