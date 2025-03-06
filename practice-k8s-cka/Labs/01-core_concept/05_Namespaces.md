# Namespaces 

## How many Namespaces exists on the system?
- **ANS: 10**
- Shell Commands 
```shell 
controlplane ~ ➜  kubectl get namespaces 
NAME              STATUS   AGE
default           Active   5m47s
dev               Active   62s
finance           Active   62s
kube-node-lease   Active   5m47s
kube-public       Active   5m47s
kube-system       Active   5m47s
manufacturing     Active   62s
marketing         Active   62s
prod              Active   62s
research          Active   62s

controlplane ~ ➜  kubectl get namespaces --no-headers | wc -l 
10
```
## How many pods exist in the `research` namespace?
- **ANS:**
- Shell Commands 
```shel 
controlplane ~ ➜  kubectl get pods --namespace=research --no-headers | wc -l 
2
```

## Create a POD in the `finance` namespace.
- Use the spec given below. 

- Shell Commands 
```shell 
controlplane ~ ✖ kubectl run redis --image=redis --namespace=finance --dry-run=client -o yaml > redis.yaml 

controlplane ~ ➜  cat redis.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: redis
  name: redis
  namespace: finance
spec:
  containers:
  - image: redis
    name: redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  kubectl apply -f ./redis.yaml 
pod/redis created

controlplane ~ ➜  kubectl get pods --namespace=finance 
NAME      READY   STATUS    RESTARTS   AGE
payroll   1/1     Running   0          8m12s
redis     1/1     Running   0          12s
```
