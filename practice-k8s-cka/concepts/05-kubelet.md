# Kubelet 

## Kubelet's Responsibility in K8S 
- Register Node 
- Creates Pods 
- Monitor Node & Pods 
- The Kubelet runs on each node and ensures containers are running as expected. 
- It gets instructions from the **kube-apiserver** and manages the lifecycle of pods on its node. 
- It checks the health of containers and restarts them if they fail.
- The Kubelet also reports node status and resource usage to the **kube-apiserver**. 


## Kubelet Service 
```bash 
#kubelet.service 

ExecStart=/usr/local/bin/kubelet \\
 --config=/var/lib/kubelet/kubelet-config.yml \\
 --container-runtime=remote \\
 --container-runtime-endpint=unix:///var/run/containerd/containerd.sock \\
 --image-pull=progress-deadline=2m \\
 --kubeconfig=/var/lib/kubelet/kubeconfig \\
 --network-plugin=cni \\
 --register-node=true \\
 --v=2 
```