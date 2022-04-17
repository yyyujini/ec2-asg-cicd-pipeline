data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "devops-tfbackend-dc"
    key    = "vpc/terraform.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "was-infra" {
  backend = "s3"
  config = {
    bucket = "devops-tfbackend-dc"
    key    = "was-infra/terraform.tfstate"
    region = var.region
  }
}