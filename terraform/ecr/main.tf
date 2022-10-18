resource "aws_ecr_repository" "default" {
  count = length(var.ecr_repo_names)
  name = var.ecr_repo_names[count.index]
}
