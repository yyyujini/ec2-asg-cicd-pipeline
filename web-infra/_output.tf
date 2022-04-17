output "alb_sg_id" {
  value = module.http.security_group_id
}

output "target_group_name" {
  value = module.private_alb.target_group_names[0]
}

output "autoscaling_group_id"{
  value = module.asg.autoscaling_group_id
}