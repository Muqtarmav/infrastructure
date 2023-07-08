terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.1"
    }
  }
}


provider "aws" {
  region = "eu-west-2"
}


resource "aws_instance" "instance" {
  ami                    = "ami-0eb260c4d5475b901"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = "terraform-key"

  
  tags = {
    Name        = "web_server"
    Environment = "Test"
  }

    depends_on = [ 
        aws_key_pair.my_key
     ]

provisioner "remote-exec" {
  inline = [
    "sudo apt install ansible",
    "sudo pip install ansible",
    "sudo apt-get install -y software-properties-common",
    "sudo apt-add-repository --yes --update ppa:ansible/ansible",
    #"sudo apt install ansible-core",
    "sudo apt install -y git",
    "git clone https://github.com/Muqtarmav/infrastructure.git",
    "cd infrastructure/ansible",
   #"ansible-playbook -i inventory configure_user.yml"
  ]




  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file ("/Users/mac/.ssh/id_rsa")
    host        = aws_instance.instance.public_ip
  }
}

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "instance" {
  name = "instance-sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }

}


resource "aws_key_pair" "my_key" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGfTIb5L/tASG9cpT6lIiO9C6fK8vXnRZYaZ7in9d8ULYbij/XijIV8hKiRNrfGEgeXFnOskqnLCq+polyKFKWa7LozzEKIcgZxryWOek6N67UWLMxGy0jokYA202y8yS9n5WodQw3D/AclENlv0NY6EFskjpvX3MvtS/B0JEwWr7gwC61kzJBp41B/DSQhjlQD7+ZLhnB8y8XiXCgEX8NOAlpqX8GKZqSn047iAxY3b/oIvctDtJHkIlO6x3UlUScH5QwBgXepaKFMJn5CbB6JO5WQd1zyoSCa3pC4V7Cmfwm5JSA19AT9CzdKXXqzBZoVIbfr4SoqcrF/OobI6avq1pdsDkaXqWs0iw4hO8zBZK3bEhftdwCwVoOrg92ByQgMjHH6uSYWeL0gjF01nNFO0+lOC+B4d+o3ltkf0UJXD5fmMMzVPHuTY2vEet1/4lXWLoQp1TyyqmJyljk/4XF2AoMXYZjX4IgvLOyBE91sUj6MEyG8NxlMowV9ZYm4KiKMpBUEPrmqPO3fQ+oXAw3TxCO1hVx1RX/h4K3kuFzeSFgyhLO5ge8S52P/dJnozih4p+cdbulYFY6NVKWogPx3zWfsaAog809tmkybHiQHt4smDFhNVvYxtwA/CW8F1UAyOe4MsXYUbHoZK+94kh9DCfQNHEwCBMfogEL1NeVrw== muqtarmav@gmail.com "
}



locals {
  private_key_content = var.private_key_content
 
}

resource "local_file" "private_key" {
  filename = "${path.module}/private_key.pem"  # Specify the path and filename to save the private key
  content  = local.private_key_content  # Use the private key content from the locals block
}
