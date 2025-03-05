# Practice Tests - Deployments

## How many PODs exist on the system? 
- In the current(default) namespace. 
 

- **ANS**: 0

- Shell command 
```bash
controlplane ~ ➜  kubectl get pods --namespace=default 
No resources found in default namespace.
```

--- 

## How many ReplicaSets exist on the system? 
- In the current(default) namespace. 
- **ANS**: 0
  
- bash command 
```bash 
controlplane ~ ➜  kubectl get rc --namespace=default 
No resources found in default namespace.

controlplane ~ ➜  kubectl get replicasets --namespace=default 
No resources found in default namespace.
```

--- 

## How many Deployments exist on the system?
- In the current(default) namespace. 

- **ANS**: 4
- Shell Command:  
```bash 
controlplane ~ ➜  kubectl get deployments --namespace=default 
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
frontend-deployment   0/4     4            0           67s

controlplane ~ ➜  kubectl get deployments --namespace=default --no-headers | wc -l 
1
```

--- 

## How many ReplicaSets exist on the system now? 
- **ANS**: 1  

- Shell Command: 

```bash 
controlplane ~ ➜  kubectl get replicasets --namespace=default 
NAME                           DESIRED   CURRENT   READY   AGE
frontend-deployment-cd6b557c   4         4         0       3m27s

controlplane ~ ➜  kubectl get replicasets --namespace=default --no-headers | wc -l 
1
```

--- 

## How many PODs exist on the system now? 

- **ANS**: 4 

- Shell Command: 

```bash 
controlplane ~ ➜  kubectl get pods --namespace=default --no-headers | wc -l 
4
```

--- 

## Out of all the existing PODs, how many are ready?
- **ANS**: 
- Shell Command: 
```bash 
controlplane ~ ➜  kubectl get pods --namespace=default -o custom-columns="READY:.status.containerStatuses[*].ready"
READY
false
false
false
false

# or 
controlplane ~ ➜  kubectl get pods --namespace=default -o custom-columns="READY:.status.containerStatuses[*].ready" --no-headers | wc -l 

0 
```

---

## What is the image used to create the pods i the new deployment ? 
- **ANS**: `BUSYBOX888`
  
```bash 
controlplane ~ ✖ kubectl describe deployment frontend-deployment | grep Image 
    Image:      busybox888
```


--- 

## Why do you think the deployment is not ready?

- **ANS**: The image BUSYBOX888 doesn't exist.

`failed to pull and unpack image "docker.io/library/`

```bash 
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  3m1s               default-scheduler  Successfully assigned default/frontend-deployment-cd6b557c-4hqss to controlplane
  Normal   BackOff    17s (x10 over 3m)  kubelet            Back-off pulling image "busybox888"
  Warning  Failed     17s (x10 over 3m)  kubelet            Error: ImagePullBackOff
  Normal   Pulling    4s (x5 over 3m)    kubelet            Pulling image "busybox888"
  Warning  Failed     4s (x5 over 3m)    kubelet            Failed to pull image "busybox888": failed to pull and unpack image "docker.io/library/busybox888:latest": failed to resolve reference "docker.io/library/busybox888:latest": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
  Warning  Failed     4s (x5 over 3m)    kubelet            Error: ErrImagePull
```

--- 

## Create a new Deployment using the `deployment-definition-1.yaml` file located at `/root/`.

- **ANS**: `Deployment`'s **D** should be in captital. 
  
- `deployment-definition-1.yaml` 
```yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment-1
spec:
  replicas: 2
  selector:
    matchLabels:
      name: busybox-pod
  template:
    metadata:
      labels:
        name: busybox-pod
    spec:
      containers:
      - name: busybox-container
        image: busybox888
        command:
        - sh
        - "-c"
        - echo Hello Kubernetes! && sleep 3600
```

--- 

## Create a new Deployment with the below attributes using your own deployment defintion file. 

- Create a new deployment with command below: 
```bash 
kubectl create deployment httpd-frontend  --image=httpd:2.4-alpine --replicas=3  --dr
y-run=client -o yaml > a.yml 
```

- Check `a.yml`
```bash 
controlplane ~ ➜  cat a.yml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: httpd-frontend
  name: httpd-frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: httpd-frontend
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: httpd-frontend
    spec:
      containers:
      - image: httpd:2.4-alpine
        name: httpd
        resources: {}
status: {}
```
- Run commands after checking `a.yml`
```
kubectl apply -f ./a.yml 

kbuectl get deployment 

controlplane ~ ➜  kubectl get deployments 
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment-1          0/2     2            0           16m
frontend-deployment   0/4     4            0           22m
httpd-frontend        3/3     3            3           4m2s
```


