provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name  = "webservers-production"
  instance_type = "t3.small"
  min_size      = 4
  max_size      = 10
  public_subnet_a_cidr = "172.31.108.0/24"
  public_subnet_b_cidr = "172.31.109.0/24"
  public_subnet_c_cidr = "172.31.110.0/24"
}

output "alb_dns_name" {
  value = module.webserver_cluster.alb_dns_name
}