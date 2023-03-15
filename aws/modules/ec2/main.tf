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
}