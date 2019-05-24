// A reminder that a file like this should never be but into source control
terraform {
  backend "s3" {
    bucket = "7f-terraform-training"
    key    = "us-east-1/terraform.tfstate"
    region = "us-east-1"
  }
}
