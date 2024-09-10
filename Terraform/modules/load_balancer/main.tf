resource "aws_lb" "application_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "private_targets" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 5
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_targets.arn
  }
}

resource "aws_lb_target_group_attachment" "private_instance_attachment" {
  count            = length(var.private_instance_ids)
  target_group_arn = aws_lb_target_group.private_targets.arn
  target_id        = element(var.private_instance_ids, count.index)
  port             = 80
}