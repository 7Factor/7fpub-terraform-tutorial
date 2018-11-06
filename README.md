# Terraform Starter

## This project serves as a tutorial on terraform. Several examples are listed in increasing levels of complexity.

### A Brief Intro on Terraform

Terraform is known as an "infrastructure-as-code" tool. That means that instead of clicking (and sometimes guessing)
around a console, you write configuration files that specify a state for your infrastructure. This allows you create repeatable,
iterable, source-controlled code that can be peer-reviewed and mature over time just like your application code.

Terraform is the tool we use because it is cloud agnostic meaning you can use with any of the major cloud providers, including
AWS, GCP, and Azure. We generally use AWS exclusively, so for now all of the examples only focus on AWS.

For more information, it is highly recommended you read this [6 part blog series on terraform](https://blog.gruntwork.io/a-comprehensive-guide-to-terraform-b3d32832baca).

### Some notes before you get started

There is some set up you need to do locally before you can run terraform. The following instructions largely assume you
are on mac/linux.

*** TLDR VERSION ***

Just make sure you are in a workspace before you do anything in a shared account. You don't want to step on any ones' toes,
or worse take down prod.

Also note that for learning purposes all files/folders are included (except for .terraform directory), but in a production environment you should gitignore sensitive
files like .pem, .tfvars, and backend.tf.

* Step 1. Install terraform with your favorite installer (we recommend homebrew)

```sh
brew install terraform
```

* Step 2. Install your cloud provider cli tools with your favorite installer (we recommend homebrew)

```sh
brew install awscli
```

* Step 3. Verify that the previous step created a .aws directory at the root (~) level and that you have two files inside,
config and credentials. Running ```ls ~/.aws``` should output something similar to ```config    credentials```.

* Step 4. Paste the following into your config file, used to tell awscli which region to use as default.

```sh
[profile 7f_dev]
output = json
region = <REGION_NAME>
```

* Step 5. Gather your cli creds and paste them into your credentials file, used to authenticate awscli with your desired account.

```sh
[7f_dev]
aws_access_key_id=<YOUR_ACCESS_KEY_ID>
aws_secret_access_key=<YOUR_SECRET_ACCESS_KEY>
```

Note if you ever lose your aws_secret_access_key, you can go to IAM on the AWS console and create a new one for your user
account, assuming you have the necessary permissions.


* Step 6. Export those creds to AWS_PROFILE, an aws specified env var that awscli will use to authenticate.

```sh
export AWS_PROFILE=<YOUR_PROFILE_NAME>
```

* Step 7. Initialize terraform, which will create the state directory terraform uses to keep track of the resources it is managing.

```sh
terraform init
```

Note this step is dependant on your backend.tf file, which comes with this repo. Normally this file is not source controlled
as it contains sensitive information. This file specifies and s3 bucket to use as a backend for storing your terraform state
files. For more information read the [docs](https://www.terraform.io/docs/backends/)

* Step 8. Select your terraform workspace. This is similar to switching to a different git branch. This step is important
so that you don't interfere with other users' resources.

```sh
terraform workspace new <YOUR_WORKSPACE_NAME>
```

At this point you should be able to run any of the examples and watch terraform do its thing. To do this, simply cd into
any of the example folders and run:

```sh
terraform apply
```

Terraform will show the list of resources it will create to match the specifications you made, and then prompt you for
confirmation before running its scripts.
