locals {
  enviroment      = terraform.workspace
  name_sufix      = local.enviroment == "default" ? "" : "-${local.enviroment}"
  region          = terraform.workspace == "failover" ? "us-east-1" : "eu-west-1"
  failover        = terraform.workspace == "failover" ? true : false
  vpc_name_dev    = "VPC-DEV"
  igw_name_dev    = "IGW-DEV"
  cidr_block_dev  = "10.0.0.0/16"
  vpc_name_prod   = "VPC-PROD"
  igw_name_prod   = "IGW-PROD"
  cidr_block_prod = "10.1.0.0/16"
}
module "vpc_dev" {
  source       = "./modules/vpc_ig"
  cidr_block   = local.cidr_block_dev
  vpc_name     = tomap({ Name = local.vpc_name_dev })
  gateway_tags = tomap({ Name = local.igw_name_dev })
}
module "vpc_prod" {
  source       = "./modules/vpc_ig"
  cidr_block   = local.cidr_block_prod
  vpc_name     = tomap({ Name = local.vpc_name_prod })
  gateway_tags = tomap({ Name = local.igw_name_prod })
}