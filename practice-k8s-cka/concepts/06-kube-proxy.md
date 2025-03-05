# Kube Proxy 


## What's Kube Proxy 
- Kube Proxy runs on each node and manages network communication for pods. 
- It ensures that requests to a service are forwarded to the correct pod, based on service selectors. 
- Kube Proxy maintains the network rules, enabling load balancing and ensuring reliable communication between **pods** across **nodes**.
- It supports different modes like **iptable** or **IPVS** for traffic routing. 

Whenever a Pod try to get to a service using it's IP and Name, it forwards the traffic to the backend Pod. Service is different from a Pod it does not have interfaces and processes, actually Service is a virtual component that only lives in the Kubernetes' memory. But the service should always accessible across the cluster and nodes. That's the reason **kube-proxy** comes in.

Kube-proxy is a process that runs on each node of the K8S, it's job is looking for new services and every time a new services is created it (kube-proxy) creates a proper rules on each node for that service to forward traffic to services to the backend pods.

By using IP Table it creates the IP Table Rule on each Node of the K8S cluster to forward traffic heading to the IP of the service to the IP to the actual of the Pod. 

