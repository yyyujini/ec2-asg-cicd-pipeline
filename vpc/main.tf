module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name                 = local.name
  cidr                 = local.cidr
  private_subnets      = local.private_subnets
  public_subnets       = local.public_subnets
  azs                  = local.azs

  enable_ipv6          = local.enable_ipv6
  enable_nat_gateway   = local.enable_nat_gateway
  enable_dns_hostnames = local.enable_vpc_enable_dns_hostnames
  single_nat_gateway   = local.single_nat_gateway

  public_subnet_tags   = local.public_subnet_tags
  private_subnet_tags  = local.private_subnet_tags

  tags                 = local.tags
  vpc_tags             = local.vpc_tags
}

module "service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sample-sg"
  description = "Security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["all-tcp"]
  egress_rules             = ["all-all"]

}