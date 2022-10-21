resource "aws_alb" "default" {
  name = "my-alb"
  security_groups = [var.alb_security_group_id]

  subnets = var.public_subnet_ids
}

resource "aws_alb_target_group" "default" {
  name = "my-alb-target-group"
  port = 5000
  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path = "/health"
  }
}

resource "aws_alb_listener" "default" {
  load_balancer_arn = aws_alb.default.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.default.arn
    type = "forward"
  }
}
