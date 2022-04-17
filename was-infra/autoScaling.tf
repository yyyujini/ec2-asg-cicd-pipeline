module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  # Autoscaling group
  force_delete              = true
  name                      = local.as_name
  min_size                  = local.as_min_size
  max_size                  = local.as_max_size
  desired_capacity          = local.as_desired_capacity
  protect_from_scale_in     = local.protect_from_scale_in
  wait_for_capacity_timeout = local.as_wait_for_capacity_timeout
  health_check_type         = local.as_health_check_type
  launch_template_version   = local.as_launch_template_version
  vpc_zone_identifier       = local.private_subnet_ids
  target_group_arns         = local.target_group_arns
  scaling_policies = {
    my-policy = {
      policy_type               = "TargetTrackingScaling"
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
          resource_label         = "MyLabel"
        }
        target_value = 50.0
      }
    }
  }
  // instance_refresh = {
  //   strategy = "Rolling"
  //   preferences = {
  //     checkpoint_delay       = 600
  //     checkpoint_percentages = [35, 70, 100]
  //     instance_warmup        = 300
  //     min_healthy_percentage = 50
  //   }
  //   triggers = ["tag"]
  // }

  # Launch template
  launch_template_name        = local.launch_template_name
  launch_template_description = local.launch_template_description
  instance_name               = local.instance_name
  image_id                    = local.image_id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  security_groups             = [ local.security_group_id ]
  // security_groups             = local.launch_tem_security_groups
  iam_instance_profile_arn    = local.iam_instance_profile_arn
  update_default_version      = local.update_default_version
  enable_monitoring           = local.enable_monitoring
  ebs_optimized               = local.ebs_optimized
  user_data_base64            = base64encode(data.template_file.userdata.rendered)

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { Name = "ec2-instance" }
    },
    {
      resource_type = "volume"
      tags          = { Name = "ec2-instance" }
    }
  ]

  tags = {
    Environment = "dev"
  }
}