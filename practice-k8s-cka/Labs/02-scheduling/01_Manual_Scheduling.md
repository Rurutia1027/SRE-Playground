# Practice Test - Manual Scheduling

## Q1

A pod definition file `nginx.yaml` is given. Create a pod using the file.
Only create the POD for now. We will inspect its status next.

- nginx.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - image: nginx
      name: nginx 
```

- ANS && shell command

```shell 
kubectl apply -f ./nginx.yaml 
```

## Q2

What's the status of the created POD

- shell command

```shell

controlplane ~ ➜  kubectl get pods --namespace=default
NAME    READY   STATUS    RESTARTS   AGE
nginx   0/1     Pending   0          5m18s
```

- **ANS: PENDING**

## Q3

Why is the POD in a pending state?
_Inspect the environment for various kubernetes control plane components_

- shell command to check nginx pod status

```shell
controlplane ~ ✖ kubectl describe pod nginx --namespace=default 
Name:             nginx
Namespace:        default
Priority:         0
Service Account:  default
Node:             <none>
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Containers:
  nginx:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mkz2t (ro)
Volumes:
  kube-api-access-mkz2t:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```

- shell command to describe node

```shell
controlplane ~ ✖ kubectl get pod nginx -o yaml | grep nodeSelector -A 5 

# output nothing here, it means nginx pod assign no selector yet  
```

## Q4

Manually schedule the pod on `node01`.
_Delete and recreate the POD if necessary._

### step-1 Delete the Existing Pod && Get ready Node name

- delete pod

```shell
kubectl delete pod nginx 
```

- get available nodes

```shell
controlplane ~ ➜  kubectl get nodes --namespace=default 
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   21m   v1.32.0
node01         Ready    <none>          20m   v1.32.0
```

### step-2 Update the Pod YAML to Assign It to node01

- Modify your pod YAML to include nodeName: `node01` under spec:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  # manually schedule the pod on node01 
  nodeName: node01
  containers:
    - image: nginx
      name: nginx 
```

### step-3: Apply the Updated YAML

```shell
kubectl apply -f ./nginx.yaml 
```

### step-4: Verify Pod Status

```shell
controlplane ~ ➜  kubectl apply -f nginx.yaml 
pod/nginx created

controlplane ~ ➜  kubectl get pods -o wide 
NAME    READY   STATUS              RESTARTS   AGE   IP       NODE     NOMINATED NODE   READINESS GATES
nginx   0/1     ContainerCreating   0          11s   <none>   node01   <none>           <none>

controlplane ~ ➜  kubectl get pods -o wide 
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          18s   172.17.1.2   node01   <none>           <none>
```

## Q5
Now schedule the same pod on the controlplane node.
_Delete and recreate the POD if necessary._

- shell command for deleting already scheduled pod
```shell
kubectl delete pod nginx 
```

- modify the yaml's node from `node01` to `controlplane`
```shell
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  # manually schedule the pod on node01 
  nodeName: controlplane
  containers:
    - image: nginx
      name: nginx 
```

- shell command check pod status 
```shell
controlplane ~ ➜  kubectl apply -f nginx.yaml 
pod/nginx created

controlplane ~ ➜  kubectl get pods -o wide 
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          8s    172.17.0.4   controlplane   <none>           <none>
```