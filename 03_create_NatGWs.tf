locals {
  exported_nat_gateways = [for nat_gateway in module.create_nat_gateways : nat_gateway]
}
module "create_nat_gateways" {
  source           = "./modules/natgw"
  for_each         = module.create_public_subnets
  attach_to_vpc    = true
  subnet_id        = each.value.subnet.id
  nat_gateway_name = "GW_${each.value.subnet.id}"
}