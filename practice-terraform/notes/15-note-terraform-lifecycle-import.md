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

## lifecycle of State Update

Terraform's state file is the **central source of truth** about managed resources. The state file is updated in **two
key stages**:

- **Import Stage**:
    - Adds pre-existing resources to the state file.
    - Makes Terraform aware of resources that it didn't provision.

- **Apply Stage**:
    - Updates or creates resources to match the `.tf` configuration.
    - Writes metadata for all managed resources to the state file.

--- 

## Workflow for terraform import

- **Initialize Terraform**

- **Import Existing Resources**

- **Update Configuration**

- **Plan and Verify**

- **Apply Changes**

--- 

## Why Does import Write to the State File?

* Terraform uses the state file to track resources under its management.
* `terraform import` writes metadata about the provisioned resource to the state file so Terraform can:
    * Recognize it as a managed resource.
    * Include it in future plan and apply operations.

Without this step, Terraform would not know about the resource and might try to recreate it during apply.

--- 

## Key Points on Lifecycle

- **Import Stage**:
    - Adds existing resources to the state file.
    - Does not modify infrastructure or .tf files.

- **Apply Stage**:
    - Reconciles the .tf configuration with the state file and updates the state.

--- 

## Summary Table 

