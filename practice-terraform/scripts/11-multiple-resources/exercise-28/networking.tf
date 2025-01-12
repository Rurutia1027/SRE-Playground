locals {
  project = "11-multiple-resources-exercise28"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Project = local.project
    Name    = local.project
  }
}

# subnets declaration
resource "aws_subnet" "main" {
  count = var
}
