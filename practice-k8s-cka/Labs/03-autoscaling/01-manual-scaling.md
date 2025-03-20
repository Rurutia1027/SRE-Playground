# Autoscaling: Manual Scaling

## Q1: Manual Scaling of a Kubernetes Deployment

- Objectives:
    - Understand the concept of scaling in Kubernetes.
    - Manually scale a deployment up and down.
    - Observe the effects of scaling on the application and resources.

## Q2: Create a Deployment

- Create a Deployment
  Use the `/root/deployment.yml` manifest file provided, create a Kubernetes deployment for the Flask application.

- Discovery
    - Use `kubectl get deployments` to observe the deployment status.
    - Use `kubectl get pods` to see the running pods.

```yaml
# deployment.yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-web-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
        - name: flask
          image: rakshithraka/flask-web-app
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: flask-web-app-service
spec:
  type: ClusterIP
  selector:
    app: flask-app
  ports:
    - port: 80
      targetPort: 80
```

- ANS
```shell

controlplane ~ ➜  kubectl apply -f deployment.yml 
deployment.apps/flask-web-app created
service/flask-web-app-service created

controlplane ~ ➜  kubectl get deployments -o wide 
NAME            READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                       SELECTOR
flask-web-app   0/2     2            0           8s    flask        rakshithraka/flask-web-app   app=flask-app

controlplane ~ ➜  kubectl get pods 
NAME                             READY   STATUS    RESTARTS   AGE
flask-web-app-584dd886c8-82zwb   1/1     Running   0          23s
flask-web-app-584dd886c8-cfztr   1/1     Running   0          23s
```

## Q3: What's he primary purpose of the kubectl scale command?

- ANS: To adjust the number of replicas in a deployment or replicaset.

## Q4: Can the kubectl scale command be used to scale down a statefulset in Kubernetes

- ANS: Yes, both statefulsets can deployments can use kubectl scale command

## Q5: Manual Scale

Manually scale the deployment named flask-web-app to have 3 replicas.

Observation
Observe the changes with kubectl get deployments and kubectl get pods.

- ANS

```shell
controlplane ~ ➜  kubectl scale deployment/flask-web-app --replicas=3
deployment.apps/flask-web-app scaled

controlplane ~ ➜  kbuectl ^C

controlplane ~ ✖ kubectl get pods 
NAME                             READY   STATUS    RESTARTS   AGE
flask-web-app-584dd886c8-82zwb   1/1     Running   0          4m56s
flask-web-app-584dd886c8-cfztr   1/1     Running   0          4m56s
flask-web-app-584dd886c8-hsbwm   1/1     Running   0          5s

controlplane ~ ➜  kubectl get deployment 
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
flask-web-app   3/3     3            3           5m5s
```

## Q6:

If you have scale a deployment using `kubectl scale` to higher number of replicas, but the cluster has insufficient
resources to accommodate all new replicas, what will happen?

- ANS:
  Some replicas will be created up to the limit of available resources, and the deployment will remain in a pending
  state for the remaining replicas.