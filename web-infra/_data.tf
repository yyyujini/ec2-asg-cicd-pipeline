data "aws_caller_identity" "current" {}

data "template_file" "userdata" {
  template = file("templates/userdata.sh")
  vars = {
    ACCOUNT_ID   = data.aws_caller_identity.current.account_id
    REGION       = var.region
    ALB_DNS      = data.terraform_remote_state.was-infra.outputs.alb_dns_name
  }
}

data "aws_ami" "this" {
  most_recent      = true
  owners           = ["self"]
  filter {
    name   = "name"
    values = [ local.ami_filters_name ]
  }
}