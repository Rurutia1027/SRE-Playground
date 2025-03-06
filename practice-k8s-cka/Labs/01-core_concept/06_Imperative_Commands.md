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