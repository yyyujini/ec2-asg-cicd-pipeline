locals {
  region                       = var.region
  # autoScaling
  as_name                      = "${var.env}-${var.service_name}-asg"
  as_min_size                  = var.as_min_size
  as_max_size                  = var.as_max_size
  as_desired_capacity          = var.as_desired_capacity
  as_wait_for_capacity_timeout = var.as_wait_for_capacity_timeout
  as_health_check_type         = var.as_health_check_type
  as_launch_template_version   = var.as_launch_template_version
  protect_from_scale_in        = var.protect_from_scale_in
  # launch template
  launch_template_name         = "${var.env}-${var.service_name}-lt"
  launch_template_description  = var.launch_template_description
  instance_name                = "${var.env}-${var.service_name}-ec2"
  // image_id                     = var.image_id
  ami_filters_name             = "${var.env}-packer-${var.service_name}-*"
  image_id                     = data.aws_ami.this.id
  instance_type                = var.instance_type
  key_name                     = var.key_name
  launch_tem_security_groups   = var.launch_tem_security_groups
  iam_instance_profile_arn     = var.iam_instance_profile_arn
  update_default_version       = var.update_default_version
  enable_monitoring            = var.enable_monitoring
  ebs_optimized                = var.ebs_optimized

  # alb
  alb_name                     = "${var.env}-${var.service_name}-alb"
  target_group_arns            = [module.private_alb.target_group_arns[0], module.public_alb.target_group_arns[0]]
  target_group_stickiness      = var.target_group_stickiness
  http_sg_name                 = format("%s-http-sg", var.alb_name)
  internal                     = var.internal
  load_balancer_type           = var.load_balancer_type
  https_listeners              = var.https_listeners
  http_tcp_listeners           = var.http_tcp_listeners
  target_group_name            = "tg-"
  target_groups = [
    {
      name_prefix              = local.target_group_name
      backend_protocol         = var.backend_protocol
      backend_port             = var.backend_port
      target_type              = var.target_type
      stickiness = {
        enabled = local.target_group_stickiness
        type    = "lb_cookie"
      }

    }
  ]
  tags                         = merge(var.tags, { Owner = var.owner, Environment = var.env })
  // target_groups = [
  //   {
  //     name_prefix      = local.target_group_name
  //     backend_protocol = var.backend_protocol
  //     backend_port     = var.backend_port
  //     target_type      = var.target_type
  //     targets = {
  //       ec2 = {
  //         target_id = local.target_id
  //         port      = var.backend_port
  //       }
  //     }
  //     health_check = {
  //       enabled             = true
  //       interval            = 30
  //       path                = var.health_check_url
  //       port                = var.backend_port
  //       healthy_threshold   = 5
  //       unhealthy_threshold = 2
  //       timeout             = 5
  //       protocol            = "HTTP"
  //       matcher             = "200-399"
  //     }
  //     tags = local.tags
  //   }
  // ]
  
  # sg
  http_sg_description             = var.http_sg_description
  http_ingress_cidr_blocks        = var.http_ingress_cidr_blocks
  http_ingress_rules              = var.http_ingress_rules
  http_egress_rules               = var.http_egress_rules

  # remote
  vpc_id                          = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids               = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids              = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  azs                             = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id                   = data.terraform_remote_state.vpc.outputs.default_security_group_id
  
  security_group_id               = data.terraform_remote_state.vpc.outputs.security_group_id
}