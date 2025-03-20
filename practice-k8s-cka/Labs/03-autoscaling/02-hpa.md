# Practice Test - HPA

## Objectives:

- **HPA** with **Imperative commands**
- **Requirements** for **HPA** to work.
- What happens when **resources.limit** is not mentioned.

## Q1:

- **Create a Deployment**
    - Using the `/root/deployment.yml` manifest file provided, create a Kubernetes deployment for the nginx application.

- ANS:

```shell
controlplane ~ ➜  kubectl apply -f ./deployment.yml 
deployment.apps/nginx-deployment created

controlplane ~ ➜  kubectl getpods 
error: unknown command "getpods" for "kubectl"

controlplane ~ ✖ kubectl get pods 
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-647677fc66-2k62l   1/1     Running   0          7s
nginx-deployment-647677fc66-8fm67   1/1     Running   0          7s
nginx-deployment-647677fc66-jcsv5   1/1     Running   0          7s
nginx-deployment-647677fc66-nd9xp   1/1     Running   0          7s
nginx-deployment-647677fc66-rvcwm   1/1     Running   0          7s
nginx-deployment-647677fc66-v8ncr   1/1     Running   0          7s
nginx-deployment-647677fc66-zj745   1/1     Running   0          7s

controlplane ~ ➜  kubectl get deployment 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   7/7     7            7           13s
```

## Q2:

We have a manifest file to create **autoscaling** for the **Nginx deployment** located at `/root/autoscale.yml`. Review
the manifest file and identify the **current replicas** and **desired replicas**?

- ANS:
    - Current Replicas=0
    - Desired Replicas=0
- shell

```shell
controlplane ~ ➜  cat autoscale.yml 
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  creationTimestamp: null
  name: nginx-deployment
spec:
  maxReplicas: 3
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx-deployment
  targetCPUUtilizationPercentage: 80
status:
  currentReplicas: 0
  desiredReplicas: 0
```

## Q3:

Create an **autoscaler** for the **nginx deployment** with a maximum of 3 replicas and a CPU utilization target of 80%.

```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  creationTimestamp: null
  name: nginx-deployment
spec:
  maxReplicas: 3
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx-deployment
  targetCPUUtilizationPercentage: 80
status:
  currentReplicas: 0
  desiredReplicas: 0
```

- shell

```shell
controlplane ~ ✖ kubectl apply -f autoscale.yml 
horizontalpodautoscaler.autoscaling/nginx-deployment created

controlplane ~ ➜  kubectl get HorizontalPodAutoscaler
NAME               REFERENCE                     TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
nginx-deployment   Deployment/nginx-deployment   cpu: <unknown>/80%   1         3         7          24s
```

## Q4:

What's the **primary purpose** of the **Horizontal Pod Autoscaler(HPA)** in Kubernetes?

- ANS: To automate the scaling of pods based on observed CPU utilization or other select metrics.

## Q5:

What **component** in a Kubernetes cluster is responsible for providing **metrics** to the **HPA**?

- ANS: metrics-server

## Q6:

What's the **current replica count** of **nginx-deployment** after deploying the **autoscaler**?

- shell

```shell

controlplane ~ ➜  kubectl get pods 
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-647677fc66-rvcwm   1/1     Running   0          11m
nginx-deployment-647677fc66-v8ncr   1/1     Running   0          11m
nginx-deployment-647677fc66-zj745   1/1     Running   0          11m

controlplane ~ ➜  kubectl get deployments 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           11m
```

- ANS: 3

## Q7:

What's the **status** of **HAP** target?

- ANS: unknown/80%

```shell 
controlplane ~ ➜  kubectl get hpa
NAME               REFERENCE                     TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
nginx-deployment   Deployment/nginx-deployment   cpu: <unknown>/80%   1         3         3          7m44s

```

## Q8:

The **HPA status** shows /80 for the **CPU target**, what could be a possible reason?

## Q9:

Since the **HPA** was failing due to the **resource field** missing in the **nginx-deployment**, the **resource field**
has been updated in `/root/deployment.yml`. Udpate the **nginx-deployment** using this manifest. **Watch** the changes
made to the **nginx-deployment** by the **HPA** after upgrading by using the `kubectl get hpa --watch` command.

```shell
controlplane ~ ➜  kubectl get hpa --watch 
NAME               REFERENCE                     TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
nginx-deployment   Deployment/nginx-deployment   cpu: <unknown>/80%   1         3         7          12m
nginx-deployment   Deployment/nginx-deployment   cpu: 0%/80%          1         3         3          12m
```

## Q10:

What does the vent `ScalingReplicaSet` in the **nginx-deployment** HPA indicate?

- shell

```shell
controlplane ~ ➜  kubectl events hpa nginxdeployment | grep ScalingReplicaSet 
21m                    Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled up replica set nginx-deployment-647677fc66 from 0 to 7
14m                    Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled down replica set nginx-deployment-647677fc66 from 7 to 3
2m5s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled down replica set nginx-deployment-647677fc66 from 7 to 6
2m5s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled up replica set nginx-deployment-7998fdcbb8 from 0 to 2
2m5s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled up replica set nginx-deployment-647677fc66 from 3 to 7
2m4s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled up replica set nginx-deployment-7998fdcbb8 from 2 to 3
2m2s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled down replica set nginx-deployment-647677fc66 from 6 to 5
2m1s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled up replica set nginx-deployment-7998fdcbb8 from 4 to 5
2m1s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled down replica set nginx-deployment-647677fc66 from 4 to 3
2m1s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled down replica set nginx-deployment-647677fc66 from 5 to 4
2m1s                   Normal    ScalingReplicaSet              Deployment/nginx-deployment                Scaled up replica set nginx-deployment-7998fdcbb8 from 3 to 4
95s (x7 over 2m1s)     Normal    ScalingReplicaSet              Deployment/nginx-deployment                (combined from similar events): Scaled down replica set nginx-deployment-7998fdcbb8 from 3 to 1
```

- ANS: The HPA is increasing the number of the pods.

## Q12:

What is the cause of the `FailedGetResourceMetric` event in the **nginx-deployment** HPA?

```shell
controlplane ~ ➜  kubectl events hpa nginx-deployment | grep FailedGetResourceMetric
14m                     Warning   FailedGetResourceMetric        HorizontalPodAutoscaler/nginx-deployment   failed to get cpu utilization: missing request for cpu in container nginx of Pod nginx-deployment-647677fc66-rvcwm
14m (x7 over 16m)       Warning   FailedGetResourceMetric        HorizontalPodAutoscaler/nginx-deployment   failed to get cpu utilization: missing request for cpu in container nginx of Pod nginx-deployment-647677fc66-v8ncr
7m (x20 over 17m)       Warning   FailedGetResourceMetric        HorizontalPodAutoscaler/nginx-deployment   failed to get cpu utilization: missing request for cpu in container nginx of Pod nginx-deployment-647677fc66-zj745
```
