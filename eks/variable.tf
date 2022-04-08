variable "eks_cluster_policy_arn" {
    type = string
    default = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    description = "EKS Cluster Policy"
}

variable "eks_node_policy_arn" {
    type = list
    default = ["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
    description = "EKS Node Policy"
}

variable "public_subnet_ids" {
    type = list
    description = "List of public subnet IDs"
}

variable "ami_type" {
    type = string
    default = "AL2_x86_64"
    description = "Default node group ami"
}

variable "capacity_type" {
    type = string
    default = "ON_DEMAND"
    description = "Default capacity of the instance"
}

variable "instance_type" {
    type = list
    default = ["t3.medium"]
    description = "Default instance type"
}