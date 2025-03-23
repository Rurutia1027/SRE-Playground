# Cluster Roles and Role-Binding

## Cluster Roles

### Cluster Admin

- Can View Nodes
- Can Create Nodes
- Can delete Nodes

#### Cluster Admin Definition YAML File

- shell command to create cluster role via yaml file

```shell 
kubectl create -f ./cluster-admin-role.yaml  
```
- cluster-admin-role.yaml 
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-administrator
rules:
  - apiGroups: [ "" ]
    resources: [ "nodes" ]
    verbs: [ "list", "get", "create", "delete" ]
```

- cluster-admin-role-binding.yaml

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-admin-role-binding
subjects:
  - kind: User
    name: cluster-admin
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-administrator
  apiGroup: rbac.authorization.k8s.io
```

### Cluster Admin Role & RoleBinding is Similar as Normal Kubernetes Role & RoleBinding

- First, create cluster role, in the definition yaml file, we specify the resources type (cluster grain, mostly node),
  and the operations we can do upon the resource items.
- Third, after we create the cluster role, we will then create a cluster role binding which bind cluster user and
  cluster role together 

### Storage Admin

- Can view PVs
- Can create PVs
- Can delete PVCs

###    