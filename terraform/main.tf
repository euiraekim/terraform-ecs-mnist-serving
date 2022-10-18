module "init" {
  source = "./init"
}

module "vpc" {
  source = "./vpc"
}

module "sg" {
  source = "./sg"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./alb"

  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  alb_security_group_id = module.sg.alb_security_group_id
}

module "autoscaling" {
  source = "./autoscaling"
  
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn = module.alb.target_group_arn
  web_security_group_id = module.sg.web_security_group_id
  ecs_iam_instance_profile_name = module.ecs.ecs_iam_instance_profile_name  
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source = "./ecs"
}

