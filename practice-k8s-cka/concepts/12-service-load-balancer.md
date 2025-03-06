# Service: Load Balancer

## What's Load Balancer Service in K8S?

A **LoadBalancer** is a Kubernetes **Service Type** that automatically provisions an **external IP** and routes traffic
from outside the cluster to the appropriate backend Pods. It relies on the **underlying cloud provider's load balancing
**(e.g., AWS ELB, GCP Load Balancer, Azure Load Balancer) to distribute incoming requests.

## How it Works

- When you create a **Service** of type `LoadBalancer`, Kubernetes requests a cloud provider to provision an **external
  load balancer**.
- The load balancer **routes external traffic** to the Service's internal Pods, using a ClusterIP under the hood.
- **Health checks and traffic balancing** ensure availability and even distribution of requests.

## Use Cases of LoadBalancer Service

### Exposing Web Applications to the Internet

- Example: Running an **NGINX web server** that needs a public IP so users can access it.
- Kubernetes provisions an external Load Balancer that routes traffic to NGINX Pods.

### API Gateway or Backend MicroServices

- Example: Exposing a **REST API backend** that needs to be reachable from external clients.
- The LoadBalancer directs API requests to the appropriate microservice Pods.

### Multi-Region or Cloud Hosted Applications

- Example: Using AWS Elastic Load Balancer(ELB) to distribute traffic across multiple zones.
- Ensure high availability and failover across different cloud regions.

## Example YAML for LoadBalancer Service

- This yaml file will create a **publicly accessible** LoadBalancer that routes requests to Pods inside `app: myapp` on
  port 8080/

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-loadbalancer
spec:
  type: LoadBalancer
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80    # exposed port on Loadbalancer 
      targetPort: 8080 # Port inside the container 
```