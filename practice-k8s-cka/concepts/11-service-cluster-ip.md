# Service Cluster IP

## What is Service ClusterIP in Kubernetes?

- **ClusterIP** is the **default type** of K8S Service that provides an **internal-only** IP address within the cluster.
  It allows communication between different **Pods** inside the cluster but **does not expose** the service to external
  users or the internet.
  _the above 'cluster' is referring to the K8S cluster instead of referring replicaset or deployment_

## What are ClusterIP this Service's Use Scenarios?

### Internal Microservice Communication

- Used when services need to communicate within the cluster(e.g., a backend API communicating with a database service)
- Example: A frontend service calling an internal authentication service.

### Backend Database Access

- Exposes databases(like PostgreSQL, MySQL, or MongoDB) interally to other services but keeps them unavailable from the
  outside.

### Message Queue Services

- Used for internal event-driven architecture where services communication via queues(e.g., Kafka, RabbitMQ).

### Service Mesh Implementations

- When using service meshes like lstio or Linkerd, ClusterIP services are leveraged for internal traffic routing.

### API Gateway & Internal Proxies

- ClusterIP can be used behind an API Gateway, which then manages external access while keeping internal components
  secure.

## How to Create Service of ClusterIP Type?

- service-definition.yml

```yaml
apiVersion: v1
kind: Service 
metadata:
  name: backend
spec:
  type: ClusterIP
  ports: 
    - targetPort: 80
      port: 80
  selector:
    app: myap 
    type: backend
```

