locals {
  exported_private_subnets = [for private_subnet in module.create_private_subnets : private_subnet]
  exported_public_subnets  = [for public_subnet in module.create_public_subnets : public_subnet]
}
module "create_public_subnets" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc_dev.vpc_id
  for_each          = { subnet1 : { subnet_name = "PublicSubnetA", cidr_block = "10.0.0.0/24", availability_zone = "${local.region}a" },
                        subnet2 : { subnet_name = "PublicSubnetB", cidr_block = "10.0.3.0/24", availability_zone = "${local.region}b" } }
  subnet_name       = each.value.subnet_name
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
}
module "create_private_subnets" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc_dev.vpc_id
  for_each          = { subnet3 : { subnet_name = "PrivateSubnetA", cidr_block : "10.0.1.0/24", availability_zone = "${local.region}a" },
                        subnet4 : { subnet_name = "PrivateSubnetB", cidr_block : "10.0.4.0/24", availability_zone = "${local.region}b" } }
  subnet_name       = each.value.subnet_name
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
}