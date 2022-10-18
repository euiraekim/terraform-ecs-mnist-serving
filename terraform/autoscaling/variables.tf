variable "ecs_iam_instance_profile_name" {
  type = string
}

variable "web_security_group_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}
