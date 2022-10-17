locals {
  enviroment   = terraform.workspace
  name_sufix   = local.enviroment == "default" ? "" : "-${local.enviroment}"
  region       = terraform.workspace == "failover" ? "us-east-1" : "eu-west-1"
  failover     = terraform.workspace == "failover" ? true : false
}
module "vpc_ig" {
  source       = "./modules/vpc_ig"
  cidr_block   = "10.0.0.0/16"
  vpc_name     = tomap({ Name = "VPC-DEV" })
  gateway_tags = tomap({ Name = "IGW-DEV" })
}
module "vpc_ig_prod" {
  source       = "./modules/vpc_ig"
  cidr_block   = "10.1.0.0/16"
  vpc_name     = tomap({ Name = "VPC-PROD" })
  gateway_tags = tomap({ Name = "IGW-PROD" })
}