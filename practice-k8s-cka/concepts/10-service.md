# Service

## What's Service in Kubernetes ?

A Service in Kubernetes in an abstraction that defines a stable **network endpoint** for a set of Pods. Since Pods
are **ephemeral(they can be created and destroyed dynamically), their IP addresses change frequently. A Service privides
a fixed IP and DNS name to enable reliable communication between components in a cluster.

## What's Service's Responsibility in Kubernetes?

- Stable Networking - Provides a fixed IP and DNS name for a group of Pods.
- Load Balancing - Distributes traffic among multiple Pods in a set.
- Service Discovery - Enables other services to find and communicate with Pods via a known name.
- Decoupling - Separates application logic from underlying infrastructure changes(e.g., when Pods are rescheduled).
- Traffic Management - Routes external or internal traffic based on defined rules(ClusterIP, NodePort, LoadBalancer,
  etc.).

## Type of Kubernetes Services
- ClusterIP(Default) - Exposes the service inside the cluster only.
- NodePort - Exposes the service on a static port on each node. 
- LoadBalancer - Integrates with cloud provider load balancers for external traffic. 
- ExternalName - Maps a service to an external domain name.

  ![](./service-types.png)
