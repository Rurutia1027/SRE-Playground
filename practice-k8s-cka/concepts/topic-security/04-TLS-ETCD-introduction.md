# TLS & ETCD Communication && Certification

## Communication with an External etcd Server

If my etcd server is running externally(outside the Kubernetes cluster), you need to provide **client certificates** for
authentication.

## Required Certificate Files

- ca.crt: verifies the external etcd server's certificate.
- client.crt: identifies the client making the request.
- client.key: private key for authentication

## Command to Connect to an External etcd Server

```shell
ETCDCTL_API=3 etcdctl --endpoints=https://etcd.external.com:2379 \
 --cacert=ca.crt --cert=client.crt --key=client.key \
 endpoint status
```

## Communication with an etcd Server inside Kubernetes (Port-based Access)

WHen communicating with etcd inside a Kubernetes cluster, different authentication mechanisms are used, depending on
whether it's API-based or direct port-based access.

### Case-1: Communicating via API Server (Recommended)

Instead of talking directly to etcd, the Kubernetes API server proxies etcd requests.

#### Required Certificate Files

- ca.crt: Ensures secure communication with the Kubernetes API server.
- admin.crt: Identifies the Kubernetes admin making the request.
- admin.key: Private key for admin authentication.

#### Command to Get Data via Kubernetes API (Recommended Way)

```shell 
kubectl exec -it etcd-control-plane -n kube-system -- etcdctl \
    --cacert=/etcd/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    
```

## Communicating with an etcd Server inside Kubernetes (Port-based Access)

When **communicating with etcd inside a Kubernetes cluster**, different authentication mechanisms are used, depending on
whether it's API-based or direct port-based access.

### Case-1: Communicating via API Server (Recommended)

Instead of talking directly to etcd, the Kubernetes API server proxies etcd requests.

### Required Certificate Files:

- ca.crt: Ensures secure communication with the Kubernetes API server.
- admin.crt: Identifies the Kubernetes admin making the request.
- admin.key: Private key for admin authentication.

```shell
kubectl exec -it etcd-control-plane -n kube-system -- etcdctl \
   --cacert=/etc/kbuernetes/pki/etcd/ca.crt \
   --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt \
   --key=/etc/kubernetes/pki/apiserver-etcd-client.key \
   get /
```

This method is preferred because it follows Kubernetes security policies.

### Case-2: Direct Port-Based etcd Access (Node-to-Node Communication)

If you need to talk directly toan etcd node inside Kubernetes, you must provide different certificates.

#### Required Certificate Files:

- etcd-ca.crt: Ensures trusted communication.
- etcd-server.crt: Identifies the etcd server in the cluster.
- etcd-server.key: Private key fo the etcd server.

```shell
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get /
```

### Summary of Certificate Responsibilities

- ca.crt: Validates etcd server identity, and it is used for all clients.
- client.crt: This identifies an external client, and it is used for external users.
- client.key: This is private key for external authentication, and it is used for external users.
- admin.crt: Identifies a Kubernetes admin, and it is used for kubernetes administrators.
- admin.key: Private key for admin authentication, and it is used for kubernetes administrators.
- etcd-ca.crt: Validates communication between etcd nodes, and it is used for etcd nodes.
- etcd-server.crt: Validates communication between etcd nodes, and it is used for etcd servers.
- etcd-server.key: Private key for the etcd server, and it is used for etcd server.

## Final Notes

- Use API-based access (kubectl exec method) whenever possible for security.
- External clients should use client.crt and client.key to authenticate.
- Internal etcd servers use etcd-server.crt and etcd-server.key for communication.
- Never expose etcd directly to the internet without authentication and TLS.

## Analogy that Helps me figure out ca.crt, client.crt and client.key

- ca.crt = The government that issues passport.
- client.crt = Your passport, providing who you are, here we need to know is: passport != public key, passport contains
  the public key based on the CA.
- client.key = Your fingerprint, proving the passport belongs to you.

- Without ca.crt, you can't check if a passport is real.
- Without client.crt, you have no identity.
- Without client.key, you can't prove you are the passport owner.

- The client uses ca.crt to verify the server.
- The server uses ca.crt to verify the client.
- It ensures mutual trust between client and server. 

## Extra Tips

- Passport (admin.crt) != Public Key
- But the passport contains the public key inside.
- It is signed by the CA to prove its authenticity. 