# Node Selector

## Node Selectors Declaration

- pod-definition.yml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  nodeSelector:
    # this pod will be dispatched 
    # =to the nodes that labeled with key&value pair as size=Large 
    size: Large 
```

## Label Nodes

- shell command to label nodes

```shell
# command-pattern: kubectl label nodes <node-name> <label-key>=<label-value>

kubectl label nodes node-1 size=Large  
```