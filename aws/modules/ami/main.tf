terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }

}


resource "aws_ami" "aws_ami_with_root_volume" {
    # name = "new-ami"
    name = var.custom_ami_name
    #virtualization_type = "hvm"
    virtualization_type = var.ami_virtualization_type

    #root_device_name = "/dev/xvda"
    root_device_name = var.root_device_name
    ebs_block_device {
        device_name = var.root_device_name
        # The last Snapshot ID I want
        snapshot_id = var.ami_snapshot_id
        # volume_size = 20
        volume_size = var.volume_size
    }
    tags = {
        # Name = "My-Snap-ami"
        Name = var.custom_ami_name
    }
}

output "aws_ami_with_root_volume_id" {
  value = aws_ami.aws_ami_with_root_volume.id
}