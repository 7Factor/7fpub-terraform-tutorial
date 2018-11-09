// A reminder that a file like this should never be but into source control
terraform {
  backend "s3" {
    bucket = "7fdev-terraform"
    key    = "us-east-1/terraform.tfstate"
    region = "us-east-1"
  }
}
