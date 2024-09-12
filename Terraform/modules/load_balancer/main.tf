resource "aws_lb" "application_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "network"
  security_groups    = [var.lb_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "private_targets" {
  name     = var.target_group_name
  port     = 31263
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "tcp"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 3
    healthy_threshold   = 3
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_targets.arn
  }
}

resource "aws_lb_target_group_attachment" "private_instance_attachment" {
  for_each         = { for idx, instance_id in var.private_instance_ids : idx => instance_id }
  target_group_arn = aws_lb_target_group.private_targets.arn
  target_id        = each.value
  port             = 80
}