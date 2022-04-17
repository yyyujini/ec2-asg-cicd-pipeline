variable "service_name" {}
variable "service_version" {}
variable "env" {}
variable "owner" {}
variable "region" {}
variable "tags" {}

# autoScaling
// variable "as_name" {}
variable "as_min_size" {}
variable "as_max_size" {}
variable "as_desired_capacity" {}
variable "as_wait_for_capacity_timeout" {}
variable "as_health_check_type" {}
variable "as_launch_template_version" {}
variable "protect_from_scale_in" {}
# launch template
// variable "launch_template_name" {}
variable "launch_template_description" {}
// variable "instance_name" {}
// variable "image_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "launch_tem_security_groups" {}
variable "iam_instance_profile_arn" {}
variable "update_default_version" {}
variable "enable_monitoring" {}
variable "ebs_optimized" {}

# alb
variable "alb_name" {}
variable "load_balancer_type" {}
variable "https_listeners" {}
variable "http_tcp_listeners" {}
variable "target_type" {}
variable "target_group_stickiness" {}
variable "backend_protocol" {}
variable "backend_port" {}
variable "health_check_url" {}
variable "internal" {
    default     = true
}

# sg
variable "http_sg_description" {}
variable "http_ingress_cidr_blocks" {}
variable "http_ingress_rules" {}
variable "http_egress_rules" {}