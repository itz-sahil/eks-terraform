resource "aws_vpc" "my_vpc" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = var.instance_tenancy_vpc
  enable_dns_hostnames = var.enable_dns_hostnames_vpc

  tags = {
    Name: "EKS-VPC"
  }
}