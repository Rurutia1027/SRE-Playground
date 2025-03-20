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