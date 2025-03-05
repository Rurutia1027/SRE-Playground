# Kube-Scheduler 

Kube-Scheduler is only for deciding which **Pod** goes on which **Node**, and it actually does not responsible for placing the **Pod** on the **Nodes** -- this is the job of **kubelet** like the captain on the Ship. 

Kube-Scheduler is focusing on Resource Schedule Strategy like find the best Nodes to satsify the resources reqreuiments of the Pods, instead of executing the actually operations jobs.

Kube-Scheduler first **Filter Nodes** that do not satisfy with the **Pod**'s resource requirements. 
Then Kube-Scheduler **Rank Nodes** in the K8S CLuster by using some priority algorithms, and pick the first ranking one.  


## View kube-scheduler options - kubeadm 

```bash 
cat /etc/kubernetes/manifests/kube-scheduler.yaml 

ps -aux | grep kube-scheduler 
```