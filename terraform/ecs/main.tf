resource "aws_ecs_cluster"  "default" {
  name = "my-ecs-cluster"

  lifecycle {
    create_before_destroy = true
  }
} 

resource "aws_ecs_task_definition" "default" {
  container_definitions = file("ecs/task_definitions.json")
  family = "mnist"
}

resource "aws_ecs_service" "default" {
  name = "my-service"
  cluster = aws_ecs_cluster.default.id
  depends_on = [aws_iam_role_policy_attachment.ecs]
  task_definition = aws_ecs_task_definition.default.arn

  desired_count = 2

  lifecycle {
    ignore_changes = [desired_count]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = "mnist"
    container_port = 5000
  }
}
