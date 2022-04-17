service_name = "dcc-was"
service_version = "v0.1"
env          = "ap-dev"
owner        = "dcc"
region       = "ap-northeast-2"
tags         = {}

#autoScaling
// as_name                      = "example-asg"
as_min_size                  = 0
as_max_size                  = 4
as_desired_capacity          = 2
as_wait_for_capacity_timeout = 0
as_health_check_type         = "EC2"
as_launch_template_version   = "$Latest"
protect_from_scale_in        = true
# launch template
// launch_template_name         = "example-asg"
launch_template_description  = "Launch template example"
// instance_name                = "launch-template-ec2"
// image_id                     = "ami-034cc34bac6d0d564"
instance_type                = "t2.micro"
key_name                     = "Mac-DC"
launch_tem_security_groups   = ["sg-08ff15cf0a0d68deb"]
iam_instance_profile_arn     = "arn:aws:iam::014842949473:instance-profile/admin-full-access"
update_default_version       = true
enable_monitoring            = false
ebs_optimized                = false

# alb
alb_name                     = "dcc"
internal                     = true
load_balancer_type           = "application"
target_type                  = "instance"
target_group_stickiness      = true
backend_protocol             = "HTTP"
backend_port                 = 8080
health_check_url             = "/"
https_listeners              = [
  {
    port               = 443
    protocol           = "HTTPS"
    certificate_arn    = "arn:aws:acm:ap-northeast-2:014842949473:certificate/f4c51555-7023-4be0-98ec-a962f8750a6c"
    fixed_response = {
      content_type = "text/plain"
      message_body = "Not found"
      status_code  = "403"
    }
  }
]
http_tcp_listeners           = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
]

# s3
// bucket_name                     = "dcc-test-s3-tf"
acl_type                        = "private"
force_destroy                   = true
versioning                      = { enabled = true }

# efs
throughput_mode                 = "bursting"
// throughput_mode                 = "provisioned"
provisioned_throughput_in_mibps = 0
performance_mode                = "generalPurpose"
// performance_mode                = "maxIO" 
encrypted                       = true
kms_key_id                      = ""
efs_security_groups             = ["sg-08ff15cf0a0d68deb"]
efs_backup_policy               = "ENABLED"

# sg
http_sg_description             = "HTTP Security group for Bastion EC2 instance"
http_ingress_cidr_blocks        = ["0.0.0.0/0"]
http_ingress_rules              = ["http-80-tcp"]
http_egress_rules               = ["all-all"]
