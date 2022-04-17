terraform {
  backend "s3" {
    bucket = "devops-tfbackend-dc"
    key    = "web-infra/terraform.tfstate"
    region = "ap-northeast-2"
  }
}