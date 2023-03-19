# terraform {
#   cloud {
#     organization = "sankalp-cloud"

#     workspaces {
#       name = "aws-cloud-infra-ws"
#     }
#     # providers = {
#     #   aws = aws.east1
#     # }
#   }
#   # required_providers {
#   #   aws = {
#   #     source = "hashicorp/aws"
#   #     version = "4.58.0"
#   #   }
#   # }
# }

# provider "aws" {
#   shared_credentials_files = ["~/.aws/credentials"]
#   region = "us-west-2"
#   alias="west21"
# }


module "aws_key_pair" {
  source = "./modules/security/keypair"
  providers = {
      aws = aws.east2
 }
}

module "mod_security_group" {
  source = "./modules/networking/securitygroup"
  providers = {
      aws = aws.east2
 }
}

module "my_aws_instance"{
    source = "./modules/ec2"
    providers = {
      aws = aws.east2
    }
    ami_name  = var.ami_name
    instance_type = var.instance_type
    instance_name_prefix = var.instance_name_prefix
    instance_key_name = "${module.aws_key_pair.tf_key_pair_key_name}"
    sg_id = "${module.mod_security_group.tf_security_group_id}"
    # vpc_id = aws_default_vpc.default.vpc_id
    # depends_on = [aws_key_pair.tf_key_pair]
    
}