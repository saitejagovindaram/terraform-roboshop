terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0"
    }
  }
  backend "s3" {
    bucket = "roboshop-state-sg"
    key = "ansible"
    dynamodb_table = "roboshop-lock"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}