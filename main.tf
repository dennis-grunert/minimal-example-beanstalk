locals {
  vpc_id     = "vpc-changeme"
  subnet_ids = "subnet-changeme,subnet-changeme,subnet-changeme"
}

provider "aws" {
  region = "eu-central-1"
}