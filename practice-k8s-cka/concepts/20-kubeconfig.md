# kubeconfig

## Why we use KubeConfig File

When Kubernetes is configured and enabled all it's TLS certificates, every time we use kubectl command we need to
provide several certificate files, private key files and so on. To simple the kubectl command usage and reduce
parameters of certificate file paths, we write all the certificate files parameters to KubeConig file.
Then, everytime we execute kubectl command only referring to the kubeconfig file is ok.

### Commands without providing kube-config file 
- Case-1: request /api/v1/pods endpoint via curl command 
```shell
curl https://my-kube-playground:6443/api/v1/pods \
--key admin.key 
--cert admin.crt 
--cacert ca.crt 
```

- Case-2: get pods via kubectl command 
```shell
kbuectl get pods 
--server my-kube-playground:6443 
--client-key admin.key 
--client-certificate admin.crt 
--certificate-authority ca.crt 
```

### Commands After we wrote certificate metadata to KubeConfig File
- $HOME/.kube/config
```shell
# KubeConfig File

--server my-kube-playground:6443
--client-key admin.key 
--client-certificate admin.crt
--certificate-authority ca.crt 
```

- Shell Commands 
```shell
kubectl get pods --kubeconfig config 
```