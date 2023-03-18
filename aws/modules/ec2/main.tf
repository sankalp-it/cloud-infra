terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

resource "aws_instance" "my-machine" {
    # provider = aws.west2
    count = 1
    ami = var.ami_name
    instance_type = var.instance_type
    tags = {
        Name = "${var.instance_name_prefix}-${count.index}"
    }
    key_name = var.instance_key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [var.sg_id]
    root_block_device {
    delete_on_termination = true
    # iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
    //vpc_id = var.vpc_id
}