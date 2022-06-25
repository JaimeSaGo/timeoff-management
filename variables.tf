variable "image_id" {
  description = "Image ID used on EC2"
  type        = string
  default     = "ami-0c9756b13d73e2501" # | "ami-03628f80e933de0b0" #Ubuntu 22.04 LTS
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0047d70bf86bdf7ef"
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Server name"
  type        = string
  default     = "timeoff-server"
}

variable "instance_type" {
  description = "AWS EC2 type"
  type        = string
  default     = "t3.large"
}

variable "private_ip" {
  description = "AWS private IP"
  type        = string
  default     = "172.31.10.210"
}

variable "subnet_id" {
  description = "AWS Subnet ID"
  type        = string
  default     = "subnet-06c309b2a13051e40"
}

variable "iam_policy_name" {
  description = ""
  type        = string
  default     = ""
}

variable "key_name" {
  description = "AWS key pair name"
  type        = string
  default     = "TimeOff-server"
}