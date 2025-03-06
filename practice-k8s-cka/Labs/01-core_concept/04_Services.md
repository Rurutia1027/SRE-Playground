# Practice Test: Services 

## How many Services exist on the system ?
- **ANS**: 1

- Shell Commands 
```bash 
controlplane ~ ➜  kubectl get services 
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   11m
```
- The above service is the default service created by Kubernetes at launch.

## What is the type of the default **Kubernetes** service ? 
- **ANS**: ClusterIP
- Shell Commands:
```shell
controlplane ~ ➜  kubectl get services 
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   5m19s

```

## What is the `targetPort` configured on the **Kubernetes** service?
- **ANS**: 6443

- Shell Commands: 
```shell

controlplane ~ ➜  kubectl get services 
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   8m7s


controlplane ~ ✖ kubectl describe service kubernetes 
Name:                     kubernetes
Namespace:                default
Labels:                   component=apiserver
                          provider=kubernetes
Annotations:              <none>
Selector:                 <none>
Type:                     ClusterIP
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.43.0.1
IPs:                      10.43.0.1
Port:                     https  443/TCP
TargetPort:               6443/TCP
Endpoints:                192.168.48.105:6443
Session Affinity:         None
Internal Traffic Policy:  Cluster
Events:                   <none>

```


## How many labels are configured on the **Kubernetes** service?
- **ANS**: 2 / component=apiserver ; provider=kubernetes 
- Shell Commands: 
```bash 

controlplane ~ ➜  kubectl get services 
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   8m7s

controlplane ~ ✖ kubectl describe service kubernetes 
Name:                     kubernetes
Namespace:                default
Labels:                   component=apiserver
                          provider=kubernetes
Annotations:              <none>
Selector:                 <none>
Type:                     ClusterIP
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.43.0.1
IPs:                      10.43.0.1
Port:                     https  443/TCP
TargetPort:               6443/TCP
Endpoints:                192.168.48.105:6443
Session Affinity:         None
Internal Traffic Policy:  Cluster
Events:  
```


## How many Endpoints are attached on the **kubernetes** service 
- **ANS**: 1  / 192.168.48.105:6443
- Shell Commands: 
```shell 

controlplane ~ ➜  kubectl get services 
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   8m7s

controlplane ~ ✖ kubectl describe service kubernetes 
Name:                     kubernetes
Namespace:                default
Labels:                   component=apiserver
                          provider=kubernetes
Annotations:              <none>
Selector:                 <none>
Type:                     ClusterIP
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.43.0.1
IPs:                      10.43.0.1
Port:                     https  443/TCP
TargetPort:               6443/TCP
Endpoints:                192.168.48.105:6443
Session Affinity:         None
Internal Traffic Policy:  Cluster
Events:  
```


## How many Deployments exist on the system now ? 
- In the current(default) namespace
- **ANS: 1**
- Shell Commands
```shell 
controlplane ~ ➜  kubectl get deployments --namespace=default --no-headers | wc -l
1
```

## What's the image used to create the pods in the deployment?
- **ANS:kodekloud/simple-webapp**
- Shell Commands:
```shell 
controlplane ~ ✖ kubectl get deployments --namespace=default 
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
simple-webapp-deployment   4/4     4            4           2m41s

controlplane ~ ➜  kubectl describe deployment simple-webapp-deployment | grep Image 
    Image:         kodekloud/simple-webapp:red
```


## Are you able to access the Web App UI? 
- Try to access the Web Application UI using the tab `simple-webapp-ui` above the terminal.
- **ANS: NO** there are some 502 Gateway Error 

## Create a new service to access the web application using the `service-definition-1.yaml` file.
- Name: webapp-service
- Type: NodePort 
- targetPort: 8080
- port: 8080
- nodePort: 30080
- selector: name: simple-webapp


- Original YAML File of `service-defintion-1.yaml`
```yaml
#controlplane ~ ➜  cat service-definition-1.yaml 
---
apiVersion: v1
kind: Service
metadata:
  name: 
  namespace: default
spec:
  ports:
  - nodePort: 
    port: 
    targetPort: 
  selector:
    name: 
  type: 
```

- After modify some content's correct `service-defintion-1.yaml`
```yaml
#controlplane ~ ➜  cat runner.yaml
apiVersion: v1
kind: Service
metadata:
  name: webapp-service
  namespace: default
spec:
  ports:
    - nodePort: 30080
      port: 8080
      targetPort: 8080
  selector:
    name: simple-webapp
  type: NodePort
```

- Shell Commands 
```shell 
controlplane ~ ➜  kubectl create -f runner.yaml 
service/webapp-service created

controlplane ~ ✖ kubectl get service --namespace=default 
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
kubernetes       ClusterIP   10.43.0.1      <none>        443/TCP          24m
webapp-service   NodePort    10.43.253.23   <none>        8080:30080/TCP   113s
```

