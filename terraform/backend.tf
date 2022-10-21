terraform {
  backend "s3" {
    bucket = "euirae-kim-tfstate"
    key = "terraform/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "terraform-lock"
  }
}
