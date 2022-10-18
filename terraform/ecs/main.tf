resource "aws_ecs_cluster"  "default" {
  name = "my-ecs-cluster"

  lifecycle {
    create_before_destroy = true
  }
} 
