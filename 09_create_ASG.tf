module "create_auto_scaling_group" {
  source                    = "./modules/ASG"
  name                      = "AutoScalingGroup${local.name_sufix}"
  availability_zones        = ["${local.region}a", "${local.region}b"]
  default_instance_warmup   = "0"
  desired_capacity          = "2"
  max_size                  = "4"
  min_size                  = "1"
  force_delete              = "true"
  health_check_grace_period = "300"
  health_check_type         = "ELB"
  launch_template_id        = module.create_launch_template.launch_template_id
  launch_template_name      = module.create_launch_template.launch_template_name
  target_group_arn          = module.create_target_group.arn
  subnets                   = local.exported_private_subnets
}