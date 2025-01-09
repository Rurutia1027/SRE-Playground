# Terraform `import` and Its Lifecycle

## What is `terraform import` ?

`terraform import` brings **existing infrastructure**(provisioned outside of Terraform ) under Terraform's management by
adding it to the state file.

- What `terraform import` Does ?
    - It maps an external resource to a resource block in our Terraform configuration.
    - It does **not modify the actual infrastructure**
    - The imported resource is added to the **state file**, but it does not automatically update our Terraform
      configuration(.tf files).

--- 

## Why Use `terraform import` ?

- To manage pre-existing resources created outside Terraform.
- To avoid resource duplication or conflicts when applying Terraform configurations.
- To synchronize Terraform's state with your existing infrastructure.

--- 

## Understanding the Difference Between data Source and terraform import.

### Key Difference Between data source and terraform import

| **Feature**                | **Data Source**                                                              | **Terraform Import**                                                                     |
|----------------------------|------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| **Purpose**                | Used only to query existing resources, without managing their lifecycle.     | Imports an existing resource into Terraform’s management (state file).                   |
| **State File**             | Writes queried values to the state file, but only as data references.        | Fully writes the resource’s state into the state file and makes it managed by Terraform. |
| **Configuration Required** | Requires a `data` block with filters to query the resource.                  | Requires a corresponding `resource` block; otherwise, `plan` or `apply` will fail.       |
| **Resource Lifecycle**     | Managed externally (e.g., AWS Console) and unaffected by Terraform.          | Fully controlled by Terraform, including lifecycle management.                           |
| **Destroy Capability**     | Cannot destroy the resource because Terraform does not manage its lifecycle. | Can be destroyed using Terraform (e.g., via `terraform destroy`).                        |

### Behavior of data Source

- The data source is **read-only** and is used to query attributes of an existing resource (e.g., AMI ID, VPC ID).
- While the query result is saved in the state file, the resource itself is **not managed by Terraform**.
- Terraform commands like `apply` or `destroy` have no effect on resources referenced by `data sources`.

### Behavior of terraform import

- Adds a Resource to the State File: The `terraform import` commands imports the state of an existing resource into
  Terraform's state file.
- Requires Configuration Synchronization(Manually):
  - After importing a resource, ensure that the Terraform configuration file (.tf) includes a matching resource block(
    here, it depends on different situations, let's talk about it later in next section.).
  - If the resource block and the state file are out of sync, running `terraform plan` or `terraform apply` will result
    in discrepancies and potential unintended changes.
  - **Become Fully Managed by Terraform**: Once imported, the result is **completely managed by current Terraform
    Project**,
    including its **lifecycle(init, create, destroy)**.
  -

### Importing Resources and Updating Configuration

When using `terraform import`, the workflow should be:

- **Import the Resource**:
-

--- 

## `terraform import` Classic Cases Introduction

### Case1: Result already exists in the configuration (but not managed by Terraform)

- **Scenario**: The resource declaration is already present in the .tf file, but it needs to be linked to an existing
  resource in the cloud.
- **Steps**:
  - Import the resource: This updates the Terraform state file to include the existing resource from the cloud
    infrastructure.
  -
  ```shell
  terraform import <RESOURCE_TYPE>.<NAME> <RESOURCE_IDENTIFIER>
  ```
  - After `import`, ensure that the resource in the .tf file matches the imported resource in terms of arguments and
    attributes.
  - Run `terraform plan` to verify consistency.
  - If necessary, apply the configuration to make changes or bring the resource into compliance.

- **KeyNote**: In this case, the .tf configuration **already exists**, and the import command ensures the resource is
  managed by Terraform without destroying or recreating it.

### Case2: Adding a new type of resource not declared in the configuration

- **Scenario**: You want to manage an existing resource in the cloud, but there is not corresponding block in the .tf
  file.
- **Steps**:
  - **Write the resource block** in the .tf file, ensuring it matches the actual configuration of the existing resource.
  - **Import the resource** to associate with Terraform's state file.
  ```shell
  terraform import <RESOURCE_TYPE>.<NAME> <RESOURCE_IDENTIFIER>
  ```
  - Run `terraform plan` to validate that the state and the configuration align.
  - Make necessary changes in the `.tf` file, if needed, and then apply.
- **KeyNote**: In this case, the .tf configuration **must be written first**, because Terraform needs to know how to map
  the imported resource to its state.

### Case3: Replacing an Existing Resource in the Cloud Architecture

### Case4: Moving Resources Between Modules

### Case5: Partial Import for Modular Resources

### Case6: Handling State Drift

### Case7: Splitting / Combining State Files

### Case8: Ignoring Changes to Specific Attributes

### Case9: Handling Sensitive Data with terraform import 