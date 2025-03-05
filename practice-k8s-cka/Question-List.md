# Question List 

## Q1
You have been asked to create a new ClusterRole for a deployment pipeline and build it to a specific ServiceAccount scoped to a specific namespace. 
- Task  
Create a new ClusterRole named depolyment-clusterrole, which only allows to create the following resource types: 
- Deployment 
- Stateful Set 
- Daemon Set 

Create a new ServiceAccount named cicd-token in the existing namespace app-team1. Bind the new ClusterRole deployment-clusterrole to the new ServiceAccount cicd-token, limited to the namespace app-team1. 




```yml 
// yml scripts 
```

```bash 
// bash commands 
```


--- 

## Q2
- Task 
  - Set the node named ek8s-node-0 as unavailable and reschedule all the pods running on it. 


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

--- 

## Q3
- Task
  - Given an existing Kuberntes cluster running version 1.22.1, upgrade all of the Kubernetes control plane and node components on the master node only to version 1.22.2. 
  - Be sure to drain the master node before upgrading it and uncordonit after the upgrade. 


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

---


## Q4
- Task
  - First, create a snapshot of the existing etcd instance running at `https://127.0.0.1:2379`, saving the snapshot to `/var/lib/backup/etcd-snapshot.db`.
  - Next, restore an existing, previouls snapshot located at `/var/lib/backup/etcd-snapshot-previous.db`. 

```yml 
// yml scripts 
```

```bash 
// bash commands 
```


---


## Q5
- Task 
  - Create a new NetworkPolicy named allowed-port-from-namespace in the existing namespace fubar.
  - Ensure that the new NetworkPolicy allows Pods in namespace internal to connect to port 9000 of Pods in namespace fubar. 
  - Further ensure that the new NetworkPolicy: 
    - Does not allow access to Pods, which don't listen on port 9000
    - Does not allow access from Pods, which are not in namespace internal. 

```yml 
// yml scripts 
```

```bash 
// bash commands 
```

--- 

## Q6 
- Task 
- Reconfigure the existing deployment front-end and add a port speficification named http exposing port 80/tcp of the existing container nginx. 
- Create a new service named front-end-svc exposing the container port http.
- Configure the new service to also expose the individual Pods via NodePort on the nodes on which they are scheduled. 


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

---

## Q7 
- Task: 
  - Scale the deployment presentation to 3 pods. 



```yml 
// yml scripts 
```

```bash 
// bash commands 
```


--- 


## Q8 
- Task: 
  - Schedule a pod as follows: 
  - Name: nginx-kusc00401
  - Image: nginx 
  - Node selector: disk=ssd


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

--- 

## Q9 
- Task: 
  - Check to see how many nodes are ready (not including nodes tainted NoSchedule) and write the number to /opt/KUSC00402/kusu00402.txt.   

```yml 
// yml scripts 
```

```bash 
// bash commands 
```


--- 


## Q10
- Task: 
  - Schedule a Pod as follows: 
  - Name: kucc8
  - App Containers: 2 
  - Container Name/Images:
    - nginx 
    - consul

```yml 
// yml scripts 
```

```bash 
// bash commands 
```


--- 


## Q11
- Task: 
  - Create a persistent volume with name app-data, of capacity 2Gi and access mode ReadOnlyMany. The type of volume is hostPath and its location is /srv/app-data. 


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

--- 

## Q12 
- Task: 
  - Monitor the logs of pod foo and 
  - Extract log lines correspoinding to error file-not-found.
  - Write them to /opt/KUTR00101/foo 

```yml 
// yml scripts 
```

```bash 
// bash commands 
```


--- 


## Q13 
* Context: 
  * An existing Pod needs to be integrated into the Kubernetes built-in-logging architecture (e.g., kubectl logs). Adding a streaming sidecar container is a good and common way to accomplish this requirement. 
* Task: 
  * Add a sidecar container named sidecar, using the busybox image, to the existing Pod big-corp-app. The new sidecar container has to run the following command. 
  * Use a Volume, mounted at `/var/log`, to make the log file big-cor-app.log available to the sidecar container. 


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

--- 

## Q14 
* Task: 
  * From the pod label name = overloaded-cpu, find pods running high CPU workloads and write the name of the pod consuming most CPU to the file `/opt` `KUTR0040/KUTR00401.txt` (which already exitst).


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

--- 

## Q15
* Task:
  * A Kuberntes worker node, named **wk8s-node-0** is in state NotReady. Investigate why this is the case, and perform any appropriate steps to bring the node to a Ready state, ensuring that any changes are made permanent. 

```yml 
// yml scripts 
```

```bash 
// bash commands 
```


---


## Q16
* Task: 
  * Create a new PersistentVolumeClaim: 
  * Name: pv-volume
  * Class: csi-hostpath-sc 
  * Capacity: 10Mi 
  * Name: web-server 
  * Image: nginx 
  * Mount Path: /usr/share/nginx/html
  * Configure the new Pod to have ReadWriteOnce access on the volume. Finally, using kubectl edit or kubectl patch expand the PersistentVolumenClaim to a capacity of 70Mi and record that change.  


```yml 
// yml scripts 
```

```bash 
// bash commands 
```


---

## Q17 
* Task: 
  * Create a new nginx Ingress resource as follows: 
  * Name: pong 
  * Namespace: ing-internal 
  * Exposing service hello on path/hello using service port 5678. 

```yml 
// yml scripts 
```

```bash 
// bash commands 
```


---


## Q18
* Doc: Ingress, Service, Deployment, Namespace 
* Task: 
  * Create a new nginx ingress resource as follows:
  * Namespace: ing-internal 
  * Exposing service hi on path /hi using service port 5678

```yml 
// yml scripts 
```

```bash 
// bash commands 
```


--- 

## Q19
* Doc: NetworkPolicy, Pod, Namespace 
* Task:
  * Create a new NetworkPolicy named **allow-port-from-namespace** in the existing namespace echo. 
  * Ensure that the new NetworkPolicy allows Pods in namespace internal to connect to port 9200/tcp of Pods in namespace echo. Further ensure that the new NetworkPolicy. 
    * does not allow access to Pods, which don't listen on 9200/tcp.
    * does not allow access from Pods, which are not in namespace internal.  


```yml 
// yml scripts 
```

```bash 
// bash commands 
```

---

## Q20
* Doc: Pod 
* Task: 
  * Schedule a Pod as follows:
  * Name: kucc1 
  * App Containers: 2 
  * Container Name/Images: 0 redis, 0 consul  

--- 

## Q21
* Doc: Pod, Node 
- Task: Schedule a pod as follows: 
  - Name: nginx-kusc00401
  - Image: nginx
  - Node selector: disk=spinning 

--- 


## Q22
* Doc: Deployment, Pod 
  
- Task: Scale the deployment guestbook to 5 pods. 

--- 

## Q23
* Doc: PersistentVolume, StorageClass  

- Task: Create a persistent volume with name app-data, of capacity 2Gi and access mode ReadWriteOnce. The type of volume is hostPath and its location is `/svr/app-data`. 

