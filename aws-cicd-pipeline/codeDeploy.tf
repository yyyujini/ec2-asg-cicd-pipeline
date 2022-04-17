resource "aws_codedeploy_app" "this" {
  compute_platform = local.compute_platform
  name             = local.app_name

  tags = merge(local.cd_app_tags, { Name = local.app_name })
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name               = local.app_name
  deployment_group_name  = local.deployment_group_name
  deployment_config_name = local.deployment_config_name
  service_role_arn       = module.iam[1].iam_role_arn
  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    green_fleet_provisioning_option {
      action = "COPY_AUTO_SCALING_GROUP"
      // action = "DISCOVER_EXISTING"
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 0
    }
  }
  autoscaling_groups = [local.autoscaling_group_id]
  load_balancer_info {
    target_group_info {
      name = local.target_group_name
    }
  }
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  tags = merge(local.cd_group_tags, { Name = local.deployment_group_name })
}