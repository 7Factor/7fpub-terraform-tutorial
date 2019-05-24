// A simple ec2 instance
// The resources should be broken up into logically named files, but it's nice to see everything in one place when learning

// Required terraform version
terraform {
  required_version = ">=0.10.7"
}

// declare some variables
variable "subnet_id" {
  description = "The id of the subnet to place your instance in."
}

variable "pem_key" {
  description = "The name of the pem key to associate with your instance."
}

variable "vpc_id" {
  description = "The vpc to place your security group in."
}

// data will fetch existing resources based on filters you provide
data "aws_ami" "ec2_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  owners = ["137112412989"]
}

// configure our ec2 instance
resource "aws_instance" "example_1_instance" {
  ami             = "${data.aws_ami.ec2_linux.id}"
  instance_type   = "t2.micro"
  subnet_id       = "${var.subnet_id}"
  key_name        = "${var.pem_key}"
  security_groups = ["${aws_security_group.ssh_sg.id}"]

  tags {
    Name = "Example One Instance"
  }
}

// an sg to allow ssh access from anywhere
resource "aws_security_group" "ssh_sg" {
  name        = "example_1_sg"
  description = "allow ssh from anywhere"
  vpc_id      = "${var.vpc_id}"

  // inbound on ssh port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Example One"
  }
}

// print an output to make ssh'ing easier
output "example_1_ip" {
  value = "${aws_instance.example_1_instance.public_ip}"
}
