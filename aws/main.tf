terraform {
  cloud {
    organization = "sankalp-cloud"

    workspaces {
      name = "aws-cloud-infra-ws"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}
# resource "aws_instance" "my-machine" {
#     provider = aws.west2
#     count = 1
#     ami = var.ami
#     instance_type = var.instance_type
#     tags = {
#         Name = "my-machine-${count.index}"
#     }
# }

module "aws_key_pair" {
  source = "./modules/security/keypair"
  providers = {
      aws = aws.west2
 }
}

module "mod_security_group" {
  source = "./modules/networking/securitygroup"
  providers = {
      aws = aws.west2
 }
}

module "my_aws_instance"{
    source = "./modules/ec2"
    providers = {
      aws = aws.west2
    }
    ami_name  = var.ami_name
    instance_type = var.instance_type
    instance_name_prefix = var.instance_name_prefix
    instance_key_name = "${module.aws_key_pair.tf_key_pair_key_name}"
    sg_id = "${module.mod_security_group.tf_security_group_id}"
    # vpc_id = aws_default_vpc.default.vpc_id
    # depends_on = [aws_key_pair.tf_key_pair]
    
}