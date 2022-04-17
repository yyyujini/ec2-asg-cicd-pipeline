// terraform {
//   backend "remote" {
//     hostname      = "app.terraform.io"
//     organization   = "amorepacific-ec2-cicd-pipeline"
//     workspaces {
//       name = "vpc"
//     }
//   }
// }
terraform {
  backend "s3" {
    bucket = "devops-tfbackend-dc"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
