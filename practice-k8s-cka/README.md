# Certified Kubernetes Administrator (CKA) Practice Scripts

This repository contains scripts and configurations to help you prepare for the Certified Kubernetes Administrator (CKA) exam. It automates practice tests using GitHub Actions and Minikube to replicate real-world Kubernetes environments.

## 📌 Features
- Automated setup of Minikube for testing
- Practice scripts covering key Kubernetes concepts
- CI/CD pipeline to verify configurations
- Helm & Kustomize support for application deployment

## 📂 Practice Topics
### Core Concepts
- Pods, ReplicaSets, Deployments
- Namespaces & Services
- Imperative Commands

### Scheduling
- Manual Scheduling, Labels & Selectors
- Taints, Tolerations, and Affinity
- DaemonSets & Static Pods

### Application Lifecycle
- Rolling Updates & Rollbacks
- Environment Variables & Secrets
- Multi-Container Pods & Init Containers

### Cluster Maintenance
- OS Upgrades & Cluster Upgrades
- Backup & Restore Methods

### Security
- RBAC, Cluster Roles, and Service Accounts
- Image Security & Network Policies

### Storage & Networking
- Persistent Volumes & Storage Classes
- CNI, Service Networking, Ingress

### Troubleshooting
- Application & Control Plane Failures
- Node & Network Troubleshooting

## 🚀 Setup & Usage
1. Clone the repository:
   ```sh
   git clone https://github.com/Rurutia1027/SRE-Playground.git
   cd practice-k8s-cka
   ```
2. Install dependencies (Minikube, kubectl, Helm, etc.).
3. Run practice scripts:
   ```sh
   ./scripts/run_all.sh
   ```
4. Verify configurations:
   ```sh
   kubectl get pods -A
   ```

## 📖 References
- **Video on Udemy:** [Certified Kubernetes Administrator](https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests)
- **Practice Platform:** [KodeKloud Labs](https://learn.kodekloud.com/user/courses/udemy-labs-certified-kubernetes-administrator-with-practice-tests)
