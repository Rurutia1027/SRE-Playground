# Labels and Selectors

## Labels Declaration

- pod-definition.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp
  # declare labels in key & value pair 
  labels:
    app: App1
    function: Front-end

spec:
  containers:
    - name: simple-webapp
      image: simple-webapp
      ports:
        - containerPort: 8080
```

- shell command to use selector to filter specified pods

```shell
kubectl get pods --selector app=App1 
```

## Selectors Declaration in ReplicaSet 
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: simple-webapp
  labels:
    app: App1 # match -- 
    function: Front-end
spec:
  replicas: 3
  selector:
    matchLabels:
      app: App1 # match --
  template:
    metadata:
      labels:
        app: App1  # match --
    spec:
      containers:
        - name: simple-webapp
          image: simple-webapp
```