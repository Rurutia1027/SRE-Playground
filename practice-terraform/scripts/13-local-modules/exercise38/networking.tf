# this is the module definition:
# The module "vpc" block here defines a Terraform module named 'vpc'
# and the source = './modules/networking' specifies that the module's source files are
# located in the local folder ./modules/networking

# let's review the definition of the module:
# A module in Terraform is a reusable container for resources, and it can be used for both outputting values
# and initializing resources.

module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "13-local-modules-exe38"
  }
}

output "output_vpc_cidr_block" {
  # this output value vpc_cidr_content is not defined in the module "vpc" scope
  # it is declared in the modules/networking/outputs.tf
  # with its variable name as `vpc_cidr_content`
  value = module.vpc.vpc_config.cidr_block
}

output "output_vpc_name" {
  value = module.vpc.vpc_config.name
}