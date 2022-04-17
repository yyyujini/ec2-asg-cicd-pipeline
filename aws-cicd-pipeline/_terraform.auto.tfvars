service_name = "dcc-demo"
env          = "dev"
name         = "dcc"
owner        = "dcc"
region       = "ap-northeast-2"

############## CodeBuild ##############
// cb_name           = "codebuild-as"
codebuild_timeout = "10"
codebuild_envs = {
  compute_type    = "BUILD_GENERAL1_SMALL"
  image           = "aws/codebuild/standard:4.0"
  type            = "LINUX_CONTAINER"
  privileged_mode = true
}
codebuild_cache_type  = "LOCAL"
codebuild_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE"]
source_type           = "CODEPIPELINE"
artifact_type         = "CODEPIPELINE"
cb_trusted_role_services = ["codebuild.amazonaws.com"]
cb_custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
  "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
]
cb_tags               = {}

############# CODEDEPLOY #############
// cd_app_name              = "codeDeploy-app-dc"
compute_platform         = "Server"
// cd_group_name            = "codeDeploy-group-dc"
cd_trusted_role_services = ["codedeploy.amazonaws.com"]
cd_custom_role_policy_arns = [
  "arn:aws:iam::014842949473:policy/CodeDelpoyAutoScaling",
  "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole",
]
deployment_config_name   = "CodeDeployDefault.OneAtATime"
// CodeDeployDefault.AllAtOnce : 모든 트래픽을 그린으로 한번에 전환
// CodeDeployDefault.HalfAtATime : 절반의 트래픽을 그린으로 전환
// CodeDeployDefault.OneAtATime : 한 번에 한 인스턴스에만 애플리케이션 개정을 배포
cd_app_tags              = {}
cd_group_tags            = {}

############ CODEPIPELINE ############
// cpl_name        = "dev-dc"
// suorce_provider = "CodeCommit"
suorce_provider = "CodeStarSourceConnection"
# GitHub
GitHubFullRepositoryId = "DACHANCHOI/test"
GitHubBranchName       = "main"
ConnectionArn          = "arn:aws:codestar-connections:ap-northeast-2:014842949473:connection/0c7f5052-f5d2-439f-9972-42559d0b2ee7"
# CodeCommit
CodeCommitRepositoryName = "test"
CodeCommitBranchName     = "master"
cpl_tags                 = {}
cpl_trusted_role_services = ["codepipeline.amazonaws.com"]
cpl_custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/AWSCodeStarFullAccess",
  "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
  "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess",
  "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
  "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
]