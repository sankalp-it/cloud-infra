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
    ami_id  = var.ami_id
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

#Uncomment this and uncomment source_volume_id to use from data
# data "aws_ebs_volume" "existing_volume_1" {
#   most_recent = true

#   filter {
#     name   = "volume-id"
#     # values = ["${var.existing-volume-id}"]
#     values = [${var.existing-volume-id}]

#   }
# }
module "ec2_volume_snapshot" {
  source = "./modules/storage/snapshot"
  providers = {
      aws = aws.east2
  }  
  #source_volume_id = "${data.aws_ebs_volume.existing_volume_1.id}"
  source_volume_id = var.existing-volume-id
}

#creating ebs volume from existing snapshot
module "ec2_data_vol_from_snapshot" {
  source = "./modules/storage/esb-volume"
  depends_on = [
    module.ec2_volume_snapshot
  ]
  providers = {
      aws = aws.east2
  }
  # availability_zone = var.availability_zone
  availability_zone = "us-east-2a"
  esb_volume_size = var.esb_volume_size
  esb_volume_name = var.esb_volume_name
  volume_source_snapshot_id = "${module.ec2_volume_snapshot.esb_volume_snapshot_id}"
}

# resource "aws_ami" "my_new_ami" {
#   name = "new-ami"
#   virtualization_type = "hvm"
#   root_device_name = "/dev/xvda"
  

#   ebs_block_device {
    
#     device_name = "/dev/xvda"

#     # The last Snapshot ID I want
#     snapshot_id = "${module.ec2_volume_snapshot.esb_volume_snapshot_id}"
#     volume_size = 20
#     }
#     tags = {
#       Name = "My-Snap-ami"
#     }
# }



module "ami_from_snapshot" {
  source = "./modules/ami"
  providers = {
      aws = aws.east2
  } 
  depends_on = [
    module.ec2_data_vol_from_snapshot
  ]
  ami_snapshot_id = "${module.ec2_volume_snapshot.esb_volume_snapshot_id}"
  custom_ami_name = var.custom_ami_name
  ami_virtualization_type = var.ami_virtualization_type
  root_device_name = var.root_device_name
  volume_size = var.volume_size
}


module "my_ec2_instance_from_snapshot"{
    source = "./modules/ec2"
    providers = {
      aws = aws.east2
    }
    ami_id  = "${module.ami_from_snapshot.aws_ami_with_root_volume_id}" # correct his to ami id
    instance_type = var.instance_type
    instance_name_prefix = "my-ec21"
    instance_key_name = "${module.aws_key_pair.tf_key_pair_key_name}"
    sg_id = "${module.mod_security_group.tf_security_group_id}"
    //user_data ="${file("ec2-user-data.sh")}"
    # vpc_id = aws_default_vpc.default.vpc_id
    # depends_on = [aws_key_pair.tf_key_pair]
    
}