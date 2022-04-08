module "vpc" {
    source = "./vpc/"
}

module "eks" {
    source = "./eks/"
    public_subnet_ids = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
    depends_on = [module.vpc]
}

module "ec2" {
    source = "./ec2/"
    security_group_ec2 = module.vpc.security_group_ec2
    public_subnet_1_id = module.vpc.public_subnet_1_id
    depends_on = [module.eks]
}