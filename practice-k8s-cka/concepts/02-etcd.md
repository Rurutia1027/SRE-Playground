# ETCD and ETCD in K8S

## What's ETCD 

- ETCD is a distributed reliable key-value store that is Simple, Secure & Fast 

## ETCD Comands 
```bash
# declare the etcd api verison  
export ETCDCTL_API=3 ./etcdctl version 
# or 
./etcdctl --version

# insert key & value to kv store of etcd
./etcdctl put key1 value1 

# get value from kv store of etcd 
./etcdctl get key1
```

## ETCD's Role in Kubernetes 

ETCD's configured upon the K8S is different by its setup types. 


### Setup - Manual 
If we setup ETCD by manual then we need to make sure that it is correctly configured in K8S, by following commands: 

- Download 
```bash 
wget -q --https-only \
    "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.0-linux-amd64.tar.gz"
```

- Configure ETCD in Master Node Config Manually 
```bash 
# etcd.service 
ExecStart=/usr/local/bin/etcd \\
--name ${ETCD_NAME} \\
--cert-file=/etc/etcd/kuberntes.pem \\
--key-file=/etc/etcd/kuberntes-key.pem \\
--peer-cert-file=/etc/etcd/kuberntes.pem \\
--peer-key-file=/etc/etcd/kuberntes-key.pem \\
--trusted-ca-file=/etc/etcd/ca.pem \\
--peer-trusted-ca-file=/etc/etcd/ca.pem \\
--peer-client-cert-auth \\
--client-cert-auth \\
--initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\
--listen-peer-urls https://${INTERNAL_IP}:2380 \\
--listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\
# default port that etcd service listens 2379 
# URL should be configured in kube-api server 
--advertise-client-urls https://${INTERNAL_IP}:2379 \\ 
--initial-cluster-token etcd-cluster-0 \\
--initial-cluster controller-0=https://${CONTROLLER0_IP}:2380,controller-1=https://${CONTROLLER1_IP}:2380 \\
--initial-cluster-state new \\
--data-dir=/var/lib/etcd 
```


### Setup - kubeadm 
If we setup the K8S via kubeadm, then we can use the command to verify whether the kube-system's etcd service is setup correctly. 

```bash 
kubectl get pods -n kube-system 

NAMESPACE       NAME                READY               STATUS          RESTARTS            AGE 
kube-system     etcd-master         1/1                  Running         0                  1h 
```



## Explore ETCD 

- This command shows several information about the etcd service, Rgistry of minions, pods, replicasets, deployments, roles, secrets.  

```bash 
kubectl exec etcd-master -n kube-system etcdtcl get / --prefix -keys-only 
# those are services run inside the etcd-master POD
/registry/apiregisgration.k8s.io/apiservices/v1.
/registry/apiregisgration.k8s.io/apiservices/v1.apps
/registry/apiregisgration.k8s.io/apiservices/v1.authentication.k8s.io
/registry/apiregisgration.k8s.io/apiservices/v1.authorization.k8s.io
/registry/apiregisgration.k8s.io/apiservices/v1.autoscaling 
/registry/apiregisgration.k8s.io/apiservices/v1.batch 
/registry/apiregisgration.k8s.io/apiservices/v1.networking.k8s.io
/registry/apiregisgration.k8s.io/apiservices/v1.rbac.authorization.k8s.io
/registry/apiregisgration.k8s.io/apiservices/v1.storage.k8s.io
/registry/apiregisgration.k8s.io/apiservices/v1beta1.admissionregistration.k8s.io
```

And in a high-availability environment you have multiple master nodes, and that means you have multiple ETCD master services running on them. We need to make sure that Those distributed deployed ETCD nodes know each other by configuring the following parameters. 

```bash 
# etcd.service 

ExecStart=/usr/local/bin/etcd \\
--name ${ETCD_NAME} \\
--cert-file=/etc/etcd/kuberntes.pem \\
--key-file=/etc/etcd/kuberntes-key.pem \\
--peer-cert-file=/etc/etcd/kuberntes.pem \\
--peer-key-file=/etc/etcd/kuberntes-key.pem \\
--trusted-ca-file=/etc/etcd/ca.pem \\
--peer-trusted-ca-file=/etc/etcd/ca.pem \\
--peer-client-cert-auth \\
--client-cert-auth \\
--initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\
--listen-peer-urls https://${INTERNAL_IP}:2380 \\
--listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\
--advertise-client-urls https://${INTERNAL_IP}:2379 \\ 
--initial-cluster-token etcd-cluster-0 \\

# enable multiple etcd nodes know each other parameters 
--initial-cluster controller-0=https://${CONTROLLER0_IP}:2380,controller-1=https://${CONTROLLER1_IP}:2380 \\
--initial-cluster-state new \\
--data-dir=/var/lib/etcd 
```

