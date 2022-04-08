#!/bin/bash

echo "<------Installing software dependencies------>"
sudo apt-get install curl -y
sudo apt-get install zip unzip -y

echo "<------Installing AWS CLI------>"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "<------Intalling kubectl------>"
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

echo "<------Installing HELM------>"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "<------Configuring the AWS CLI------>"
mkdir ~/.aws/
echo -e "[default]
region = <region>
output = json" > ~/.aws/config
echo -e "[default]
aws_access_key_id = <access_key>
aws_secret_access_key = <secret_key>" > ~/.aws/credentials

echo "<------Checking whether the cluster is ready or not------>"
aws eks --region <region> describe-cluster --name <cluster_name> --query cluster.status

echo "<------Fetching the cluster configuration to kubectl------>"
aws eks --region <region> update-kubeconfig --name <cluster_name>

echo "<------Verifying kubectl configuration------>"
kubectl get svc

echo "<------Checking the status of the nodes------>"
kubectl get nodes

echo "<------Creating the namespace------>"
kubectl create namespace webapp
kubectl get namespace

echo "<------Adding ingress-nginx offical stable repository------>"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

echo "<------Using Helm to deploy an Nginx ingress controller------>"
helm install my-ingress ingress-nginx/ingress-nginx --namespace webapp --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

echo "<------Verifying the heml chart is installed------>"
helm list --namespace webapp

echo "<------Listing all resources created by helm chart above------>"
kubectl get all --namespace webapp

echo "<------Verifying that load balancer server is installed------>"
kubectl get service --namespace webapp

echo "<------Creating the deployment and service resources------>"
kubectl create -f covid.yml -n webapp
kubectl create -f myapp.yml -n webapp

echo "<------Verifying service is created------>"
kubectl get service -n webapp

echo "<------Verifying deployment is created------>"
kubectl get deployment -n webapp

echo "<------Creating the ingress resources for the services------>"
kubectl create -f ingress.yml -n webapp

echo "<------Verifying the ingress resource------>"
kubectl get ingress/my-ingress -n webapp