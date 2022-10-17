module "create_target_group" {
  source      = "./modules/TARGET_GROUP"
  name        = "TargetGroupApplication${local.name_sufix}"
  port        = "80"
  protocol    = "HTTP"
  path        = "/index.php"
  target_type = "instance"
  target_id   = local.load_balancer_arn
  vpc_id      = module.vpc_dev.vpc_id
}