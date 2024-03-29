![image](https://github.com/joshadu/kubernetes-orchestration/assets/45633182/870356e7-9fda-4445-80c2-313b716833c8)


# Kubernetes-orchestration
This project is a fully functional Kubernetes cluster with an e-commerce site and pacman game installed on it. We created a virtualization environment, where we installed Rancher, Kubernetes cluster and Nginx load balancer. On the Kubernetes cluster, we configured Nginx ingress controller and exposed the application for use outside of the cluster. Then we configured an NFS server and installed NFS plug-in in the cluster. Finally, we installed OpenCart e-commerce platform and pacman game on the cluster. OpenCart files and databases are stores on the NFS server.

# Tools explored
- Kubernetes: Orchestration for containerized application
- Docker: Containerized application deployment
- Rancher: Simplified setup and management of Kubernetes cluster on our cloud platform
- Terraform: Infrastructure as Code for VM deployment on CSC cPouta
- OpenCart: e-Commerce platform
- Git: Version control
