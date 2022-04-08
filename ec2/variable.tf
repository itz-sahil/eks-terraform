variable "ami_ec2" {
    type = string
    default = "ami-0851b76e8b1bce90b"
    description = "Ubuntu Server 20.04 LTS (HVM) (64-bit (x86))"
}

variable "instance_type_ec2" {
    type = string
    default = "t2.micro"
    description = "Instance type for ec2 instance"
}

variable "public_subnet_1_id" {
    type          = string
    description   = "public subnet id for instance"
}

variable "security_group_ec2" {
    type = string
    description = "Security group for ec2 instance"
}