data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "devops-tfbackend-dc"
    key    = "vpc/terraform.tfstate"
    region = var.region
  }
}