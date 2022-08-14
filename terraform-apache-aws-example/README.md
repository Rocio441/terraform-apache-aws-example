This is demo README file.
Not intended for Production use.


```hcl
terraform {

}

provider "aws" {
  region     = "us-east-2"
  access_key = "access_key"
  secret_key = "secret_key"
}

module "aws-server" {
  source          = ".//terraform-apache-aws-example"
  vpc_id          = "vpc-11111111"
  my_ip_with_cidr = "MyOwnIP/32"
  public_key      = "ssh-rsaAAAA...."
  instance_type   = "t2.micro"
  server_name     = "Apache Example Server"
}

output "public_ip" {
  value = module.aws-server.public_ip
}
```