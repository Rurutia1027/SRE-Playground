# What's IAC

- **IaC: Provisioning and managing Infrastructure through code instead of manually.**
![Traditional Manual vs. IaC](./images/iac-1.png)

- **Traditional Manually Console Operation Issues**
  * Hard to reproduce large infrastructure.
  * Hard to track and revert changes. 
  * Imperative rather than declarative. 
  * Very error-prone in terms of configuration. 
  
- **Terraform Benefits vs. Traditional Manually Console Operations**
  * IaC tools normally runs on a CI/CD environment. 
  * Infrastructure is version controlled. 
  * Easier to spot and fix configuration issues. 
  * Declarative rather than imperative. 


**Infrastructure as Code(IaC)** is a practice in DevOps where infrastructure configurations are managed and provisioned using code. This approach replaces manual processes for configuring hardward or cloud resources, enabling: 

- **Version Control**: Track changes to infrastructure like you do with application code. 
- **Automation**: Provision and manage infrastructure with scripts instead of manual actions. 
- **Consistency**: Reduce configuration drift and ensure environments are predictable. 
- **Efficiency**: Deploy and scale infrastructure faster using repeatable scripts. 

There are series of IaC tools: **Terraform**, **AWS CloudFormation**, **Ansible**, and **Pulumi**. 

---

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


--- 

## Benefits that Terraform Bring

### Better cost management

* Resources, environments, and complex infrastructures can ben easily created and destroyed. 
* Automation considerably frees up the time of developers and infrastructure maintainers. 
* Tagging strategies and requirements can be easily implemented across entire infrastructure. 
* It becomes much easier to obtain an overview of all resources created by a specific IaC project. 

### Improved reliability
* Well-developed IaC tools guarantee a consistent behavior. 
* IaC tools provide multiple ways to deploying configurations: locally, as part of a CI/CD pipeline, triggered via API calls. 
* IaC tools validate infrastructure configuration as part of the deployment process. 

### Improved consistency & scalability
* Infrastructure can be easily copied and deployed multiple times with the same structure. 
* Modules can be created and made publicly or privately available. 
* Different environments can be created based on the same / similar configuration files. 
* Resource counts can be easily increased or decreased when needed. 

### Improved deployment process
* Automation saves a lot of time and effort when deploying infrastructure. 
* Prevents configuration drift by identifying and reverting unexpected changes. 
* Creating, updating and destroying resources becomes fullly integrated with other CI/CD tasks. 
* Changes to infrastructure are version controlled, being easier to revert in case of incompatibility or error. 
  
### Fewer human errors
* The planning stage shows all the changes that are expected to be carried out, and can be inspected by engineers. 
* Connecting and integrating different resources becomes more intuitive due to developer-friendly identifiers. 
* Many IaC tools support validators and interigy checks with the custom conditions. 
* Many IaC tools support protection rules agains deletion of critical resources. 
  
### Improved security strategies. 
* Validation and integrity checks can be used to ensure the infrastructure compiles with security requirements. 
* Shared infrastructure modules are normally maintained by teams with a strong focus on securing these resources.  
* Security strategies(for example, IAM users, roles and their respective policies) can also be configure via IaC tools.  
* The infrastructure configuration files can be inspected by security software for vulnerabilities. 

### Self documenting infrastructure
* The created infrastructure is the infrastructure documented in the code. 
* Many IaC tools allows detailed inspection of the resources created. 
* Run logs are normally stored for a period of time, allowing inspection in case of any errors or unwanted changes. 

