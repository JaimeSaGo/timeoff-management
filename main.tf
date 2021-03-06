provider "aws" {
  region = var.region
  profile = "default"
}

locals {
  tags = {
    Name          = "Time_Management_Server"
    App           = "TimeOff"
    Environment   = "Dev"
    BusinessOwner = "lv_Js@hotmail.com"
  }
}

################################################################################
# Supporting Resources
################################################################################

## Qlik AMI ##
data "aws_ami" "timeoff_server" {
  most_recent = true
  owners      = ["self"] # amazon, aws-marketplace or self

  filter {
    name   = "image-id"
    values = [var.image_id]
  }
}

## SG ##
module "security_group" {
  source  = "/modules/sg_security_group"

  name        = var.name
  description = "Security group for Qlik usage with EC2 instance"
  vpc_id      = var.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "SSH access"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  # egress
  egress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "all"
      description = "All traffic out"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = local.tags
}

################################################################################
# EC2 Module
################################################################################


module "ec2" {
  source = "/modules/ec2_instance"

  name                        = var.name
  ami                         = data.aws_ami.timeoff_server.id
  instance_type               = var.instance_type
  availability_zone           = var.availability_zone
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true
  hibernation                 = true
  key_name                    = var.key_name
  user_data                   = file("user_data.tpl")
  private_ip                  = var.private_ip

  enable_volume_tags = true
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      volume_tags = local.tags
    },
  ]

volume_tags = local.tags
tags = local.tags
}

## Interface ##

resource "aws_network_interface" "this" {
  subnet_id = var.subnet_id
}

module "ec2_network_interface" {
  source = "/modules/ec2_instance"

  name = "${var.name}-network-interface"

  ami           = data.aws_ami.timeoff_server.id
  instance_type = var.instance_type

  network_interface = [
    {
      device_index          = 0
      network_interface_id  = aws_network_interface.this.id
      delete_on_termination = false
    }
  ]

  tags = local.tags
}

