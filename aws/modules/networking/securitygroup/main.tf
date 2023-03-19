# To be able to pass providers to child modules declare the required_providers section within child module

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}


resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "security_group" {
  //name = lookup(var.awsprops, "secgroupname")
  name = "sc2-sample-sg"
  //description = lookup(var.awsprops, "secgroupname")
  description = "sc2-sample-sg"
  //vpc_id = lookup(var.awsprops, "vpc")
  vpc_id = aws_default_vpc.default.id

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

}

  output "tf_security_group_id" {
    value = aws_security_group.security_group.id
  }