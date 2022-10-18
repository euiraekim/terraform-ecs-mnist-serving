variable "alb_sg_name" {
  type = string
  default  = "alb-security-group"
}

variable "bastion_sg_name" {
  type = string
  default = "bastion-security-group"
}

variable "web_sg_name" {
  type = string
  default = "web-security-group"
}

variable "vpc_id" {
  type = string
}
