terraform {
  required_version = ">=0.12.20"
  backend "s3" {
    bucket         = "my-vault-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
