# Practice Test: Imperative Commands

```shell
In this lab, you will get hands-on practice with creating Kubernetes objects imperatively.

All the questions in this lab can be dnoe immediatly. 
However, for some questions, you may need to first create YAML file using imperative methods.
You can then modify the YAML according to the need and create the object using kubectl apply -f command. 
```

## Q1: Deploy a pod named `nginx-pod` using the `nginx:alpine` image.

- Use imperative commands only.

```shell
controlplane ~ ✖ kubectl run nginx-pod --image=nginx:alpine 
pod/nginx-pod created

controlplane ~ ➜  kubectl get pods 
NAME        READY   STATUS    RESTARTS   AGE
nginx-pod   1/1     Running   0          5s
```

## Q2: Deploy a `redis` pod using the `redis:alpine` image with the label set to `tier=db`.

_Either use imperative commands to create the pod with the labels. Or else use imperative commands to generate the pod
definition file, then add the labels before creating the pod using the file._

```shell
controlplane ~ ➜  kubectl run redis --image=redis:alpine --dry-run=client -o yaml >redis.yaml 

controlplane ~ ✖ kubectl get pods 
NAME        READY   STATUS    RESTARTS   AGE
nginx-pod   1/1     Running   0          3m6s

controlplane ~ ➜  vim redis.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: redis
    tier: db # add label tier here 
  name: redis
spec:
  containers:
  - image: redis:alpine
    name: redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  kubectl describe pod redis | grep Label
Labels:           run=redis
```

## Create a service `redis-service` to expose the `redis` application within the cluster on port `6379`.

_Use imperative commands._

```shell
# first check that pod of redis is running 
controlplane ~ ✖ kubectl get pods 
NAME        READY   STATUS    RESTARTS   AGE
nginx-pod   1/1     Running   0          9m24s
redis       1/1     Running   0          5m25s


# then expose the specified port 6379 and declare it as service
controlplane ~ ✖ kubectl expose pod redis --name=redis-service --port=6379 --target-port=6379 --type=ClusterIP
service/redis-service exposed

# then verify the service is create and runs as expected status 
controlplane ~ ➜  kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
kubernetes      ClusterIP   10.43.0.1      <none>        443/TCP    26m
redis-service   ClusterIP   10.43.30.148   <none>        6379/TCP   11s
```

### Notes && Explanations

- `kubectl expose`: Creates a Service from an existing resource.
- `pod redis`: Assumes a pod named `redis` is running expose it's inner serices out.
- `--name=redis-service`: Declare the name of service
- `--port=6379`: Forwards traffic to container port 6379.
- `--target-port=6379`: Forwards traffic to container port 6379.
- `--type=ClusterIP`: Ensures the service is only accessible within the cluster(not exposed to the external).

## Create a deployment named `webapp` using the image `kodekloud/webapp-color` with `3` replicas.

_Try to use imperative commands only. do not create definition files_

```shell
controlplane ~ ➜  kubectl create deployment webapp --image=kodekloud/webapp-color 
deployment.apps/webapp created

controlplane ~ ➜  kubectl get deployment 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
webapp   1/1     1            1           11s

controlplane ~ ➜  kubectl edit deployment webapp
deployment.apps/webapp edited

# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2025-03-06T08:15:17Z"
  generation: 1
  labels:
    app: webapp
  name: webapp
  namespace: default
  resourceVersion: "1377"
  uid: 80cc2223-e846-41c1-8559-186f0b56e3ab
spec:
  progressDeadlineSeconds: 600
  replicas: 3 # update this from 1 to 3 
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: webapp
      
# verify whether target deployment's replica has been updated to 3 
controlplane ~ ➜  kubectl get deployments 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
webapp   3/3     3            3           56s
```

## Create a new pod called `custom-nginx` using the `nginx` image and run it on `container port 8080`.

```shell
controlplane ~ ➜  kubectl run custom-nginx --image=nginx --port=8080
pod/custom-nginx created

controlplane ~ ➜  kubectl get pods -o wide 
NAME                     READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
custom-nginx             1/1     Running   0          8s    10.22.0.16   controlplane   <none>           <none>
nginx-pod                1/1     Running   0          37m   10.22.0.9    controlplane   <none>           <none>
redis                    1/1     Running   0          33m   10.22.0.10   controlplane   <none>           <none>
webapp-647f97789-m8m7q   1/1     Running   0          10m   10.22.0.13   controlplane   <none>           <none>
webapp-647f97789-shx4g   1/1     Running   0          11m   10.22.0.11   controlplane   <none>           <none>
webapp-647f97789-z5s69   1/1     Running   0          10m   10.22.0.12   controlplane   <none>           <none>
```

## Create a new namspace called `dev-ns`.

_Use imperative commands_

```shell
controlplane ~ ➜  kubectl create namespace dev-ns
namespace/dev-ns created

controlplane ~ ✖ kubectl get namespaces | grep dev-ns
dev-ns            Active   24s
```

## Create a new deployment called `redis-deploy` in the `dev-ns` namespace with the `redis` image. It should have

`2` replicas.

```shell
controlplane ~ ✖ kubectl create deployment redis-deploy --image=redis --namespace=dev-ns 
deployment.apps/redis-deploy created

controlplane ~ ➜  kubectl get deployments --namespace=dev-ns
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
redis-deploy   1/1     1            1           42s

controlplane ~ ➜  kubectl edit deployment redis-deploy --namespace=dev-ns 
deployment.apps/redis-deploy edited

controlplane ~ ➜  kubectl get deployments --namespace=dev-ns
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
redis-deploy   2/2     2            2           74s
```

## Create a pod called `httpd` using the image `httpd:alpine` in the default namespace. Next, create a service of type
## `ClusterIP` by the same name(`httpd`). The target port for the service should be `80`.

```shell
controlplane ~ ➜  kubectl run httpd --image=httpd:alpine --namespace=default 
pod/httpd created

controlplane ~ ➜  kubectl get pods 
NAME                     READY   STATUS    RESTARTS   AGE
custom-nginx             1/1     Running   0          8m26s
httpd                    1/1     Running   0          5s
nginx-pod                1/1     Running   0          45m
redis                    1/1     Running   0          41m
webapp-647f97789-m8m7q   1/1     Running   0          18m
webapp-647f97789-shx4g   1/1     Running   0          19m
webapp-647f97789-z5s69   1/1     Running   0          18m

controlplane ~ ➜  kubectl expose pod httpd --name=httpd --port=80 --target-port=80 --type=ClusterIP
service/httpd exposed

controlplane ~ ➜  kubectl get svc 
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
httpd           ClusterIP   10.43.18.89    <none>        80/TCP     7s
kubernetes      ClusterIP   10.43.0.1      <none>        443/TCP    57m
redis-service   ClusterIP   10.43.30.148   <none>        6379/TCP   30m

```

