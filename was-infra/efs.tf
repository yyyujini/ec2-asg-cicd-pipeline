resource "aws_efs_file_system" "file_system" {
  throughput_mode = local.throughput_mode
  performance_mode = local.performance_mode
  encrypted = local.encrypted
  #kms_key_id = ""

  tags = {
    Name = "test"
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count           = length(local.private_subnet_ids)
  file_system_id  = aws_efs_file_system.file_system.id

  subnet_id       = element(local.private_subnet_ids, count.index)
  security_groups = [ local.security_group_id ]
  // security_groups = local.efs_security_groups
  
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.file_system.id

  backup_policy {
    status = local.efs_backup_policy
  }
}