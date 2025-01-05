# Backends in Terraform

**Backends define where Terraform stores its state file**

There are multiple types of backends, which can be place into three categories:

- **Local**: the state file is stored in the user's local machine.
- **Terraform Cloud**: the state file is stored in Terraform Cloud. Offers additional features.
- **Third-party remote backends**: the state file is stored in a remote backend different from Terraform Cloud (for
  example S3, Google Cloud Storage, Azure Resource Manager/Blob Storage, among others).

Different backends can offer different functionalities (for example, state locking is not available for all remote
backends) and require different arguments. 