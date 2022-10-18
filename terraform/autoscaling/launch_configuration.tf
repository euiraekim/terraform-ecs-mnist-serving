resource "aws_launch_configuration" "default" {
  iam_instance_profile = var.ecs_iam_instance_profile_name
  image_id = data.aws_ami.default.id
  instance_type = "t3.small"
  key_name = "keykey"

  lifecycle {
    create_before_destroy = true
  }

  security_groups = [var.web_security_group_id]
  user_data = file("autoscaling/user_data.sh")
}
