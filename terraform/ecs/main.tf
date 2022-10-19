resource "aws_ecs_cluster"  "default" {
  name = "my-ecs-cluster"

  lifecycle {
    create_before_destroy = true
  }
} 

resource "aws_ecs_task_definition" "default" {
  container_definitions = file("task_definitions.json")
  family = "mnist"
}

resource "aws_ecs_service" "worker" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.default.arn

  desired_count   = 2

  lifecycle {
    ignore_changes = [desired_count]
  }
}