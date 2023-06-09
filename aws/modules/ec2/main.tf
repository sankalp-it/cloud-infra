terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }

}

resource "aws_instance" "my-machine" {
    # provider {
    #   aws = aws.east2
    # }
    # provider {
    #   region = "us-east-1"
    # }
    //count = 1
    ami = var.ami_id
    instance_type = var.instance_type
    # tags = {
    #     Name = "${var.instance_name_prefix}-${count.index}"
    # }
    key_name = var.instance_key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [var.sg_id]
    user_data = var.user_data
    root_block_device {
    delete_on_termination = true
    # iops = 150
    volume_size = 50
    volume_type = "gp2"
    
  }
    //vpc_id = var.vpc_id
}



output "ec2_instance_id" {
  value = aws_instance.my-machine.id
}