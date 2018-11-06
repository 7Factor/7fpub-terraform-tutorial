# Example One

This terraform simply creates an ec2 instance that you can ssh into.

## Commands

The basic run command:

```sh
terraform apply
```

Run with tfvars file:

```sh
terraform apply -var-file=us-east-1.tfvars
```

Clean up after yourself:

```sh
tf destroy
```

With tfvars file:

```sh
tf destroy -var-file=us-east-1.tfvars
```

## How it works

The first configuration, data, grabs the lastest aws linux ami (amazon
machine image). We then configure the aws ec2 instance, passing the ami,
instance type, subnet_id, and key_name. For more information, read the
[docs](https://www.terraform.io/docs/providers/aws/r/instance.html).
Hashicorp provides excellent documentation with examples and clear information
on which parameters are required or optional, and what they do.

## Terraform variables and tfvars files

These items work hand in hand to give you variable control over your
configurations. You can think of terraform variables as how you declare
variables, and tfvars as a way to assign values to those values.


