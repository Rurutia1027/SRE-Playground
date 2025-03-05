# Practice Test PODs 

## How many pods exist on the system? In the current(default) namespace? 

```bash 
# method-1 by specifying namespace 
controlplane ~ ➜  kubectl get pods --namespace=default | wc -l 
No resources found in default namespace.
0

# method-2
controlplane ~ ➜  kubectl get pods | wc -l 
No resources found in default namespace.
0
```


## Create a new pod with the `nginx` image


```bash 
# create pod with nginx image 
controlplane ~ ➜  kubectl run nginx-pod --image=nginx --restart=Never 
pod/nginx-pod created

# check whether nginx pod is setup successfully
controlplane ~ ✖ kubectl get  pods --namespace=default  | grep nginx 
nginx-pod       1/1     Running   0          33s
```

### Notes 
- `kubectl run`: Creates a new pod. 
- `nginx-pod`: The name of the pod. 
- `--image=nginx`: Specifies the container image to use. 
- `--restart=Never`: Ensures that a standalone pod is created (instead of a Deployment or ReplicaSet). 

## How many pods are created now? 
- Note: We have created a fe more pods. So splease check again in the current(default) namespace. 

```shell 
controlplane ~ ➜  kubectl get pods --namespace=default | wc -l 
5

controlplane ~ ➜  kubectl get pods --namespace=default --no-headers | wc -l
4
```

### Notes: 
We need to use the command with `-no-headers` to avoid the name column is calculated into the final result. 


## What is the image used to create the new pods? 
- You must look at one of the new pods in detail to figure out. 

```bash 
# list all the pods in namespace of default 
controlplane ~ ➜  kubectl get pods 
NAME            READY   STATUS    RESTARTS   AGE
newpods-d6trf   1/1     Running   0          11m
newpods-jgj62   1/1     Running   0          11m
newpods-vsc26   1/1     Running   0          11m
nginx-pod       1/1     Running   0          10m


# describe one of the pod in detail and grep key words 
controlplane ~ ➜  kubectl describe newpods-d6trf | grep image 
error: the server doesn't have a resource type "newpods-d6trf"

controlplane ~ ✖ kubectl describe pod newpods-d6trf | grep image 
  Normal  Pulling    12m   kubelet            Pulling image "busybox"
  Normal  Pulled     12m   kubelet            Successfully pulled image "busybox" in 298ms (298ms including waiting). Image size: 2167176 bytes.
```


### Notes: 
```bash 
kubectl describe pod <pod-name> --namespace=default 
```

## Which node are these pods placed on? 
- You must look at all pods in detail to figure out. 

- To find the node where pods are placed, we can describe each pod in the default namespace. 
```bash 
kubectl describe pod <pod-name> --namespace=default 
```


- Answer
```bash 
controlplane ~ ➜  kubectl get pods 
NAME            READY   STATUS    RESTARTS   AGE
newpods-d6trf   1/1     Running   0          14m
newpods-jgj62   1/1     Running   0          14m
newpods-vsc26   1/1     Running   0          14m
nginx-pod       1/1     Running   0          13m

controlplane ~ ➜  kubectl describe pod newpods-d6trf | grep Node 
Node:             controlplane/192.168.104.63
Node-Selectors:              <none>

controlplane ~ ➜  kubectl describe pod nginx-pod  | grep Node 
Node:             controlplane/192.168.104.63
Node-Selectors:              <none>

controlplane ~ ➜  kubectl describe pod newpods-jgj62 | grep Node 
Node:             controlplane/192.168.104.63
Node-Selectors:              <none>

controlplane ~ ➜  kubectl describe pod newpods-vsc26 | grep Node 
Node:             controlplane/192.168.104.63
Node-Selectors:              <none>
```


## How many containers are part of the pod `webapp`? 
- Note: We just created a new POD. Ignore the state of the pod for now.
   
```bash 

controlplane ~ ➜  kubectl get pods --namespace=default 
NAME            READY   STATUS             RESTARTS      AGE
newpods-d6trf   1/1     Running            1 (64s ago)   17m
newpods-jgj62   1/1     Running            1 (64s ago)   17m
newpods-vsc26   1/1     Running            1 (64s ago)   17m
nginx-pod       1/1     Running            0             16m
webapp          1/2     ImagePullBackOff   0             71s

controlplane ~ ➜  kubectl describe pod webapp | grep container 
    Container ID:   containerd://aa003f3080e223ff170c99e128a1e42895d082e7215fc44e38656d3576f30a91
  Normal   Created    93s                kubelet            Created container: nginx
  Normal   Started    92s                kubelet            Started container nginx
```

## What images are used in the new `webapp` pod? 
- You must look at all the pods in detail to figureout this out. 

```bash 
controlplane ~ ➜  kubectl get pods --namespace=default 
NAME            READY   STATUS             RESTARTS        AGE
newpods-d6trf   1/1     Running            1 (2m57s ago)   19m
newpods-jgj62   1/1     Running            1 (2m57s ago)   19m
newpods-vsc26   1/1     Running            1 (2m57s ago)   19m
nginx-pod       1/1     Running            0               18m
webapp          1/2     ImagePullBackOff   0               3m4s

controlplane ~ ➜  kubectl describe pod webapp | grep image 
  Normal   Pulling    3m13s                kubelet            Pulling image "nginx"
  Normal   Pulled     3m13s                kubelet            Successfully pulled image "nginx" in 190ms (190ms including waiting). Image size: 72195292 bytes.
  Normal   Pulling    16s (x5 over 3m12s)  kubelet            Pulling image "agentx"
  Warning  Failed     15s (x5 over 3m12s)  kubelet            Failed to pull image "agentx": failed to pull and unpack image "docker.io/library/agentx:latest": failed to resolve reference "docker.io/library/agentx:latest": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
  Normal   BackOff    2s (x13 over 3m11s)  kubelet            Back-off pulling image "agentx"

controlplane ~ ➜  
```