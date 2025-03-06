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

## Which namespace has the `blue` pod in it?

- **ANS: marketing**

- Shell Commands (my solution)

```shell
controlplane ~ ➜  kubectl get pods -o wide --namespace=marketing 
NAME       READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
blue       1/1     Running   0          11m   10.22.0.14   controlplane   <none>           <none>
redis-db   1/1     Running   0          11m   10.22.0.13   controlplane   <none>           <none>
```

- Shell Commands (GPT solution):

```shell 
# method-1:
kubectl get pods --all-namespaces | grep blue 
controlplane ~ ✖ kubectl get pods -A -o wide | grep blue 
marketing       blue                                      1/1     Running            0               15m     10.22.0.14   controlplane   <none>           <none>
# method-2:
kubectl get pods -A | grep blue

# method-3:
kubectl get pod blue --all-namespaces 
```

## Access the `Blue` web application using the link above your terminal!

- From the UI you can ping other services.

## What DNS name should the **Blue** application use to access the database `db-service` in its own namespace -

`marketing`?

- You can try it in the web application UI. Use port `6379`.
- **ANS:db-service**
- **NOTE**: In Kubernetes, applications inside the **same namespace** can access a service using its **service name** as
  the DNS name. Since the **Blue** application is in the `marketing` namespace, it can reach th e`db-service` using it
  services name. According to the commands message, we know that the service name of `db-service` so this service name
  can be used as its DNS name.

- Shell Commands:

```shell
controlplane ~ ➜  kubectl get services --namespace=marketing 
NAME           TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
blue-service   NodePort   10.43.13.175   <none>        8080:30082/TCP   19m
db-service     NodePort   10.43.43.3     <none>        6379:30893/TCP   19m

controlplane ~ ➜  kubectl describe service db-service --namespace=marketing
Name:                     db-service
Namespace:                marketing
Labels:                   <none>
Annotations:              <none>
Selector:                 name=redis
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.43.43.3
IPs:                      10.43.43.3
Port:                     <unset>  6379/TCP
TargetPort:               6379/TCP
NodePort:                 <unset>  30893/TCP
Endpoints:                10.22.0.13:6379
Session Affinity:         None
External Traffic Policy:  Cluster
Internal Traffic Policy:  Cluster
Events:                   <none>
```

## What DNS name should the **Blue** application use to access the database **db-service** in the `dev` namespace?

- You can try it in the web application UI. Use port `6379`
- **ANS: db-service.dev.svc.cluster.local**

#### Solutions (GPT Provided):

Since the **db-service** is in the `dev` namespace, and the **Blue** application is in the `marketing` namespace,
the full **DNS name** should be used for cross-namespace access.

- Explanations:
    - `db-service` The name of the service (using `kubectl get services --namespace=dev`)
    - `dev`: The namespace where the service is located.
    - `svc`: Represents the service category in Kubernetes.
    - `cluster.local`: Default domain for internal Kubernetes services.
- How Blue Application Should Connect
    - Since `db-service` exposes **port: 6379**, the Blue application should connect using:
        - `db-service.dev.svc.cluster.local:6379`

```shell
controlplane ~ ➜  kubectl get pods -A -o wide | grep blue 
marketing       blue                                      1/1     Running            0              27m   10.22.0.14   controlplane   <none>           <none>

controlplane ~ ➜  kubectl get services --namespace=dev 
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
db-service   ClusterIP   10.43.219.73   <none>        6379/TCP   30m

controlplane ~ ➜  kubectl describe service db-service --namespace=dev 
Name:                     db-service
Namespace:                dev
Labels:                   <none>
Annotations:              <none>
Selector:                 name=redis
Type:                     ClusterIP
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.43.219.73
IPs:                      10.43.219.73
Port:                     <unset>  6379/TCP
TargetPort:               6379/TCP
Endpoints:                10.22.0.12:6379
Session Affinity:         None
Internal Traffic Policy:  Cluster
Events:                   <none>
```