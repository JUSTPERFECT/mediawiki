variable "region" {
  default = "ap-southeast-2"
}

variable "vpc_id" {
  default = "vpc-b86d30df"
}

variable "lc_name" {
  description = "name of launch configuration"
  default     = "mediawiki"
}

variable "image_id" {
  description = "image to be used for asg"
  default     = "ami-092d0ddc9e0c0a7c1"
}

variable "associate_public_ip_address" {
  description = "Launching instances with public IP"
  default     = false
}

variable "asg_name" {
  description = "name of autoscaling group"
  default     = "mediawiki"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
  default     = "EC2"
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = 1
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  default     = false
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "ec2_instance_type" {
  description = "Instance type to be used for asg"
  default     = "t2.micro"
}

variable "iam_instance_profile" {
  description = "IAM instance profile need to be used for the instances"
  default     = "ec2-instance-role"
}

variable "ec2_key_name" {
  description = "EC2 instance key name to be used"
  default     = "flux7-test"
}

variable "ec2_asg_min" {
  description = "Autoscaling group minimum instance count"
  default     = "1"
}

variable "key_name" {
  default = "mediawiki"
}

variable "ec2_asg_max" {
  description = "Autoscaling group maximum instance count"
  default     = "1"
}

variable "ec2_asg_desired" {
  description = "Autoscaling group desired instance count"
  default     = "1"
}

variable "create_elb" {
  description = "if true, ELB will be created"
  default     = true
}

variable "elb_name" {
  description = "classic load balancer name to be created"
  default     = ""
}

variable "username" {
  default = ""
}

variable "subnet_ids" {
  description = "subnets associated with elb"
  type        = "list"
  default     = ["subnet-bd5563f4", "subnet-b93c88e1"]
}

variable "elb_internal" {
  description = "Flag to define whether ELB is internal or external"
  default     = true
}

variable "security_groups" {
  description = "security groups to be attached with LB"
  type        = "list"
  default     = []
}

variable "cross_zone_load_balancing" {
  description = "Flag to enable cross zone load balancing"
  default     = true
}

variable "idle_timeout" {
  description = "The time given for connection to be idle"
  default     = 300
}

variable "connection_draining" {
  description = "Flag to enable connection draining"
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time given for connections to drain"
  default     = 300
}

variable "listener" {
  description = "list of elb listeners"
  type        = "list"

  default = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
  ]
}

variable "access_logs" {
  description = "list of elb access logs"
  type        = "list"
  default     = []
}

variable "health_check" {
  description = "list of elb health checks"
  type        = "list"
  default     = []
}

variable "password" {
  default = ""
}

variable "rds_identifier" {
  default = "mediawiki"
}
