# Manual Scheduling

## Basic Pod Scheduling (Default Behavior)

By default, Kubernetes schedules a Pod **automatically** too any availabe Node.

### Example: Simple Pod (No Constrains)

- my-pod.yml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: nginx
      image: nginx 
```

### Command to Apply

```shell 
kubectl apply -f ./my-pod.yml
```
## Assign Pod to a Specific Node (nodeSelector)
Use `nodeSelector` to schedule a Pod on a specific Node with a matching label. 

### Example: Assign Pod to a Node with `role=worker`
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod 

```