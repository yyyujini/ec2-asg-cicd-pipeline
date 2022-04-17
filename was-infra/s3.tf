module "s3" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  bucket        = local.bucket_name
  acl           = local.acl_type
  force_destroy = local.force_destroy
  versioning    = local.versioning
  #tags          = merge(local.cpl_tags, { Name = local.codepipeline_s3_artifact_name })
}