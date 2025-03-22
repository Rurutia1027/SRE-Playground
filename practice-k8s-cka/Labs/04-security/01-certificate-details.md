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
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text
```


