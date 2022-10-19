resource "aws_launch_configuration" "default" {
  iam_instance_profile = var.ecs_iam_instance_profile_name
  image_id = "ami-0dfe299a8a7fe500e"
  instance_type = "t3.medium"
  key_name = "keykey"

  lifecycle {
    create_before_destroy = true
  }

  security_groups = [var.web_security_group_id]
  user_data = file("autoscaling/user_data.sh")
}
