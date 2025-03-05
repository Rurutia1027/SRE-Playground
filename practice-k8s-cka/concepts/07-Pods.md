# Pods 

A **Pod** is the smallest deployable unit in Kubernetes. It represents one or more containers that share the same network and storage. 

## Key Points 
- Single or Multiple Containers - Usually runs one container but can run multiple that need to work together.
- Shared Network - All containers in a Pod share the smae IP and ports. 
- Ephemeral - Pods are temporary; If a Pod dies, K8S may replace it with a new one. 
- Managed by Controllers - Deployments, StatefulSets, and DaemonSets manage Pods for stability. 


## Pods with YAML 
```yaml 
# the verison of the kubernetes' api that you gonna communicate 
# type of apiVersion is String 
apiVersion:

# type of kind is String 
kind: Pod(apiVersion = v1) | Service (apiVersion = v1) | ReplicaSet (apiVersion = apps or v1) | Deployment (apiVersion = apps or v1 )

# type of metadata is dictionary 
metadata: 
  name: myapp-pod # name and labels should be parallel 
  labels: 
    app: myapp 
    type: front-end

# dictionary type too 
spec: 
  containers: # this is an array 
  - name: nginx-container # the first element in the array should always begin with a '-'
    image: nginx 
```

- create a pod from yaml file 

```bash 
kubectl create -f pod-defintion.yml 
```

