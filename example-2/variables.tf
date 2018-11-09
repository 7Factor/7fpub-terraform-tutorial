// network config
variable vpc_id {
  description = "The ID of the VPC you'll be installing vault into. We make no assumptions about your networking stack, so you should provide this."
}

variable public_subnets {
  type        = "list"
  description = "The public subnet ID corresponding to the private subnet you'll be installing vault ui into. Again, we make no assumptions. This should be large enough to support your cluster."
}

variable private_subnets {
  type        = "list"
  description = "The private subnet ID you'll be installing vault ui into. Again, we make no assumptions. This should be large enough to support your cluster."
}

variable utility_accessible_sg {
  description = "Pass in the ID of your access security group here."
}

// ec2 config
variable "instance_count" {
  default     = 2
  description = "The number of instances to create. Defaults to two for HA. "
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The type of ec2 instance. Defaults to micro so we don't spend $$$."
}

variable "pem_key" {
  description = "The name of the pem key to associate with your instance."
}

variable cluster_name {
  description = "Name your cluster! This will show up in tags."
}
