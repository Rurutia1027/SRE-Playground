# What's IAC

- **IaC: Provisioning and managing Infrastructure through code instead of manually.**
![resources](./images/resources-pipeline.png)

![Traditional Manual vs. IaC](./images/iac-1.png.png)

- **Traditional Manually Console Operation Issues**
  * Hard to reproduce large infrastructure.
  * Hard to track and revert changes. 
  * Imperative rather than declarative. 
  * Very error-prone in terms of configuration. 



**Infrastructure as Code(IaC)** is a practice in DevOps where infrastructure configurations are managed and provisioned using code. This approach replaces manual processes for configuring hardward or cloud resources, enabling: 

- **Version Control**: Track changes to infrastructure like you do with application code. 
- **Automation**: Provision and manage infrastructure with scripts instead of manual actions. 
- **Consistency**: Reduce configuration drift and ensure environments are predictable. 
- **Efficiency**: Deploy and scale infrastructure faster using repeatable scripts. 

There are series of IaC tools: **Terraform**, **AWS CloudFormation**, **Ansible**, and **Pulumi**. 

## What's Terraform 
**Terraform** is an open-source Infrastructure as Code tool developed by HashiCorp. It allows you to define, manage, and provision cloud and on-premises infrastructure using declarative configuration files. 

### Terraform Key Features
- **Provider Agnostic**: Supports AWS, Azure, GCP, and many other providers. 
- **State Management**: Keeps track of our infrastructure's current state in a state file.
- **Modular Design**: Allows us to create reusable modules for common infrastructure components. 
- **Declarative Syntax**: Define "what" we want instead of "how" to do it using **HashiCorp Configuration Language(HCL)**.
- **Plan and Apply**: Preview changes before applying them to our infrastructure. 

### Why Use Terraform? 
* Simplifies multi-cloud deployments. 
* Automatesz resource creation and scaling. 
* Supports CI/CD for infrastructure. 

## What's AWS CloudFormation 
**AWS CloudFormation** is a service provided by Amazon Web Service(AWS) that enables you to define and provision AWS resources using templates. It's AWS's native IaC tool.

### AWS CloudFormation Key Features 
- **Declarative Templates**: Use YAML or JSON to define the desired state of AWS resources. 
- **Integration**: Seamlessly works with other AWS services. 
- **Stack Management**: Group related resources into stacks for easier management. 
- **Drift Detection**: Identify changes to resources that deviate from the template. 

### Why Use AWS CloudFormation?
* Automate the setup of complex AWS environments.
* Maintains consistency across deployments. 
* Supports compliance by enforcing approved configuraitons. 

