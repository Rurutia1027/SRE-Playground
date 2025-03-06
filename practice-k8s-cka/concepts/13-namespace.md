# Namespaces

## What's Namespace ?

A **namespace** is a logical separation within a system that helps organize and manage resources. It is commonly used in
programming, networking, and distributed systems to avoid naming conflicts and isolate components.

## What's Namespace's Responsibility in Kubernetes?

In Kubernetes, a **namespace** is used to organize and isolate resources within a cluster. It allows multiple teams or
applications to share the same cluster while keeping their workloads logically separated. Key responsibilities of
namespaces in Kubernetes include:

- Resource Isolation: Ensures different teams, applications, or environments(e.g., dev, test, prod) have isolated
  workloads.
- Resource Quota Management: Enables setting CPU, memory, and storage limits for different namespaces.
- Access Control(Resource based Authentication&Authorization Isolation): Helps enforce role-based access control(**RBAC
  **) by restricting users to specify namespaces.
- Scalability: Improves cluster organization and management when dealing with large-scale deployments.
- Logical Grouping: Provides a way to categorize related Kubernetes objects(Pods, Services, ConfigMaps, etc.).

## Create a Namespace in Kubernetes 
- Shell Commands: 
```shell
kubectl create namespace <namespace-name>
```

- YAML File: `namespace.yaml`
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev-environment

# kubectl apply -f namespace.yaml 
```



