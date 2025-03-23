# RBAC in Kubernetes (Role Based Access Control)

## Task1

Inspect the environment and identify the authorization modes configured on the cluster.
Check the `kube-apiserver` settings.

### Solutions

- all configs for apiserver in k8s cluster is located under the path /etc/kubernetes/manifest/kube-apiserver.yaml
- the keywords we focus on is authorization-mode

```shell

controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep authorization | grep mode -A5
    - --authorization-mode=Node,RBAC
```

## Task2

How many roles exist in the `default` namespace?

### Solutions

```shell
controlplane ~ ➜  kubectl get roles 
No resources found in default namespace.
```

### Final Answer

```shell
0 
```

## Task 3

How many roles exist in all namespaces together ?

### Solutions

```shell

controlplane ~ ➜  kubectl get roles -A 
NAMESPACE     NAME                                             CREATED AT
blue          developer                                        2025-03-23T09:15:38Z
kube-public   kubeadm:bootstrap-signer-clusterinfo             2025-03-23T09:11:07Z
kube-public   system:controller:bootstrap-signer               2025-03-23T09:11:06Z
kube-system   extension-apiserver-authentication-reader        2025-03-23T09:11:06Z
kube-system   kube-proxy                                       2025-03-23T09:11:08Z
kube-system   kubeadm:kubelet-config                           2025-03-23T09:11:06Z
kube-system   kubeadm:nodes-kubeadm-config                     2025-03-23T09:11:06Z
kube-system   system::leader-locking-kube-controller-manager   2025-03-23T09:11:06Z
kube-system   system::leader-locking-kube-scheduler            2025-03-23T09:11:06Z
kube-system   system:controller:bootstrap-signer               2025-03-23T09:11:06Z
kube-system   system:controller:cloud-provider                 2025-03-23T09:11:06Z
kube-system   system:controller:token-cleaner                  2025-03-23T09:11:06Z

controlplane ~ ➜  kubectl get roles -A --no-headers | wc -l 
12
```

### Final Answer

```shell
12
```

## Task 4

What are the resources the `kube-proxy` role in the `kube-system` namespace is given access to ?

### Solutions

```shell
controlplane ~ ➜  kubectl describe role kube-proxy --namespace=kube-system 
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources   Non-Resource URLs  Resource Names  Verbs
  ---------   -----------------  --------------  -----
  configmaps  []                 [kube-proxy]    [get]

controlplane ~ ➜  
```

### Final Answer

```shell
configmap 
```

## Task 5

What actions can the `kube-proxy` role perform on `configmaps`?

### Solutions

```shell
controlplane ~ ➜  kubectl describe role kube-proxy --namespace=kube-system 
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources   Non-Resource URLs  Resource Names  Verbs
  ---------   -----------------  --------------  -----
  configmaps  []                 [kube-proxy]    [get]

controlplane ~ ➜  
```

### Final Answer

```shell
GET
```

## Task6

Which of the following statements are true?

### Final Answer

```shell
kube-proxy role can get details of configmap object by the name kube-proxy only 
```

## Task 7

Which account is the `kube-proxy` role assign to ?

### Solutions

```shell
controlplane ~ ✖ kubectl describe rolebinding kube-proxy -n kube-system 
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  Role
  Name:  kube-proxy
Subjects:
  Kind   Name                                             Namespace
  ----   ----                                             ---------
  Group  system:bootstrappers:kubeadm:default-node-token  
```

### Final Answer

```shell
 Group  system:bootstrappers:kubeadm:default-node-token  
```

## Task 8

A user `dev-user` is created. User's details have been added to the `kubeconfig` file. Inspect the permissions granted
to the user. Check if the user can list pods in the default namespace.

Use the `--as dev-user` option with `kubectl` to run commands as the `dev-user`.

### Solutions

```shell

controlplane ~ ✖ kubectl get pods -n default --as dev-user 
Error from server (Forbidden): pods is forbidden: User "dev-user" cannot list resource "pods" in API group "" in the namespace "default"

```

### Final Answer

```shell
dev-user do not have the permissions
```

## Task 9

Create the necessary roles and role bindings required for the `dev-user` to create, list and delete pods in the default
namespace.

### Solutions

- Create a Role

```shell
kubectl create role developer --namespace=default --verb=list,create,delete --resource=pods 
```

- Create a RoleBinding

```shell
kubectl create rolebinding dev-user-binding --namespace=default --role=developer --user=dev-user 
```

## Task 10

A set of new roles and role-bindings are created in the blue namespace for the dev-user. However, the dev-user is unable
to get details of the dark-blue-app pod n the blue namespace. Investigate and fix the issue.

### Solutions

- shell command

```shell
controlplane ~ ➜  kubectl describe rolebinding dev-user-binding -n blue 
Name:         dev-user-binding
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  Role
  Name:  developer
Subjects:
  Kind  Name      Namespace
  ----  ----      ---------
  User  dev-user  

kubectl edit role developer -n blue 
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2025-03-23T09:15:38Z"
  name: developer
  namespace: blue
  resourceVersion: "4760"
  uid: c31ae2a9-e893-42db-8537-7ac696110d7d
rules:
  - apiGroups:
      - ""
    resourceNames:
      - blue-app
    resources:
      - pods
    verbs:
      - get
      - watch
      - create
      - delete
  # here we append the new apiGroups in which declare the resource type and 
  # permissions allocated to the user to operate the resource item 
  - apiGroups:
      - ""
    resourceNames:
      - dark-blue-app
    resources:
      - pods
    verbs:
      - get
      - watch
      - create
      - delete
```

- after modifying the yaml as user dev-user we can see the pod

```shell
controlplane ~ ✖ kubectl get pod dark-blue-app -n blue 
NAME            READY   STATUS    RESTARTS   AGE
dark-blue-app   1/1     Running   0          51m

```

## Task 11

Add a new rule in the existing role developer to grant the dev-user permissions to create deployments in the blue
namespace.

_Remember to add api group "apps"_

### Solutions

```yaml
- apiGroups:
    - apps
  resources:
    - deployments
  verbs:
    - create
    - get
    - watch
```

```shell
controlplane ~ ✖ kubectl edit role developer -n blue 
role.rbac.authorization.k8s.io/developer edited

controlplane ~ ➜  kubectl auth can-i create deployment -n blue --as=dev-user
yes
```


