terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.0"
}


data "aws_availability_zones" "available" {
  state = "available"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = module.vpc.public_subnets[0]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_8080.id]
  user_data              = <<-EOF
               #!/bin/bash
               echo "Hello, World" > index.html
               nohup busybox httpd -f -p 8080 &
               EOF
  tags = {
    Name = "terraform-learn-move-ec2"
  }
}

resource "aws_security_group" "sg_8080" {
  vpc_id = module.vpc.vpc_id
  name   = "terraform-learn-move-sg"
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
