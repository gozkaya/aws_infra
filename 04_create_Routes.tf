locals {
  private_route_tables = ["PrivateRouteTableA", "PrivateRouteTableB"]
  cidr_block_out       = "0.0.0.0/0"
}
module "create_public_route_tables" {
  source = "./modules/route_tables"

  vpc_id           = module.vpc_dev.vpc_id
  route_table_name = "PublicRouteTable"
  cidr_block       = local.cidr_block_out
  gateway_id       = module.vpc_dev.gateway_id
  nat_gateway_id   = null
}
module "create_private_route_tables" {
  source = "./modules/route_tables"
  depends_on = [
    module.create_nat_gateways
  ]
  count            = length(local.private_route_tables)
  vpc_id           = module.vpc_dev.vpc_id
  route_table_name = local.private_route_tables[count.index]
  cidr_block       = local.cidr_block_out
  gateway_id       = null
  nat_gateway_id   = local.exported_nat_gateways[count.index].nat_gateways.id
}
module "create_public_route_table_associations" {
  source         = "./modules/route_assoc"
  for_each       = module.create_public_subnets
  subnet_id      = each.value.subnet.id
  route_table_id = module.create_public_route_tables.route_tables.id
}
module "create_private_route_table_associations" {
  source         = "./modules/route_assoc"
  count          = length(local.exported_private_subnets)
  subnet_id      = local.exported_private_subnets[count.index].subnet.id
  route_table_id = module.create_private_route_tables[count.index].route_tables.id
}