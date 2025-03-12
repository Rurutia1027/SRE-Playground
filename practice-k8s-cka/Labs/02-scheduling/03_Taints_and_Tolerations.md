# Practice Test - Taints and Tolerations

## Q1

How many nodes exist on the sytem?

_Including the controlplane node_.

- **ANS**: 2

- shell command

```shell
controlplane ~ ➜  kubectl get nodes --no-headers 
controlplane   Ready   control-plane   6m11s   v1.32.0
node01         Ready   <none>          5m40s   v1.32.0

```

## Q2

Do any taints exist on node01 node?

- *ANS**: No
- shell command

```shell
controlplane ~ ➜  kubectl describe node node01 | grep Taint
Taints:             <none>
```

## Q3

Create a taint on **node01** with key of **spary**, value of **mortein** and effect of **NoSchedule**

- **ANS**:

```shell
kubectl taint nodes node01 spray=mortein:NoSchedule 
node/node01 tainted
```

## Q4

Create a new pod with the nginx image and pod name as **mosquito**.

```shell
kubectl run mosquito --image=nginx
```

## Q5

What is the state of the POD(you just created)

- **ANS**: Pending
- shell command

```shell 
controlplane ~ ✖ kubectl get pods mosquito -o wide 
NAME       READY   STATUS    RESTARTS   AGE   IP       NODE     NOMINATED NODE   READINESS GATES
mosquito   0/1     Pending   0          19s   <none>   <none>   <none>           <none>
```

## Q6

Why do you think the pod is in a pending state?

- **ANS**: `had untolerated taint`
    - POD Mosquito cannot tolerante taint Mortein


- shell command

```shell
ontrolplane ~ ➜  kubectl describe pod mosquito 
Name:             mosquito
Namespace:        default
Priority:         0
Service Account:  default
Node:             <none>
Labels:           run=mosquito
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Containers:
  mosquito:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-7m4p4 (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  kube-api-access-7m4p4:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  2m27s  default-scheduler  0/2 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }, 1 node(s) had untolerated taint {spray: mortein}. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
```

## Q7

Create another pod named `bee` with the `nginx` image, which has a toleration set to the taint `mortein`.

- shell command to init a pod yaml file

```shell
kubectl bee --image=nginx --dry-run=client -o yaml > bee.yaml 

# bee.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bee
  name: bee
spec:
  containers:
  - image: nginx
    name: bee
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  tolerations:
    - key: "spray"
      operator: "Equal"
      value: "mortein"
      effect: "NoSchedule"
status: {}
```

- edit yaml file add taint info

- untainted the error taint info to node01 and taint the correct value

```shell
controlplane ~ ✖ kubectl taint nodes node01 spary=mo
tein:NoSchedule-
node/node01 untainted

controlplane ~ ➜  kubectl taint nodes node01 spary=mortein:NoSchedule 
node/node01 tainted
```

## Q8

Notice the **bee** pod was scheduled on node **node01** despite the taint.

- shell command

```shell
controlplane ~ ✖ kubectl describe node node01 | grep bee
  System UUID:                299f4064-e3f3-e777-0bee-59b74f3841d6
  default                     bee                      0 (0%)        0 (0%)      0 (0%)           0 (0%)         9m25s
```

## Q9

Do you see any taints on **controlplane** node?

- **ANS**: NoSchedule

- shell command

```shell
controlplane ~ ➜  kubectl describe node controlplane | grep Taint 
Taints:             node-role.kubernetes.io/control-plane:NoSchedule 
```

## Q10

Remove the taint on **controlplane**, which currently has the taint effect of **NoSchedule**.

```shell
controlplane ~ ➜  kubectl taint node controlplane node-role.kubernetes.io/control-plane:NoSchedule-
node/controlplane untainted
```

## Q11

What is the state of the pod **mosquito** now?

- shell command

```shell

controlplane ~ ➜  kubectl get pods mosquito 
NAME       READY   STATUS    RESTARTS   AGE
mosquito   1/1     Running   0          22m
```

## Q12

Which node is the POD **mosquito** on now?

- shell command
- **ANS**: controlplane

```shell
controlplane ~ ➜  kubectl describe pod mosquito
Name:             mosquito
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.168.242.141
```


