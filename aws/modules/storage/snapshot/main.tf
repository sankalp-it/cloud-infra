terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

resource "aws_ebs_snapshot" "esb_volume_snapshot" {
  volume_id = var.source_volume_id
}

output "esb_volume_snapshot_id" {
  value = aws_ebs_snapshot.esb_volume_snapshot.id
}