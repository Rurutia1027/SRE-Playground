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
  ![](service-types-diagram.png)

  
---

## NodePort 
- NodePort's valid range is [3000, 32767].
- ![](service-node-port.png)

### Create a NodePort Service 

![img.png](ports-nodePorts.png)

- service-definition.yml
```yaml
apiVersion: v1
kind: Service
metadat:
  name: myapp-service
spec:
  type: NodePort # the type of service {ClusterIp, NodePort, LoadBalancer, ExternalName}
  ports:
    - targetPort: 80  # targetPort is referring to Pod's exposed port value 
      port: 80        # port is referring to the port of the services exposing 
      nodePort: 3008  # nodePort is service exposed port value if we do not specify this value, it will locate in the range of [3000, 32767]

```

