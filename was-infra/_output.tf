output "alb_sg_id" {
  value = module.http.security_group_id
}

output "alb_dns_name" {
  value = module.private_alb.lb_dns_name
}

output "target_group_name" {
  value = module.private_alb.target_group_names[0]
}

output "efs_dns" {
  value = aws_efs_file_system.file_system.dns_name
}

output "autoscaling_group_id"{
  value = module.asg.autoscaling_group_id
}