# Replication Controller 

## What is a Replication Controller ? 
A **Replication Controller** in Kubernetes ensures that a specified number of identical pod replicas are running at all times. It helps maintain applicaiton availability by automatically starting new pods if existing ones fail. 

## What is the Responsibility of a Replication Controller in K8S ? 

- Ensure that the desired number of pod replicas are running.
- Replaces failed or terminated pods with new ones. 
- Scales the number of pods up or down based on configuration. 
- Helps maintain high availability and fault tolerance. 


## Replication Controller vs. Replica Set 
- Replication Controller is an older concept that ensures a fixed number of pod replicas. 
- Replica Set is the modern replacement, offering more flexibility, including label-based pod selection.
- While **Replica Set** is preferred, it is often managed by a **Deployment**, which provides additional features like rolling updates and rollbacks. 

## How to Create Replication Controller 

```yml 
apiVersion: v1 
kind: ReplicationController 
metadata: 
  name: myapp-rc
  labels: 
    app: myapp
    type: front-end 
spec: 
  template: 
    metadata: 
      name: myapp-pod
      labels: 
        app: myapp
        type: front-end
    spec:
      containers:
      - name: nginx-container
        image: nginx 
# replication nums define here         
replicas: 3 
```

## How to Create ReplicaSet 
- replicaset-definition.yml 
  
```yml
apiVersion: apps/v1
kind: ReplicaSet 
metadata: 
  name: myapp-replicaset 
  labels: 
    app: myapp 
    type: front-end 
spec: 
  template: 
    metadata:
      name: myapp-pod 
      labels:
        app: myapp 
        type: front-end 
    spec:
      containers:
      - name: nginx-container
        image: nginx
replicas: 3
# selector is the major difference point of replication-controller and replica-set  
selector:  
  matchLabels: 
    type: front-end 
```

## How to Scale Replicas 
- use kubectl replace 
  
```shell 
kubectl replace -f replicaset-definition.yml 
```

- use kubectl scale 
```shell 
kubectl scale --replicas=6 -f replicaset-defintiion.yml 
```