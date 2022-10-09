locals {

  vpc_id                = module.vpc_ig.vpc_id
  efs_security_group_id = module.SecurityGroup.ids_map["EFSMountTargetSecurityGroup${local.name_sufix}"].id
  app_security_group_id = module.SecurityGroup.ids_map["WebAppInstanceSecurityGroup${local.name_sufix}"].id
}
module "SecurityGroup" {
  source = "./modules/security_group"
  security_group_sets = {
    "WebAppInstanceSecurityGroup${local.name_sufix}" = {
      vpc_id = local.vpc_id

      ingress = [
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = "443"
          protocol    = "tcp"
          self        = "false"
          to_port     = "443"
        },
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = "80"
          protocol    = "tcp"
          self        = "false"
          to_port     = "80"
        }
      ]

      egress = [
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = "0"
          protocol    = "-1"
          self        = "false"
          to_port     = "0"
      }]
    },
    "EFSMountTargetSecurityGroup${local.name_sufix}" = {
      vpc_id = local.vpc_id

      ingress = [
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = "2049"
          protocol    = "tcp"
          self        = "false"
          to_port     = "2049"
        },
      ]

      egress = [
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = "0"
          protocol    = "-1"
          self        = "false"
          to_port     = "0"
        }
      ]
    },
  }
}

resource "aws_security_group_rule" "example" {
  depends_on = [
    module.SecurityGroup
  ]
  type                     = "ingress"
  security_group_id        = local.efs_security_group_id
  from_port                = "80"
  protocol                 = "tcp"
  source_security_group_id = local.app_security_group_id
  to_port                  = "80"
}