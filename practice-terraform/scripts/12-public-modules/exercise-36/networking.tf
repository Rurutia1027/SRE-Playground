data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  cidr            = "10.0.0.0/16"
  name            = "12-public-modules-exercise35"
  azs             = data.aws_availability_zones.azs.names
  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.128.0/24"]

  tags = local.common_tags
}


output "availables" {
  value = data.aws_availability_zones.azs.names
}