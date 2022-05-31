terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
    #access_key = AWS_ACCESS_KEY_ID
    #secret_key = AWS_SECRET_ACCESS_KEY
}


resource "aws_instance" "my-ec2" {
      ami = "ami-0022f774911c1d690"
      instance_type = "t2.micro"
}

   