# Practice Test View Certificate Details

## Task-1

Identify the certificate file used for the `kube-api server`.

#### Solutions

- K8S API-Server's config yaml file is located in `/etc/kubernetes/manifests/kube-apiserver.yaml`.
- Kube-Api Server's TLS certificate key word is `--tls-cert-file`

#### Shell Commands

```shell
controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-apiserver.yaml  | grep tls | grep cert
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
```

#### Final Answer

```shell
/etc/kubernetes/pki/apiserver.crt
```

## Task-2

#### Solutions

Identify the Certificate file used to authenticate `kube-apiserver` as a client to `ETCD` Server.

_this task asks us to find kube api server's certificate file as a client send request to ETCD(as server side)_

Since the Kubernetes Cluster's Kube-Api Server's config file is located in
`/etc/kubernetes/manifests/kube-apiserver.yaml`, so we can filter the etcd-certfile this key word from this config file.

#### Shell Commands

```shell

controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep etcd | grep cert
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt

```

#### Final Answer

```shell
/etc/kubernetes/pki/apiserver-etcd-client.crt
```

## Task-3

Identify the key used to authenticate `kubeapi-server` to the `kubectl` server.

#### Solutions:

From the description of the question _KUBE-API server is the client and the kubectl is the server_, and we also know
that the Kubernetes API Server's config file is located under the `/etc/kubernetes/mainfests/kube-apiserver.yaml`.

#### Shell Commands

```shell
## well this is the crt file which means it is a certificate, what we need is private key 

controlplane ~ ➜   cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep cert | grep kubelet 
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
 
 
## we need to use .key and the kubectl to grep the final answer 
controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep kubelet | grep .key 
    - --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key

```

### Final Answer

```shell
# so the answer should be the .key as suffix 
/etc/kubernetes/pki/apiserver-kubelet-client.key
```

## Task-4

Identify the ETCD Server Certificate used to host ETCD server.

#### Solutions

Check `etcd.yaml` this file under the same path as kube-apiserver.

- From the question's description it is the certificate file so we need to filter `crt` and also `server`.

#### Shell Commands

```shell
controlplane ~ ✖ cat /etc/kubernetes/manifests/etcd.yaml | grep crt | grep server 
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
```

#### Final Answer

```shell
/etc/kubernetes/pki/etcd/server.crt
```

## Task 5

Identify the ETCD Server CA Root Certificate used to serve ETCD Server.
_ETCD can have its own CA. So this may be a different CA certificate than the one used by kube-api server._

#### Solutions

From the question's description.

- Server CA Root -- this should certificate file like `ca.crt`
- We also know the `etcd.yaml`'s location is `/etc/kubernetes/`.

#### Shell Command

```shell
controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml | grep ca.crt
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
```

#### Final Answer

```shell
/etc/kubernetes/pki/etcd/ca.crt
```

## Task 6

What is the Common Name (CN) configured on the Kube API Server Certificate?
_OpenSSL Syntax: openssl x509 -in file-path.crt -text -noout_

#### Solutions

- First, we need to find the Kube-API Server's certificate file `kubeapi.crt`
- Then, we need to use the openssl command to decode the certificate file.
- Then, pick the certificate file as the final answer.

#### Shell Commands

```shell
controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/apiserver.crt --text -noout | grep CN 
        Issuer: CN = kubernetes
        Subject: CN = kube-apiserver
        
```

- Issuer: CN -- The CA that signed the certificate (e.g., kubernetes CA)
- Subject CN -- The entity the certificate is issued for (in this case, the Kube API Server itself)

##### Explanations

- Issuer CN -> The CA that signed the certificate (i.e., kubernetes CA), the government issuing the passport.
- Subject CN -> The entity the certificate is issued for (in this case, the Kube API Server itself), the person the
  passport is issued to.
  So, to determine the Common Name(CN) of the Kube API Server, we always look at the **Subject CN**, not the issuer CN.

#### Final Answer

```shell
kube-apiserver
```

## Task 7

What is the name of the CA who issued the Kube API Server Certificate?

#### Solutions

- First, we need to find the kube-api server as a server's .crt file's content, and it can be found in the config file
  of `/etc/kubernetes/manifest/kube-apiserver.yaml`.
- Then, use the `openssl -x509` to decode the .crt file
- Then, find the Issuer's CN -- this is the final answer.

#### Shell Commands
```shell
controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep .crt | grep apiserver
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt

controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/apiserver.crt --text -noout | grep CN 
        Issuer: CN = kubernetes
        Subject: CN = kube-apiserver    
```

#### Final Answer 
```shell
      Issuer: CN = kubernetes
```

## Task 8
Which of the below alternate names is not configured on the Kube API Server Certificate?

#### Solutions
```shell

controlplane ~ ➜  openssl x509  -in /etc/kubernetes/pki/apiserver.crt  -text -noout | grep Name -A8
            X509v3 Subject Alternative Name: 
                DNS:controlplane, DNS:kubernetes, DNS:kubernetes.default, DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP Address:172.20.0.1, IP Address:192.168.117.19
    Signature Algorithm: sha256WithRSAEncryption
    Signature Value:
        48:2f:4f:87:1d:b0:fb:04:ce:08:78:74:4b:d6:2b:15:6e:50:
        e3:96:19:f8:e4:d7:cc:db:91:91:d4:0b:d6:db:3e:68:c3:04:
        1a:27:a1:77:87:42:fb:d9:6b:10:36:46:02:93:60:cb:6f:28:
        6f:fb:04:5e:5a:a2:7e:91:0a:50:16:d0:04:fd:4e:e5:ae:b7:
        a8:57:3e:f1:6b:2c:2b:a5:cc:94:64:b8:70:6d:33:0c:33:b3:
```

#### Final Answer

```shell
kube-master is not configured in the alternative name 
```

## Task 9

What is the Common Name (CN) configured on the ETCD Server certificate

#### Solution

```shell
controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml  | grep crt 
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt

controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/etcd/server.crt -text -noout | grep CN 
        Issuer: CN = etcd-ca
        Subject: CN = controlplane
```

#### Final Answer

```shell
controlplane
```

## Task 10

How long, from the issued date, is the Kube-API Server Certificate valid for ?
_File: /etc/kubernetes/pki/apiserver.crt_

#### Solution

```shell
controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 1432039800914772394 (0x13dfa09c95bf01aa)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Mar 23 00:58:34 2025 GMT
            Not After : Mar 23 01:03:34 2026 GMT
```

#### Final Answer

```shell
1 year 
```

## Task 11

How long, from the issued date, is the Root CA Certificate valid for?
_File: /etc/kubernetes/pki/ca.crt_

#### Solutions:

```shell

controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/ca.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 4059416468615011341 (0x3855f1c53f2b1c0d)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Mar 23 00:58:34 2025 GMT
            Not After : Mar 21 01:03:34 2035 GMT
```

#### Final Answer

```shell
10 years
```

## Task 12

Kubectl suddenly stops responding to your commands. Check it out! Someone recently modified the
`/etc/kubernetes/manifests/etcd.yaml` file.

_you are asked to investigate and fix the issue. once you fix the issue wait for sometime for kubectl to respond. Check
the logs of ETCD container._

#### Solutions

- check etcd config file first

```shell
vim /etc/kubernetes/manifest/etcd.yaml 

apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.168.117.19:2379
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://192.168.117.19:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server-certificate.crt. # <--- something error here modify it to server.crt instead 
```

## Task 13

The kube-api server stopped again! Check it out. Inspect the kube-api server logs and identify the root cause and fix
the issue.

Run `crictl ps -a` command to identify the kube-api server container. Run `crictl logs container-id` command to view the
logs.

#### Solutions

```shell
controlplane ~ ✖ crictl ps -a | grep apiserver
27fa85a859701       c2e17b8d0f4a3       41 seconds ago      Exited              kube-apiserver            2                   5da37e380ff27       kube-apiserver-controlplane            kube-system

controlplane ~ ➜  crictl logs 27fa85a859701
W0323 01:41:33.298423       1 registry.go:256] calling componentGlobalsRegistry.AddFlags more than once, the registry will be set by the latest flags
I0323 01:41:33.298806       1 options.go:238] external host was not specified, using 192.168.117.19
I0323 01:41:33.300402       1 server.go:143] Version: v1.32.0
I0323 01:41:33.300435       1 server.go:145] "Golang settings" GOGC="" GOMAXPROCS="" GOTRACEBACK=""
I0323 01:41:33.546185       1 shared_informer.go:313] Waiting for caches to sync for node_authorizer
W0323 01:41:33.548035       1 logging.go:55] [core] [Channel #1 SubChannel #3]grpc: addrConn.createTransport failed to connect to {Addr: "127.0.0.1:2379", ServerName: "127.0.0.1:2379", }. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
W0323 01:41:33.548333       1 logging.go:55] [core] [Channel #2 SubChannel #4]grpc: addrConn.createTransport failed to connect to {Addr: "127.0.0.1:2379", ServerName: "127.0.0.1:2379", }. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
I0323 01:41:33.554572       1 shared_informer.go:313] Waiting for caches to sync for *generic.policySource[*k8s.io/api/admissionregistration/v1.ValidatingAdmissionPolicy,*k8s.io/api/admissionregistration/v1.ValidatingAdmissionPolicyBinding,k8s.io/apiserver/pkg/admission/plugin/policy/validating.Validator]
I0323 01:41:33.562095       1 plugins.go:157] Loaded 13 mutating admission controller(s) successfully in the following order: NamespaceLifecycle,LimitRanger,ServiceAccount,NodeRestriction,TaintNodesByCondition,Priority,DefaultTolerationSeconds,DefaultStorageClass,StorageObjectInUseProtection,RuntimeClass,DefaultIngressClass,MutatingAdmissionPolicy,MutatingAdmissionWebhook.
I0323 01:41:33.562123       1 plugins.go:160] Loaded 13 validating admission controller(s) successfully in the following order: LimitRanger,ServiceAccount,PodSecurity,Priority,PersistentVolumeClaimResize,RuntimeClass,CertificateApproval,CertificateSigning,ClusterTrustBundleAttest,CertificateSubjectRestriction,ValidatingAdmissionPolicy,ValidatingAdmissionWebhook,ResourceQuota.
I0323 01:41:33.562318 
```

According to the logs, we know the ca for ectd for the kube-apiserver is configured incorrectly.
Modify it to the correct one, then the kube-apiserver works as expect. 

```yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.168.117.19:6443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
    - command:
        - kube-apiserver
        - --advertise-address=192.168.117.19
        - --allow-privileged=true
        - --authorization-mode=Node,RBAC
        - --client-ca-file=/etc/kubernetes/pki/ca.crt
        - --enable-admission-plugins=NodeRestriction
        - --enable-bootstrap-token-auth=true
        - --etcd-cafile=/etc/kubernetes/pki/ca.crt # error one, this ca.crt is k8s <-> kube-apiserver
        - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt # and this one should be the correct one   
```
