// the security group for the web boxes.
// opens port 80 only to load balancer
resource "aws_security_group" "example_2_sg" {
  name        = "example-2-sg-${data.aws_region.current.name}"
  description = "Security group for all example 2 servers in ${data.aws_region.current.name}."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.example_2_lb_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Cluster = "${var.cluster_name}"
    Name    = "Example 2 Boxes"
  }
}

// the security group for the load balancer
// opens port 80 to the internet
resource "aws_security_group" "example_2_lb_sg" {
  name        = "example-2-lb-sg-${data.aws_region.current.name}"
  description = "Security group for the example 2 LB in ${data.aws_region.current.name}."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Cluster = "${var.cluster_name}"
    Name    = "Example 2 LB"
  }
}
