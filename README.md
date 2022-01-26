## Use Configuration to Move Resources
In this tutorial, you will create several AWS resources in a single configuration file and then divide them into compute and security group modules. Then, you will use the moved block to refactor your configuration and update resource IDs, and review the corresponding state changes before you apply the new configuration.

### Initialize and apply the configuration
- `terraform init`
- `terraform apply`

*Test your instance availability with the curl command.*
- `curl $(terraform output -raw public_ip):8080`

### Reference
https://learn.hashicorp.com/tutorials/terraform/move-config?in=terraform/modules
