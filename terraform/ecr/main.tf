resource "aws_ecr_repository" "mnist" {
  name = var.ecr_repo_names
}
