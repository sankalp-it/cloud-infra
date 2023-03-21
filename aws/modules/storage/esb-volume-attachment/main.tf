terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}


# Attaching volume to instance
resource "aws_volume_attachment" "ec2-data-vol" {
 device_name = var.device_name
 volume_id = var.esb_volume_id
 instance_id = var.ec2_instance_id
}