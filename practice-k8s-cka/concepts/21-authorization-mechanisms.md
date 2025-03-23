# Authorization Mechanisms

## Node Authorizer

- Used for authorizing kubelet nodes to access required resources.
- Allowing a node to read a pod object.
- No manual configuration is required-Node Authorizer works internally.

## ABAC (Attribute-Based Access Control)

- Use policy files to define access based on user attributes.
- ABAC Policy File

```shell
[
 {
   "apiVersion": "abac.authorization.kubernetes.io/v1beta1", 
   "kind": "Policy",
   "spec": {
     "user": "admin",
     "namespace": "*", 
     "resource": "*", 
     "readonly": false
   }
 }
]
```

- This policy allows user admin to access all resources.
- To use ABAC, start the API server with --authorization-policy-file=policy.json --authorization-mode=ABAC

## RBAC (Role-Based Access Control)

- Grants permissions based on roles. Most commonly used.
- Role & RoleBinding yaml file based

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
  - apiGroups: [ "" ]
    resources: [ "pods" ]
    verbs: [ "get", "watch", "list" ]
---
# Bind the Role to a specific user 'alice'
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: default
  name: pod-reader-binding
subjects:
  - kind: User
    name: alice
    apiGroup: rbac.authorization.k8s.io
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: pod-reader
```

- This allows user alice to read pods in the default namespace

## Webhook Authorization

- Calls an external HTTP service to decide authorization

```yaml
apiVersion: apiserver.config.k8s.io/v1
kind: WebhookAdmissionConfiguration
metadata:
  name: example-webhook
webhooks:
  - name: "custom-auth.example.com"
    clientConfig:
      url: "http://auth-server.example.com/auth"
    rules:
      - apiGroups: [ "*" ]
        resources: [ "*" ]
        verbs: [ "*" ]
```

- Kubernetes will send authorization requests to https://auth-server.example.com/auth.
- The external server decides if access is allowed.

## Authorization Mode

- API Server can support multiple authorization modes, we can specify them like this

```shell
ExecStart=/usr/local/bin/kube-apiserver \\
  --advertise-address=${INTERNAL)IP} \\
  --allow-privileged=true \\
  --apiserver-count=3 \\
  --authorization-mode=Node,RBAC,Webhook \\  # specify multiple authorization mode here 
  --bind-address=0.0.0.0 
```

## Create A RBAC Declaration via YAML

- In the yaml file, we create a role and grant {view pods, create pods, delete pods, and create config
  maps} and corresponding permissions via different resources to the role.
- developer-role.yaml

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer
rules:
  - apiGroups: [ "" ]
    resources: [ "pods" ]
    verbs: [ "list", "get", "create", "update", "delete" ]
  - apiGroups: [ """]
    resources: ["ConfigMap" ]
    verbs: [ "create" ]
```

- Here we declare a role-binding declaration file, and this file gonna bind the user with the role we declare in file
  `developer-role.yaml`
- devuser-developer-binding.yaml
- We can create the role-binding via the command like `kubectl create -f devuser-developer-binding.yaml`

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: devuser-developer-binding
subjects:
  - kind: User
    name: dev-user # this is the user that already created in current k8s context 
    apiGroup: rbac.authroization.k8s.io
roleRef:
  apiGroup: developer
  kind: Role
  name: developer 
```

## Details of the RBAC

- view details of the RBAC we can use

```shell 
kubectl describe rolebinding devuser-developer-binding 
```

## Suppose I'm the user, how to check the access info I was granted

- we can use the `can-i` this command to verify

```shell
kubectl auth can-i create deployments 

kubectl auth can-id delete nodes 
```

- we can also check whether some users are allowed to do some operations to the k8s cluster 
```shell
kbuectl auth can-i create deployments --as dev-user 

kubectl auth can-id create pods --as dev-user 

# we can also specify namespaces in this command 
kubectl auth can-i create pods --as dev-user --na 
```
