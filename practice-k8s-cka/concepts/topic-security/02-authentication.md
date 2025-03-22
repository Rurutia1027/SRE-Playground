# Authentication

## Different Roles

- Admins
- Developers
- Application End Users
- Bots

## Accounts We Care About in Kubernetes Authentications

### Users Accounts

- Admins
- Developers

### User Accounts Authentication Mechanisms

- Static password file
- Static token file
- Certificate
- Identity service

### Mechanisms -- Basic

- user passwords, roles, names are stored in a csv file like `user-details.csv`
- every time we invoke kube-apiserver via the command like this:

```shell
kube-apiserver --basic-auth-file=user-details.csv
```

### Service Accounts

- Bots

### Differences Between the Users Accounts and Service Accounts

- User Accounts can not be created via the commands below:

```shell
# those commands are not support or allowed in Kubernetes Cluster 
kubectl create user user1 
kubectl list users  
```

- Service Accounts can be created via the commands below:

```shell 
kubectl create serviceaccount sa1 

kubectl get serviceaccount
```



 