## Use Configuration to Move Resources
In this tutorial, you will create several AWS resources in a single configuration file and then divide them into compute and security group modules. Then, you will use the moved block to refactor your configuration and update resource IDs, and review the corresponding state changes before you apply the new configuration.

### Initialize and apply the configuration
- `terraform init`
- `terraform apply`

*Test your instance availability with the curl command.*
- `curl $(terraform output -raw public_ip):8080`

### Refactor your configuration
- Remove the AMI data source, the instance resource, and security group resource.
- `mkdir -p modules/compute`
- `cd modules/compute`
- Create a new `main.tf` file in the `compute` directory.
- Then, create a new `outputs.tf` file to capture your instance IP address.

### Create security group module
- Next, create a new directory for your `security_group` module.
- `mkdir ../security_group`
- `cd ../security_group`
- Create a new `main.tf` file in the `security_group` directory.
- Create a new `outputs.tf` file to capture your security group ID.

### Update configuration with modules
- Navigate to the root of your project directory.
- `cd ../..`
- Open the `main.tf` file and add the new module blocks to the end of your configuration.
- Update the `outputs.tf` file in the root directory.

### Reference
https://learn.hashicorp.com/tutorials/terraform/move-config?in=terraform/modules
