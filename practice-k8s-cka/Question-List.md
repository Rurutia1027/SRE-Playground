# Question List 

## Q1
You have been asked to create a new ClusterRole for a deployment pipeline and build it to a specific ServiceAccount scoped to a specific namespace. 
- Task  
Create a new ClusterRole named depolyment-clusterrole, which only allows to create the following resource types: 
- Deployment 
- Stateful Set 
- Daemon Set 

Create a new ServiceAccount named cicd-token in the existing namespace app-team1. Bind the new ClusterRole deployment-clusterrole to the new ServiceAccount cicd-token, limited to the namespace app-team1. 


## Q2
- Task 

Set the node named ek8s-node-0 as unavailable and reschedule all the pods running on it. 

## Q3
- Task
- Given an existing Kuberntes cluster running version 1.22.1, upgrade all of the Kubernetes control plane and node components on the master node only to version 1.22.2. 
- Be sure to drain the master node before upgrading it and uncordonit after the upgrade. 

## Q4
- Task
- First, create a snapshot of the existing etcd instance running at `https://127.0.0.1:2379`, saving the snapshot to `/var/lib/backup/etcd-snapshot.db`.
- Next, restore an existing, previouls snapshot located at `/var/lib/backup/etcd-snapshot-previous.db`. 

## Q5
- Task 
- Create a new NetworkPolicy named allowed-port-from-namespace in the existing namespace fubar.
- Ensure that the new NetworkPolicy allows Pods in namespace internal to connect to port 9000 of Pods in namespace fubar. 
- Further ensure that the new NetworkPolicy: 
- - Does not allow access to Pods, which don't listen on port 9000
- - Does not allow access from Pods, which are not in namespace internal. 

## Q6 
- Task 
- Reconfigure the existing deployment front-end and add a port speficification named http exposing port 80/tcp of the existing container nginx. 
- Create a new service named front-end-svc exposing the container port http.
- Configure the new service to also expose the individual Pods via NodePort on the nodes on which they are scheduled. 

## Q18
* Doc  

## Q19
* Doc: NetworkPolicy, Pod, Namespace 
* Task:
  * Create a new NetworkPolicy named **allow-port-from-namespace** in the existing namespace echo. 
  * Ensure that the new NetworkPolicy allows Pods in namespace internal to connect to port 9200/tcp of Pods in namespace echo. Further ensure that the new NetworkPolicy. 
    * does not allow access to Pods, which don't listen on 9200/tcp.
    * does not allow access from Pods, which are not in namespace internal.  

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

