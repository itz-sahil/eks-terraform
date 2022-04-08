# About the project

In this project a nodejs and a java application is deployed on EKS using the terraform which uses Ingress controller to access both the apps using the same LoadBalancer URL based on the URI path

# Instructions
 
In ec2/files/script.sh
---> Line 26: insert default region
---> Line 29/30: insert access_key & secret_access_key
---> Line 33/36: insert the region & cluster_name