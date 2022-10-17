locals {
  key_pair_name          = "AppServerA"
}
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
}
module "create_launch_template" {
  source = "./modules/launch_temp"
  depends_on = [
    data.aws_ami.amazon_linux_2, module.create_efs_drive
  ]

  lc_name            = "LaunchTemplate"
  image_id           = data.aws_ami.amazon_linux_2.id
  instance_type      = "t2.micro"
  key_name           = local.key_pair_name
  security_group_ids = [local.app_security_group_id]
  enable_monitoring  = true

  user_data = base64encode(<<EOF
  #!/bin/bash

  # Install Apache Web Server and PHP
  yum install -y httpd mysql
  amazon-linux-extras install -y php7.2

  # mount file system
  yum install -y amazon-efs-utils
  new_file_system="${local.efs_dns_name}:/ /var/www/html/ nfs defaults,_netdev 0 0"
  echo $new_file_system | sudo  tee -a  /etc/fstab
  mount -fav
  mount -t efs ${local.efs_dns_name} /var/www/html/

  # Download Lab files
  wget https://image-resize-launchpad.s3.eu-central-1.amazonaws.com/${local.enviroment}/image-resizer-app.zip
  unzip -n image-resizer-app.zip -d /var/www/html/

  # Download and install the AWS SDK for PHP
  wget https://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.zip
  unzip -n aws -d /var/www/html

  #give permissions to apache user
  usermod -a -G apache ec2-user
  chown -R ec2-user:apache /var/www
  chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
  find /var/www -type f -exec sudo chmod 0664 {} \;

  # Turn on web server
  chkconfig httpd on
  service httpd start
EOF
  )
}