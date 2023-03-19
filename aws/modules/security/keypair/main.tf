terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}


resource "aws_key_pair" "tf-key-pair" {
    key_name = "tf-key-pair"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits  = 4096
}
resource "local_file" "tf-key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "tf-key-pair"
}

output "tf_key_pair_key_name" {
  value = aws_key_pair.tf-key-pair.key_name
}