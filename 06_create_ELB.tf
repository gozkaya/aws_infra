locals {
  load_balancer_arn      = module.create_load_balancer.load_balancer_arn
  load_balancer_dns_name = module.create_load_balancer.load_balancer_dns_name
}
module "create_load_balancer" {
  source = "./modules/elb"

  name               = "LoadBalancerApplication${local.name_sufix}"
  load_balancer_type = "application"
  enable_http2       = "true"
  internal           = "false"
  security_groups    = [local.app_security_group_id]
  subnets            = local.exported_public_subnets
  idle_timeout       = "60"
}