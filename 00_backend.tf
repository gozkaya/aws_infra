terraform {
  backend "s3" {
    encrypt = true
    bucket  = "launchpad-state-file"
    key     = "key"
    region  = "eu-west-1"
  }
}
