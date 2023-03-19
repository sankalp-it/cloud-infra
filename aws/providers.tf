
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-east-1"
    # To make it work with Terraform  cloud I needed to comment the below line
    # This profile correspods to credentials file (AWS)
    # Need to check how to make Terracloud work with profiles
    # or Local work without profile
    # Terracloud work by using the AWS kets defined as workspace variables
    # profile = "cloud19-tf-user-tf"
    #alias = "east2"
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-east-2"
    # To make it work with Terraform  cloud I needed to comment the below line
    # This profile correspods to credentials file (AWS)
    # Need to check how to make Terracloud work with profiles
    # or Local work without profile
    # Terracloud work by using the AWS kets defined as workspace variables
    # profile = "cloud19-tf-user-tf"
    alias = "east2"
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-west-2"
    # To make it work with Terraform  cloud I needed to comment the below line
    # This profile correspods to credentials file (AWS)
    # Need to check how to make Terracloud work with profiles
    # or Local work without profile
    # Terracloud work by using the AWS kets defined as workspace variables
    # profile = "cloud19-tf-user-tf"
    alias = "west2"
}