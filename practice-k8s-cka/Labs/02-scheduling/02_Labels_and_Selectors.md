# Practice Tests - Labels and Selectors

## Q1

We have deployed a number of PODs. They are labelled with `tier`, `env` and `bu`.
How many PODs exist in the `dev`?

- **ANS**: 7

- shell command

```shell
# env is label key, dev is label value 

controlplane ~ ➜  kubectl get pods --selector env=dev 
NAME          READY   STATUS    RESTARTS   AGE
app-1-ft8r8   1/1     Running   0          6m54s
app-1-v9hnn   1/1     Running   0          6m54s
app-1-xlk87   1/1     Running   0          6m54s
db-1-5p7vm    1/1     Running   0          6m54s
db-1-7th5p    1/1     Running   0          6m54s
db-1-bpsbp    1/1     Running   0          6m54s
db-1-znfzd    1/1     Running   0          6m54s

controlplane ~ ➜  kubectl get pods --selector env=dev --no-headers 
| wc -l 
7
```

## Q2

How many PODs are in the `finance` business unit(`bu`)?

- shell command

```shell
controlplane ~ ➜  kubectl get pods --selector bu=finance
NAME          READY   STATUS    RESTARTS   AGE
app-1-ft8r8   1/1     Running   0          13m
app-1-v9hnn   1/1     Running   0          13m
app-1-xlk87   1/1     Running   0          13m
app-1-zzxdf   1/1     Running   0          13m
auth          1/1     Running   0          13m
db-2-6xz6z    1/1     Running   0          13m

controlplane ~ ➜  kubectl get pods --selector bu=finance --no-headers | wc -l 
6

```

- **ANS: 6**

## Q3:

How many objects are in the `prod` environment including PODs, ReplicaSets and any other objects?

- shell command

```shell
controlplane ~ ➜  kubectl get all --selector env=prod
NAME              READY   STATUS    RESTARTS   AGE
pod/app-1-zzxdf   1/1     Running   0          15m
pod/app-2-tcg26   1/1     Running   0          15m
pod/auth          1/1     Running   0          15m
pod/db-2-6xz6z    1/1     Running   0          15m

NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/app-1   ClusterIP   10.43.116.25   <none>        3306/TCP   15m

NAME                    DESIRED   CURRENT   READY   AGE
replicaset.apps/app-2   1         1         1       15m
replicaset.apps/db-2    1         1         1       15m

controlplane ~ ➜  kubectl get all --selector env=prod --no-headers | wc -l 
7
```

- **ANS**: 7

## Q4

Identify the POD which is part of the `prod` environment, the finance BU and of `frontend` tier?

- **ANS** only app-1-zzxdf this one appears in the option

- shell command

```shell
controlplane ~ ➜  kubectl get pods --selector env=prod --selector  bu=finance --selector tier=frontend 
NAME          READY   STATUS    RESTARTS   AGE
app-1-ft8r8   1/1     Running   0          18m
app-1-v9hnn   1/1     Running   0          18m
app-1-xlk87   1/1     Running   0          18m
app-1-zzxdf   1/1     Running   0          18m
app-2-tcg26   1/1     Running   0          18m

```





