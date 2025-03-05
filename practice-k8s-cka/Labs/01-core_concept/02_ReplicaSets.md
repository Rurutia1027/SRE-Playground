# ReplicaSets 
## How many PODs exist on the system?

- **ANS**: 0

```bash 

controlplane ~ ➜  kubectl get pods --namespace=default 
No resources found in default namespace.

```


## How many ReplicaSets exist on the system? 
- In the current(default) namespace. 

- **ANS**: 0

```bash 
controlplane ~ ➜  kubectl get rc --namespace=default
No resources found in default namespace.
```

## How about now? How many ReplicaSets do you see ? 
- We just made a few changes!
- **ANS**: 0
```bash 
controlplane ~ ➜  kubectl get replicaset --namespace=default 
NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       90s
```

## How many PODs are DESIRED in the `new-replica-set`? 
- **ANS**: 4 

`Pods Status:  0 Running / 4 Waiting / 0 Succeeded / 0 Failed`

```bash 
controlplane ~ ✖ kubectl describe replicaset new-replica-set --namespace=default 
Name:         new-replica-set
Namespace:    default
Selector:     name=busybox-pod
Labels:       <none>
Annotations:  <none>
Replicas:     4 current / 4 desired
Pods Status:  0 Running / 4 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  name=busybox-pod
  Containers:
   busybox-container:
    Image:      busybox777
    Port:       <none>
    Host Port:  <none>
    Command:
      sh
      -c
      echo Hello Kubernetes! && sleep 3600
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     <none>
Events:
  Type    Reason            Age    From                   Message
  ----    ------            ----   ----                   -------
  Normal  SuccessfulCreate  2m44s  replicaset-controller  Created pod: new-replica-set-476tr
  Normal  SuccessfulCreate  2m44s  replicaset-controller  Created pod: new-replica-set-7b4r2
  Normal  SuccessfulCreate  2m44s  replicaset-controller  Created pod: new-replica-set-nb7rg
  Normal  SuccessfulCreate  2m44s  replicaset-controller  Created pod: new-replica-set-fcllj
```

## What is the image used to create the pods in the `new-replica-set`?
```bash
controlplane ~ ✖ kubectl describe replicaset new-replica-set --namespace=default | grep Image 
    Image:      busybox777
```

## How many PODs are READY in the `new-replica-set`?

- **ANS**: 0  

```bash 
controlplane ~ ➜  kubectl get pods --namespace=default 
NAME                    READY   STATUS             RESTARTS   AGE
new-replica-set-476tr   0/1     ImagePullBackOff   0          8m47s
new-replica-set-7b4r2   0/1     ImagePullBackOff   0          8m47s
new-replica-set-fcllj   0/1     ImagePullBackOff   0          8m47s
new-replica-set-nb7rg   0/1     ImagePullBackOff   0          8m47s

```

## Why do you think the PODs are not ready ? 

- **ANS**: THe `busybox777` image does not exist. 

```bash 
controlplane ~ ➜  kubeclt describe pods new-replica-set-476tr --namespace=default

Events:
  Type     Reason     Age                     From               Message
  ----     ------     ----                    ----               -------
  Normal   Scheduled  9m59s                   default-scheduler  Successfully assigned default/new-replica-set-476tr to controlplane
  Normal   Pulling    7m4s (x5 over 9m59s)    kubelet            Pulling image "busybox777"
  Warning  Failed     7m3s (x5 over 9m58s)    kubelet            Failed to pull image "busybox777": failed to pull and unpack image "docker.io/library/busybox777:latest": failed to resolve reference "docker.io/library/busybox777:latest": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
  Warning  Failed     7m3s (x5 over 9m58s)    kubelet            Error: ErrImagePull
  Normal   BackOff    4m46s (x21 over 9m58s)  kubelet            Back-off pulling image "busybox777"
  Warning  Failed     4m46s (x21 over 9m58s)  kubelet            Error: ImagePullBackOff 
```

## Delete any one of the 4 PODs. 

```bash 
controlplane ~ ➜  kubectl get pods 
NAME                    READY   STATUS             RESTARTS   AGE
new-replica-set-476tr   0/1     ImagePullBackOff   0          11m
new-replica-set-7b4r2   0/1     ImagePullBackOff   0          11m
new-replica-set-fcllj   0/1     ImagePullBackOff   0          11m
new-replica-set-nb7rg   0/1     ErrImagePull       0          11m

controlplane ~ ➜  kubectl delete pod new-replica-set-476tr
pod "new-replica-set-476tr" deleted
```

## How many PODs exist now?
- **ANS**: 4 

```bash 
controlplane ~ ✖ kubectl get pods 
NAME                    READY   STATUS             RESTARTS   AGE
new-replica-set-7b4r2   0/1     ImagePullBackOff   0          11m
new-replica-set-fcllj   0/1     ImagePullBackOff   0          11m
new-replica-set-k8clr   0/1     ImagePullBackOff   0          22s
new-replica-set-nb7rg   0/1     ImagePullBackOff   0          11m
```

## Why are there still 4 PODs, even after you deleted one? 
- **ANS**: Replicaset ensures that desired number of PODs always run. 

## Create a ReplicaSet using the `replicaset-defintiion-1.yaml` file located at `/root/`?
- There is an issue with the file, so try to fix it. 

- After modifying the yaml file and refresh the replicaset   
```yaml 
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-1
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: nginx
        image: nginx
```
- Command to create replicaset 

```bash 
kubectl create -f ./replicaset-definition-1.yaml 
```

- Commands to check replicaset is created successfully.

```bash 
controlplane ~ ➜  kubectl get replicaset
NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       41m
replicaset-1      2         2         2       49s
```


## Fix the issue in the `replicaset-definition-2.yaml` file and create a `ReplicaSet` using it. 

- original `replicaset-definition-2.yaml`
```yaml 
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-2
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
```

- fixed `replicaset-definition-2.yaml`
```yaml 
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-2
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend # fix here 
    spec:
      containers:
      - name: nginx
        image: nginx
```

- Command to refresh and create replciaset 

```bash 
kubectl apply -f ./replicaset-definition-2.yaml 
```

## Delete the two newly create ReplicaSets - `replicaset-1` and `replicaset-2`

```bash 
controlplane ~ ✖ kubectl  get replicaset --namespace=default 
NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       47m
replicaset-1      2         2         2       6m33s
replicaset-2      2         2         2       116s

# delete command 
controlplane ~ ✖ kubectl delete replicaset  replicaset-1
replicaset.apps "replicaset-1" deleted

controlplane ~ ➜  kubectl delete replicaset  replicaset-2
replicaset.apps "replicaset-2" deleted
```

## Fix the original replica set `new-replica-set` to use the correct `busybox` image.

Either delete and recreate the ReplicaSet or Update the existing ReplicaSet and then delete all PODs, so new ones with the correct image will be created. 


- Edit Replicaset command 
```bash 
controlplane ~ ➜  kubectl get pods -o wide 
NAME                    READY   STATUS             RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
new-replica-set-7b4r2   0/1     ImagePullBackOff   0          51m   10.22.0.11   controlplane   <none>           <none>
new-replica-set-fcllj   0/1     ImagePullBackOff   0          51m   10.22.0.12   controlplane   <none>           <none>
new-replica-set-k8clr   0/1     ImagePullBackOff   0          39m   10.22.0.13   controlplane   <none>           <none>
new-replica-set-nb7rg   0/1     ImagePullBackOff   0          51m   10.22.0.10   controlplane   <none>           <none>


# edit 
kubectl edit replicaset new-replicaset 

# delete failed configured image pods 
kubectl deletee pods -l name=busybox-pod 


kbuectl get pods -o wide 
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
new-replica-set-4v8sm   1/1     Running   0          7s    10.22.0.21   controlplane   <none>           <none>
new-replica-set-5mkgr   1/1     Running   0          7s    10.22.0.20   controlplane   <none>           <none>
new-replica-set-j6qlp   1/1     Running   0          7s    10.22.0.18   controlplane   <none>           <none>
new-replica-set-tnxvm   1/1     Running   0          7s    10.22.0.19   controlplane   <none>           <none>
```

## Scale the ReplicaSet to 5 PODs.
-  Use kubectl scale command or edit the replicaset using kubectl edit replicaset.

```bash 
kubectl scale replicaset new-replica-set --replicas=5
```


## Now scale the ReplicaSet down to 2 PODs.
- Use the kubectl scale command or edit the replicaset using kubectl edit replicaset.

```bash 
# open current replicaset' config directly and modiy the replia value from 5 to 2 
# save and exit 
controlplane ~ ✖ kubectl edit replicaset new-replica-set 
replicaset.apps/new-replica-set edited

controlplane ~ ✖ kubectl get pods -o wide 
NAME                    READY   STATUS        RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
new-replica-set-4v8sm   1/1     Terminating   0          3m40s   10.22.0.21   controlplane   <none>           <none>
new-replica-set-5mkgr   1/1     Running       0          3m40s   10.22.0.20   controlplane   <none>           <none>
new-replica-set-j6qlp   1/1     Running       0          3m40s   10.22.0.18   controlplane   <none>           <none>
new-replica-set-n2r8l   1/1     Terminating   0          83s     10.22.0.22   controlplane   <none>           <none>
new-replica-set-tnxvm   1/1     Terminating   0          3m40s   10.22.0.19   controlplane   <none>           <none>

```

