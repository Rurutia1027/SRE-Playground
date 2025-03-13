# Terraform AWS Elastic Beanstalk Module 🚀

![Terraform](https://img.shields.io/badge/Terraform-v1.3%2B-blue?style=for-the-badge&logo=terraform) ![AWS](https://img.shields.io/badge/AWS-Elastic%20Beanstalk-orange?style=for-the-badge&logo=amazon-aws)

This repository contains a **Terraform module** to provision an **AWS Elastic Beanstalk environment**. It provides a
streamlined way to deploy scalable and resilient applications on AWS.

---

## Key Features ✨

- Easily orchestrate Elastic Beanstalk environments.
- Comprehensive support for network and application configurations.
- Supports custom IAM policies, health checks, and auto-scaling.
- Includes examples for getting started quickly.

---

## Usage 🛠️

For a complete example, see `examples/complete`.

```hcl
provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "x.x.x"

  cidr_block = "172.16.0.0/16"
  context    = module.this.context
}

module "elastic_beanstalk_environment" {
  source = "../../"

  description = var.description
  region      = var.region
  vpc_id      = module.vpc.vpc_id

  application_port    = var.application_port
  solution_stack_name = var.solution_stack_name

  context = module.this.context
}
```

> **Important:** Ensure that modules are pinned to specific versions in production.

---

## Makefile Targets 🧰

| Target | Description         |
|--------|---------------------|
| `help` | Help screen         |
| `lint` | Lint terraform code |

---

## Requirements 📋

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.3   |
| aws       | >= 4.0   |
| random    | >= 3.5.1 |

---

## License 📜

This project is licensed under the [Apache License 2.0](./LICENSE).

---

## Contributing 🤝

We welcome contributions! Feel free to submit issues or pull requests to improve this module.

---

## Author 🧑‍💻

This module was lovingly crafted by [Rurutia1027 & Rembrandt777].