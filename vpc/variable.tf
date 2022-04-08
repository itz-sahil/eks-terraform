variable "cidr_block_vpc" {
    type = string
    default = "10.0.0.0/16"
    description = "CIDR Block for the vpc"
}

variable "instance_tenancy_vpc" {
    type = string
    default = "default"
    description = "Instance tenancy of the VPC"
}

variable "enable_dns_hostnames_vpc" {
    type = string
    default = "true"
}

variable "cidr_block_public_subnet_1" {
    type          = string
    default       = "10.0.0.0/24"
    description   = "Public Subnet 1 CIDR Block"
}

variable "cidr_block_public_subnet_2" {
    type          = string
    default       = "10.0.1.0/24"
    description   = "Public Subnet 2 CIDR Block"
}