resource "aws_alb" "main" {
  name = module.bekk_test_static_json_label.id

  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]

  tags = module.bekk_test_static_json_label.tags

}

resource "aws_alb_target_group" "backend" {
  name        = module.bekk_test_static_json_label.id
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  tags = module.bekk_test_static_json_label.tags

}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "backend" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.backend.id
    type             = "forward"
  }

}
