data "aws_iam_policy_document" "ecs" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "ecs" {
  assume_role_policy = data.aws_iam_policy_document.ecs.json
  name = "my-ecs-instance-role"
}

resource "aws_iam_role_policy_attachment" "ecs" {
  role = aws_iam_role.ecs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "my-ecs-instance-profile"
  role = aws_iam_role.ecs.name
}
