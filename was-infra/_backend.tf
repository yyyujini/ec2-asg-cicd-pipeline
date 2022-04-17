terraform {
  backend "s3" {
    bucket = "devops-tfbackend-dc"
    key    = "was-infra/terraform.tfstate"
    region = "ap-northeast-2"
  }
}