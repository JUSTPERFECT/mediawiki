variable "vpc_id" {
  description = "ID of VPC where subnet to be deployed"
  default     = ""
}

variable "subnet_cidr_blocks" {
  description = "CIDR block for the public/private subnet"
  type        = "list"
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "flag to assign public IP or not"
  default     = false
}

variable "availability_zones" {
  description = "az to deploy subnet"
  type        = "list"
  default     = []
}

variable "subnet_name" {
  description = "Name of the Subnet"
  default     = ""
}