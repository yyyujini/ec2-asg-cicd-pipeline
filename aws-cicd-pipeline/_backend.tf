// terraform {
//   backend "remote" {
//     hostname     = "app.terraform.io"
//     organization = "amorepacific-ecs-cicd-pipeline-0"

//     workspaces {
//       name = "aws-cicd-pipeline"

//     }
//   }
// }
terraform {
  backend "s3" {
    bucket = "devops-tfbackend-dc"
    key    = "codeSeries/terraform.tfstate"
    region = "ap-northeast-2"
  }
}