locals {
  region                   = var.region

  ########## CODEPIPELINE ###########
  codepipeline_name                   = "${var.env}-${var.service_name}-cpl"
  codepipeline_source_connection_name = "${var.env}-${var.service_name}-codeStar"
  codepipeline_s3_artifact_name       = "${var.env}-${var.service_name}-artifact-s3-dc"
  suorce_provider                     = var.suorce_provider
  // codepipeline_source_config_github = {
  //   ConnectionArn    = local.suorce_provider == "CodeCommit" ? null : aws_codestarconnections_connection.this[0].arn
  //   FullRepositoryId = var.GitHubFullRepositoryId
  //   BranchName       = var.GitHubBranchName
  // }
  ## 미리 생성된 Github이 있을 경우
  codepipeline_source_config_github = {
    ConnectionArn    = local.suorce_provider == "CodeCommit" ? null : var.ConnectionArn
    FullRepositoryId = var.GitHubFullRepositoryId
    BranchName       = var.GitHubBranchName
  }
  codepipeline_source_config_codecommit = {
    RepositoryName = var.CodeCommitRepositoryName
    BranchName     = var.CodeCommitBranchName
  }
  codepipeline_build_config = {
    ProjectName = local.codebuild_name
  }
  codepipeline_deploy_config = {
    ApplicationName     = local.app_name
    DeploymentGroupName = local.deployment_group_name
  }
  cpl_tags = merge(var.cpl_tags, { Owner = var.owner, Environment = var.env })

  ############## CODEBUILD ##############
  codebuild_name        = "${var.env}-${var.service_name}-cb"
  codebuild_timeout     = var.codebuild_timeout
  codebuild_envs        = var.codebuild_envs
  codebuild_cache_type  = var.codebuild_cache_type
  codebuild_cache_modes = var.codebuild_cache_modes
  source_type           = var.source_type
  artifact_type         = var.artifact_type
  cb_tags               = merge(var.cb_tags, { Owner = var.owner, Environment = var.env })
  
  ############## CODEDEPLOY #############
  app_name              = "${var.env}-${var.service_name}-cd-app"
  compute_platform      = var.compute_platform
  cd_app_tags           = merge(var.cd_app_tags, { Owner = var.owner, Environment = var.env })
  deployment_group_name = "${var.env}-${var.service_name}-cd-group"
  cd_group_tags         = merge(var.cd_group_tags, { Owner = var.owner, Environment = var.env })
  deployment_config_name = var.deployment_config_name

  ############ IAM ############
  role_name               = [format("%s-role", local.codebuild_name), format("%s-role", local.deployment_group_name), format("%s-role", local.codepipeline_name)]
  trusted_role_services   = [var.cb_trusted_role_services, var.cd_trusted_role_services, var.cpl_trusted_role_services]
  custom_role_policy_arns = [var.cb_custom_role_policy_arns, var.cd_custom_role_policy_arns, var.cpl_custom_role_policy_arns]

  ################# VPC #################
  vpc_id                  = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets                 = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  security_group_ids      = [data.terraform_remote_state.vpc.outputs.default_security_group_id]

  ################# ASG #################
  autoscaling_group_id    = data.terraform_remote_state.alb.outputs.autoscaling_group_id
  target_group_name        = data.terraform_remote_state.alb.outputs.target_group_name
}

