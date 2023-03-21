terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

#creating and attaching ebs volume

resource "aws_ebs_volume" "data-vol" {
 availability_zone = var.availability_zone
 size = var.esb_volume_size
 tags = {
        Name = var.esb_volume_name
 }

}

output "aws_ebs_volume_id" {
    value = aws_ebs_volume.data-vol.id
}