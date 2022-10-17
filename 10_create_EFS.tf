locals {
  efs_dns_name           = local.failover ? data.aws_efs_file_system.replica[0].dns_name : module.create_efs_drive.efs_dns_name
}
module "create_efs_drive" {
  source          = "./modules/efs"
  name            = "efs${local.name_sufix}"
  encrypted       = true
  private_subnets = tolist(local.exported_private_subnets)
  security_groups = [local.efs_security_group_id]
  efs_replica_id  = false
  failover        = local.failover
}
# If failover get the replica data
data "aws_efs_file_system" "replica" {
  count = local.failover ? 1 : 0

  tags = {
    Name = "failover"
  }
}