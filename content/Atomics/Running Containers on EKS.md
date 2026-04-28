---
date: 2022-05-26
Tags:
aliases: []
share: true
created: 2022-05-26
---
Rough notes taken during an EKS training.  
# Running Containers on EKS  
* If you need more control then you can run your own K8's cluster. Amazon EKS allows you to not have to deal w/ control plane.  
* Managed node groups manage your data plane while still allowing you to have control  
* AWS full manages AWS Fargate  
* IAM handles authentication, and K8s RBAC handles the authorization.  
# Terminology  
- Container orchestration tools: Tools that help you manage all the container on your cluster.  
- Pod: Group of one or more containers  
- Kubernetes control plane: Includes the control plane nodes and etcd persistence layer  
- Data plane: Includes the worker nodes running your pods  
- kubectl: A CLI for communicating w/ the Kubernetes API server  
- Amazon EKS: Managed service for running k8's. Managed K8's control plane.  
- eksctl: open source tool to work w/ EKS  
- Fargate:   
- ECR: Amazon Elastic Container Registry  
    - Full managed registry. Docker and OCI artifacts. HA and scaled. Secure: IAM, encryption at rest, option vuln scanning  
- Helm:   
- Cloud9: Browser IDE  
- vpa: Vertical pod autoscaler