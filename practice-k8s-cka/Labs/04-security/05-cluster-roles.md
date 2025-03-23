# Cluster Roles Practice Test

## Task 1

For the first few questions of this lab, you would have to inspect the existing `ClusterRoles` and `ClusterRoleBindings`
that have been created in this cluster.

### Shell Commands

```shell 
controlplane ~ ➜  kubectl get clusterrolebindings --no-headers | wc -l 
57

controlplane ~ ➜  kubectl get clusterroles --no-headers | wc -l 
72
```

## Task2

How many `ClusterRoles` do you see in the cluster ?

### Shell Commands

```shell
controlplane ~ ➜  kubectl get clusterrolebindings --no-headers | wc -l 
57
```

### Final Answer

```shell
72
```

## Task 3

How many `ClusterRoleBindings` exist on the cluster?

### Shell Command

```shell
controlplane ~ ➜  kubectl get clusterrolebindings --no-headers | wc -l 
57
```

### Final Answer

```shell
57
```

## Task4

What namespace is the `cluster-admin` clusterrole part of ?

### Shell Commands

```shell
controlplane ~ ➜  kubectl describe clusterrole cluster-admin 
Name:         cluster-admin
Labels:       kubernetes.io/bootstrapping=rbac-defaults
Annotations:  rbac.authorization.kubernetes.io/autoupdate: true
PolicyRule:
  Resources  Non-Resource URLs  Resource Names  Verbs
  ---------  -----------------  --------------  -----
  *.*        []                 []              [*]
             [*]                []              [*]

controlplane ~ ➜  kubectl get clusterrole cluster-admin -o wide 
NAME            CREATED AT
cluster-admin   2025-03-23T12:49:16Z

controlplane ~ ➜  kubectl get clusterrole cluster-admin -o yaml 
apiVersion: rbac.authorization.k8s.io/v1
```

### Final Answer

```shell
Cluster Roles are cluster wide and not part of any namespace
```

## Task 5

What user/groups are the `cluster-admin` role bound to ?
The ClusterRoleBinding for the role is with the same name.

### Shell Commands

```shell

controlplane ~ ➜  kubectl get clusterrole cluster-admin 
NAME            CREATED AT
cluster-admin   2025-03-23T12:49:16Z

controlplane ~ ➜  kubectl get clusterrolebinding cluster-admin 
NAME            ROLE                        AGE
cluster-admin   ClusterRole/cluster-admin   13m

controlplane ~ ➜  kubectl describe clsuterrolebinding cluster-admin 
error: the server doesn't have a resource type "clsuterrolebinding"

controlplane ~ ✖ kubectl describe clusterrolebinding cluster-admin 
Name:         cluster-admin
Labels:       kubernetes.io/bootstrapping=rbac-defaults
Annotations:  rbac.authorization.kubernetes.io/autoupdate: true
Role:
  Kind:  ClusterRole
  Name:  cluster-admin
Subjects:
  Kind   Name            Namespace
  ----   ----            ---------
  Group  system:masters 
```

### Final Answer

```shell
system:masters
```

## Task 6

What level of permission does the `cluster-admin` role grant?
Inspect the `cluster-admin` role's privileges.

### Shell Commands

```shell
controlplane ~ ✖ kubectl describe clusterrole cluster-admin 
Name:         cluster-admin
Labels:       kubernetes.io/bootstrapping=rbac-defaults
Annotations:  rbac.authorization.kubernetes.io/autoupdate: true
PolicyRule:
  Resources  Non-Resource URLs  Resource Names  Verbs
  ---------  -----------------  --------------  -----
  *.*        []                 []              [*]
             [*]                []              [*]
# All allowed 
```

### Final Answer

```shell
Perform any action on any resource in the cluster. 
```

## Task 7

A new user `michelle` joined the team. She will be focusing on the `nodes` in the cluster.
Create the required `ClusterRoles` and `ClusterRoleBindings` so she gets access to the `nodes`.

### Solutions

```yaml
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: node-admin
rules:
  - apiGroups: [ "" ]
    resources: [ "nodes" ]
    verbs: [ "get", "watch", "list", "create", "delete" ]

---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: michelle-binding
subjects:
  - kind: User
    name: michelle
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: node-admin
  apiGroup: rbac.authorization.k8s.io
```

## Task 8

michelle's responsibilities are growing and now she will be responsible for storage as well.
Create the required `ClusterRoles` and `ClusterRoleBindings` to allow her access to Storage.

Get the API Groups and resource names from command `kubectl api-resources`.

### Shell Commands

- First, create clusterrole

```yaml
controlplane ~ ✖ kubectl create clusterrole storage-admin --verb=get,list,create,delete,watch --resource=persistentvolumes,storageclasses
clusterrole.rbac.authorization.k8s.io/storage-admin created
```

- Second, create clusterrolebinding

```shell
controlplane ~ ➜  kubectl create clusterrolebinding michelle-storage-admin --clusterrole=storage-admin --user=michelle 
clusterrolebinding.rbac.authorization.k8s.io/michelle-storage-admin created
```

- Third, verify whether use has allocated the role and has the permissions

```shell
controlplane ~ ➜  kubectl auth can-i get pv --as michelle 
Warning: resource 'persistentvolumes' is not namespace scoped

yes
```