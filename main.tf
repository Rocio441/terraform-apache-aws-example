terraform {

}

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAZ3B4U3LR2G3GJBGC"
  secret_key = "j9iBXGb0rSpXlSFssv/toTFCJ7zXRw8CMLdGg8WJ"
}

module "aws-server" {
  source          = ".//terraform-apache-aws-example"
  vpc_id          = "vpc-047edb0340e9f5ebc"
  my_ip_with_cidr = "223.177.38.102/32"
  public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmRVL4SpNABybWvU4GdTO07aKVgFBCCkDjNuqzzwLlrA1RNkbVta27AN3tRzC+Qo/yYtsE2x2xX4KjBE2UoAOQpiJZqWtxBzlNEsjqzO6jfxjXlgTZ78wVHKHzvuDymgwdTf5IPV2zEjuK1gtSLzK2A7wweo8S2j8BH9CfaWsdvVfTD+Ma2Ddj8kvZ8S3hg+GaK3+LcXfSy5+xmxCOIuzweLcDwtVUgtWgt8AhmcxljkrkaO8FpsTdmyo3+xODsUEas9JlzshD00lmCNnx1jLjHIjQJ4SnQ+T3M5l8mMGzr+uKU7vFUsG8lektgXh2B0gT0kwWUg+azh3tfAomiC3Q6j2OVgYvYJYkYTlnNtF34V4VdmbCLEoGpTTehtX9lQXxzgtKG4kmY+GADmreol8axmnPPblhLesEUV+Z/lUtc4r+9S3drLrSVibWGOH28YNz8HpaoiDa2zf3k1ZF9sBDM7c3E512NlbL9AM2t39xLbO25VyNhXnWb7QJGGQL1Ks= aditya@DESKTOP-92GO969"
  instance_type   = "t2.micro"
  server_name     = "Apache Example Server"
}

output "public_ip" {
  value = module.aws-server.public_ip
}