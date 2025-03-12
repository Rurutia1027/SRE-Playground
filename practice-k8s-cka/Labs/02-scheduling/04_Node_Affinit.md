# Practice Test -- Node Affinity

## Q1

How many Labels exist on node node01?

- shell command
- **ANS**: 5

```shell
controlplane ~ ➜  kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
```

## Q2

What is the value set to the label key `beta.kubernetes.io/arch` on **node01**?

- **ANS**: amd64
- shell commands

```shell 
controlplane ~ ➜  kubectl describe node node01 
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
```

## Q3

Apply a label `color=blue` to node node01

- shell commands

```shell
# first, use edit command to edit the node in yaml file 
controlplane ~ ✖ kubectl edit node node01 
node/node01 edited

# second, find label, and append color=blue to the label
  labels:
    beta.kubernetes.io/arch: amd64
    beta.kubernetes.io/os: linux
    color: blue
    kubernetes.io/arch: amd64
    kubernetes.io/hostname: node01
    kubernetes.io/os: linux
    color: blue 


# exit edit mode & verify whether label already work
controlplane ~ ✖ kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    color=blue
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux 
```

## Q4

Create a new deployment named `blue` with the `nginx` image and 3 replicas.

- shell command

```shell
# use shell command directly 
controlplane ~ ✖ kubectl create deployment blue --image=nginx --replicas=3
deployment.apps/blue created

# check deployment status  

controlplane ~ ➜  kubectl get deployments 
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   3/3     3            3           24s
```

## Q5

Which nodes can the pods for the blue deployment be placed on?

_Make sure to check taints no both nodes_

- shell commands
- **ANS**: node01 --> color=blue keyword match

```shell
# check how many nodes there are in current env 
controlplane ~ ➜  kubectl get nodes 
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   15m   v1.32.0
node01         Ready    <none>          14m   v1.32.0

# check the taints that define on the nodes
controlplane ~ ✖ kubectl describe node controlplane | grep Taint 
Taints:             <none>

controlplane ~ ➜  kubectl describe node node01 | grep Taint 
Taints:             <none>

# 
controlplane ~ ➜  kubectl describe node controlplane | grep blue 
  default                     blue-d7967dc55-sqdqc                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m10s

controlplane ~ ➜  kubectl describe node node01  | grep 
blue 
                    color=blue
  default                     blue-d7967dc55-qpwj8     0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m24s
  default                     blue-d7967dc55-w7ft4     0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m24s
```

## Q6

Set Node Affinity to the deployment to place the pods on `node01` only.

- shell commands

```shell
# first, delete deployment previously created without declaring Node Affinity strategy
kubectl delete deployment blud 


# second, re-generate deployment.yml via command
kubectl create deployment blue --image=nginx --replicas=3 --dry-run=client -o yaml > deployment.yaml 

# third, edit the deployment.yaml append Node Affinity strategy
controlplane ~ ➜  cat deployment.yml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
      affinity: # append node affinity here 
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: color 
                  operator: In 
                  values:
                    - blue

status: {}

# then, execute command to re-create deployment again 
kubectl apply -f ./deployment.yaml 

# last, check the deployment current status && check only node01 holds this deployment.   

controlplane ~ ➜  kubectl describe node node01 | grep blue 
                    color=blue
  default                     blue-7bd99994c-6gpxc     0 (0%)        0 (0%)      0 (0%)           0 (0%)         5m44s
  default                     blue-7bd99994c-9bv76     0 (0%)        0 (0%)      0 (0%)           0 (0%)         5m44s
  default                     blue-7bd99994c-ms7jz     0 (0%)        0 (0%)      0 (0%)           0 (0%)         5m45s

controlplane ~ ➜  kubectl describe controlplane | grep blue 
error: the server doesn't have a resource type "controlplane"

controlplane ~ ✖ kubectl describe node controlplane
 | grep blue 

controlplane ~ ✖  no blue deployment is filtered  
```

## Q7

Which nodes are the pods placed on now?

- shell commands
- **ANS**: node01

```shell
# first, check all the pods in current env 
controlplane ~ ✖ kubectl get pods 
NAME                   READY   STATUS    RESTARTS   AGE
blue-7bd99994c-6gpxc   1/1     Running   0          8m55s
blue-7bd99994c-9bv76   1/1     Running   0          8m55s
blue-7bd99994c-ms7jz   1/1     Running   0          8m56s

# second, check all pod's Node field info 
controlplane ~ ➜  kubectl describe pod blue-7bd99994c-6gpxc
Name:             blue-7bd99994c-6gpxc
Namespace:        default
Priority:         0
Service Account:  default
Node:             node01/192.168.193.154
```

## Q8

Create a new deployment named `red` with the `nginx` image and 2 replicas,
and ensure it gets placed on the `controlplane` node only.

_use the label key - node-role.kubernetes.io/control-plane- which is already set on the `controlplane` node.

- shell command

```shell
# first generate deployment yml file by following commands
controlplane ~ ✖ kubectl create deployment red --image=nginx --replicas=2 --dry-run=client -o yaml > red.yml 

controlplane ~ ➜  cat red.yml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: red
  name: red
spec:
  replicas: 2
  selector:
    matchLabels:
      app: red
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: red
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}


# then, edit the deployment yml file and append the node label 
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: red
  name: red
spec:
  replicas: 2
  selector:
    matchLabels:
      app: red
  template:
    metadata:
      labels:
        app: red
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: node-role.kubernetes.io/control-plane
                    operator: Exists  # Works even if the value is empty
      containers:
        - image: nginx
          name: nginx
          resources: {}

controlplane ~ ➜  kubectl apply -f red.yml 
deployment.apps/red created

# the, verify that the new created pod and its replicas running on controlplane node
ontrolplane ~ ✖ kubectl describe node node01 | grep red 
  Normal   RegisteredNode           48m                node-controller  Node node01 event: Registered Node node01 in Controller

controlplane ~ ➜  kubectl describe node controlplane | grep red 
  kube-system                 coredns-7484cd47db-4t5j2                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     49m
  kube-system                 coredns-7484cd47db-g7pmn                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     49m
  Normal   RegisteredNode            49m                node-controller  Node controlplane event: Registered Node controlplane in Controller

-- this shows that deployment red's 2 replicas are both running on node controlplane 
```







