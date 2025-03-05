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