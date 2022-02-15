# How to Deploy Infra - step by step

# PRE REQUISITES
1. Clone infraestructure repository
  
2. Set up your AWS CLI to connect to AWS [how-to-install](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

3. You must have installed Terraform. [how-to-install](https://learn.hashicorp.com/tutorials/terraform/install-cli)

4. `terraform init`

5. `terraform plan` (to see changes to be updated)

6. `terraform apply -auto-approve`
Note: If  you want to delete all infrastructure you have to run this command `terraform destroy`

# How to deploy Sonar and Jenkins in Cluster Deploy 
### ***Step 1 - Install Jenkins***

1. Set .kubeconfig with the follow coomand in your CLI

```bash
     aws eks update-kubeconfig --name EKS-Cuscatlan-development --region us-east-1
```

2. Go to the K8S-Manifiestos folder in your command prompt and Apply the file jenkins-deployment-svc.yaml with the follow command.

 ```bash
     kubectl apply -f jenkins-deployment-svc.yaml
  ```

### ***Step 2 - Install Sonar***

1. Set .kubeconfig with the follow coomand in your CLI

```bash
     aws eks update-kubeconfig --name EKS-Cuscatlan-development --region us-east-1
```

2. Go to the K8S-Manifiestos folder in your command prompt and Apply the file jenkins-deployment-svc.yaml with the follow command.

 ```bash
     kubectl apply -f sonar-deployment-svc.yaml
  ```

# How to deploy java-app in the Cluster

### ***Step 1 - Create a namespace***

Go to the K8S-Manifiestos folder and use namespace.yaml file with the follow command

```bash
    kubectl apply -f namespace.yaml
```
### ***Step 2 - Deploy java-app***

Go to the K8S-Manifiestos folder and use java-app.yaml file with the follow command

```bash
    kubectl apply -f java-app.yaml
```