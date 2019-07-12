// application load balancer
resource "aws_lb" "example_2_lb" {
  name               = "example-2-lb-${data.aws_region.current.name}"
  load_balancer_type = "application"

  subnets = [
    var.public_subnets,
  ]

  security_groups = [
    aws_security_group.example_2_lb_sg.id,
  ]

  tags = {
    Name    = "Example 2 LB"
    Cluster = var.cluster_name
  }
}

// associated target group
resource "aws_lb_target_group" "example_2_lb_target" {
  name     = "example-2-lb-${data.aws_region.current.name}-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

// attach to our ec2's
resource "aws_lb_target_group_attachment" "example_2_lb_target_attachments" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.example_2_lb_target.arn
  target_id        = element(aws_instance.example_2_instance.*.id, count.index)
  port             = 80
}

// create a listener on standard port 80
resource "aws_lb_listener" "example_2_lb_listener" {
  load_balancer_arn = aws_lb.example_2_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.example_2_lb_target.arn
    type             = "forward"
  }
}
