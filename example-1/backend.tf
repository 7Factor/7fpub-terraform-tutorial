terraform {
  backend "s3" {
    bucket = "7fdev-terraform"
    key    = "us-east-1/terraform.tfstate"
    region = "us-east-1"
  }
}
