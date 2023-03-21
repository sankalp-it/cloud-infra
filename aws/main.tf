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

module "my_ec2_instance"{
    source = "./modules/ec2"
    providers = {
      aws = aws.east2
    }
    ami_name  = var.ami_name
    instance_type = var.instance_type
    instance_name_prefix = var.instance_name_prefix
    instance_key_name = "${module.aws_key_pair.tf_key_pair_key_name}"
    sg_id = "${module.mod_security_group.tf_security_group_id}"
    user_data ="${file("ec2-user-data.sh")}"
    # vpc_id = aws_default_vpc.default.vpc_id
    # depends_on = [aws_key_pair.tf_key_pair]
    
}
#creating ebs volume
module "ec2_secondary_data_vol" {
  source = "./modules/storage/esb-volume"
  providers = {
      aws = aws.east2
  }
  availability_zone = var.availability_zone
  esb_volume_size = var.esb_volume_size
  esb_volume_name = var.esb_volume_name
}

#Attaching created volume to ec2 instance created above
module "ec2_volume_attachment" {
  source = "./modules/storage/esb-volume-attachment"
  providers = {
      aws = aws.east2
  }
  device_name = var.device_name
  esb_volume_id = "${module.ec2_secondary_data_vol.aws_ebs_volume_id}"
  ec2_instance_id = "${module.my_ec2_instance.ec2_instance_id}"
}

