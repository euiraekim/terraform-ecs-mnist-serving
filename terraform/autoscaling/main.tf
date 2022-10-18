resource "aws_autoscaling_group" "default" {
  desired_capacity = 1
  health_check_type = "EC2"
  launch_configuration = aws_launch_configuration.default.name
  max_size = 2
  min_size = 1
  name = "my-auto-scaling-group"

  target_group_arns = [var.target_group_arn]
  termination_policies = ["OldestInstance"]

  vpc_zone_identifier = var.private_subnet_ids
}
