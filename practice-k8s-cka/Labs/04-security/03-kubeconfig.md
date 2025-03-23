# KubeConfig Practice Test

## Task1

Where is the default kubeconfig file located in the current environment?
Find the current home directory by looking at the HOME environment variable.

### Solutions

```shell
controlplane ~ ✖ cd $HOME

controlplane ~ ➜  ls
CKA  my-kube-config  sample.yaml

controlplane ~ ✖ ls -a 
.   .bash_profile  .cache  .config  my-kube-config  sample.yaml  .terminal_logs  .vimrc
..  .bashrc        CKA     .kube    .profile        .ssh         .vim            .wget-hsts

controlplane ~ ➜  cd .kube/

controlplane ~/.kube ➜  ls
cache  config

controlplane ~/.kube ➜  pwd
/root/.kube
```

### Final Answer

```shell
/root/.kube/config
```

## Task2

How many clusters are defined in the default kubeconfig file ?

### Solutions

```shell
controlplane ~/.kube ➜  cat config 
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJVHZQem8xUUNMTGd3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBek1qTXdOakl6TXpWYUZ3MHpOVEF6TWpFd05qSTRNelZhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUNwTWN1K29qUVlnTHBFMFRaS1BpRGlmOWE0M0VlSzg3eGxoTUVnSkRCZW9aZEJzYm8rYlJYZGNlTTEKaklGMEhCQWxGUlJ1QTdaUVNIY005NFRLS2FPN2grWldlVUZCcnVDRGZFbHczMjZIeWhlUjhMYUd3MnZsMUJiTwpLSGNjQW9qdnFmZHhwZFNoYmpXaHRyM1UvWUNaa3lUT1Mvcm5EV0Fzd2Z5U3doTE4ydktMQUhhK0kvRHpqdEU3ClhRN29TZ0VIcysrYm1oNHhLWWxNSUlqRHRiOEphRUx5Rytlc05laFUrYzJaaHNXamFpb0hpOC9Zc2lqdEFManAKd3prbHJNZVErR2MxQlRVekZxdi9lTm8rRmFBeTVXZVB6eWsrSjdodFppZTJ2SUU2MVBKUTFlbXN5N2p1ZEs2OQpXR1BGWDFzenpBRFQyd1ZkWGVUYzFYa09xZm9SQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSTjRJTUdhdTBPcXdVN1BqRndYTm04U29ucVJEQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQVZXTE9hTjNXcApndHR1ZFNkaXU3MWNNWmt6K1FleUpQYTQ4c0NEWE1VUDVIRmNKTTZUcDBqRHZDU09ML3A0eWtCZjlkNzZxemF3CnlsQkExNlFCMEFBbVA1aVpxbGN1N1AxVk5pSWxjZDVzNTROcXJZdnRONnRPNlpVREhjOG44L0dmV0RHVTEzQlAKSGZNM3FUeWlqdEJzZGQ1QnJ4Wm9oazVuTXRITmNBTXV3RUc4U3hVZXRhNndxbGduaGJvVEdibVZLK0xWQmJ6SgpqSlF4NitBV2RxdCtiWDRCQzZPLzNTWXlOT05lSS9taU5jSy9OQWZMTG9nb2RYbjYyODVYRTlJUFNrUnRXbW9rCnRIek0xYUR4SGY2ZVgzYllBNDdhVGx5eTJId3VJTlo2emVDUHhUS010RlFnV3ErdUtlT1dDTENaNThXZnEwd3oKWEtERHgxSHRmT2NzCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
```

### Final Answer

```shell
According to the above config file, under the clusters there is only one cluster defined. 
```

## Task3

How many Users are defined in the default kbueconfig file ?

### Solutions

```shell
cat config 
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLVENDQWhHZ0F3SUJBZ0lJY3BJUFhDblhkRVF3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBek1qTXdOakl6TXpWYUZ3MHlOakF6TWpNd05qSTRNelZhTUR3eApIekFkQmdOVkJBb1RGbXQxWW1WaFpHMDZZMngxYzNSbGNpMWhaRzFwYm5NeEdUQVhCZ05WQkFNVEVHdDFZbVZ5CmJtVjBaWE10WVdSdGFXNHdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDNHNwR00KNm1IZ3NSUnJCcHp1T2w3Q0h5NzhOaW8yeXEzKzU3MzdBUkllTlBlamROU2V3YTBUamgrLzJDZEFUUzFDOTA3ZwowUEdZUTRNWlQzeWY2VjFxUDRvbFpjb0hpbUcrOFJ5ZVI0YnBqVkFGKzR6b1RFY0c2RHhHZnBHTjFSWVlNN0xOCk5TWUJqdTRkUjR4clNRMExadkQ1eHZ1emM4MFd0WWlDQjlNVFdCWU9odlYyWGoySXBpUjlIOHNORitYWXFyeHIKVFFUOHF4VUl0dHJ3N0VlVEtnbmt4WGhrSEUyK2Z0azJrWStWeElTMEkyZUZYcXIxeEdCNm5vRTJxMWdESHZZcwppL2Y5ekxTZDNyNnV0RkZpM3dRZ1h2VjYzMmFzcDRxWXNsVGFBMm5rRG94VHZPdVJuM1ZoRmE2YWU0NmVQcEVwCjcxSHgzNWRON1BLNDlGM3pBZ01CQUFHalZqQlVNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUsKQmdnckJnRUZCUWNEQWpBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkUzZ2d3WnE3UTZyQlRzKwpNWEJjMmJ4S2llcEVNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUFibTBFVFJoZ2RrWGRoVHlCR1pTczJEczYyCjhPby9wR0loQnNUT3Z0eGplbkZ4UVVrM2pzWGtrak1WWGVGRDBVR1ZIWVczRjFZQWhxSFhOVFB0VnMrdTJsN2EKOUMvRURBNERDcmpMcDhDWGNUb0JOWnNEN0pTdloydm4zWWNoYjBVUzRlb0J5ZjVoV3YwWjJEUFVzRlladTBNWApxSjVzSEl2S2o1UFBIczJjLyttM1ZYK1c0T1c3WVE2d1BkOUUrVjFNaEIwb0tCTm5adktXbkVwekJ3WG4zejdzCjBGWXowcGEwMUxnZit3eEpmN3hxTWJpZWMxdzVVb1FrUlVGeGVMR3RPQVZ4dHJYTEtDT3pwdGs1MzRJR2EvM3YKUmJzYSt6cjlFZm43Vmw0UStvaUQ1WG13QUNnb2RXczZNcGtGSVVWaVh5d2ZiV0s0dzVMcVZua0ZDMmwxCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    client-key-data: L
```

- According to the config file, there is only one user defined under `users`.

### Final Answer

```shell
1
```

## Task 4

How many contexts are defined in the default kubeconfig file?

```shell
cat config 
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
```

- According to the command there is only one context under the contexts.

### Final Answer

```shell
1
```

## Task 5

What is the user configured in the current context ?

### Solutions

```shell
controlplane ~/.kube ✖ cat config | grep current | grep context 
current-context: kubernetes-admin@kubernetes
```

- according to the info, current-context is `kubernetes-admin@kubernetes`

### Final Answer

```shell
kubernetes-admin
```

## Task 6

What is the name of the cluster configured in the default kubeconfig file ?

### Solutions

```shell
controlplane ~/.kube ✖ cat config | grep cluster 
clusters:
- cluster:
    cluster: kubernetes
```

### Final Answer

```shell
kubernetes
```

## Task 7

A new kubeconfig file named `my-kube-config` is created. It is placed in the `/root` directory.
How many clusters are defined in that kbueconfig file?

### Solutions

```shell
controlplane ~ ➜  cat my-kube-config 
apiVersion: v1
kind: Config

clusters:
- name: production
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: development
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: kubernetes-on-aws
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: test-cluster-1
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443
```

### Final Answer

```shell
4
```

## Task 8

How many contexts are configured in the my-kube-config file?

### Solutions

```shell
contexts:
- name: test-user@development
  context:
    cluster: development
    user: test-user

- name: aws-user@kubernetes-on-aws
  context:
    cluster: kubernetes-on-aws
    user: aws-user

- name: test-user@production
  context:
    cluster: production
    user: test-user

- name: research
  context:
    cluster: test-cluster-1
    user: dev-user
```

### Final Answer

```shell
4
```

## Task 9

What user is configured in the `research` context ?

### Solutions

- research context's metadata info

```shell
- name: research
  context:
    cluster: test-cluster-1
    user: dev-user
```

### Final Answer

```shell
dev-user 
```

## Task 10

What is the name of the client-certificate file configured for the aws-user.

### Solutions

- according to the my-kube-config

```shell 
- name: aws-user
  user:
    client-certificate: /etc/kubernetes/pki/users/aws-user/aws-user.crt
    client-key: /etc/kubernetes/pki/users/aws-user/aws-user.key
```

### Final Answer

```shell
aws-user.crt
```

## Task 11

What is the current context set to in the `my-kube-config` file?

### Solutions

```shell
controlplane ~ ➜  cat my-kube-config | grep current | grep context 
current-context: test-user@development
```

### Final Answer

```shell
test-user@development
```

## Task 12

I would like to use the `dev-user` to access `test-cluster-1`. Set the current context to the right one so I can do
that. Once the right context is identified, use the `kubectl config use-context` command.

### Solutions

- First, we check the my-kube-config first, and filter the user 'dev-user''s context name is `research`.
- Second, we execute the command to the context name to 'research'.
- Third, we use command `kubectl config -- kubeconfig=/root/my-kube-config current-context` to check the current
  information of the context.

```shell
controlplane ~ ➜  kubectl config --kubeconfig=/root/my-kube-config use-context research
Switched to context "research".

controlplane ~ ➜  kubectl config --kubeconfig=/root/my-kube-config current-context 
research
```

## Task13

We don't want to specify the **kubeconfig file** option on each `kubectl` command.

Set the **my-kube-config** file as the default kubeconfig file and make it persistent across all sessions without
overwriting the existing ~/.kube/config.
Ensure any configuration changes persist across reboots and new shell sessions.

Note: Don't forget to source the configuration file to take effect in the existing session.

### Solutions

- First, open our `~/.bashrc`

```shell
vim ~/.bashrc 
```

- Second, add the following line to export the variable.

```shell
export KUBECONFIG=/root/my-kube-config
```

- Third, Apply the changes, via source the `.bashrc` this file.

```shell
source ~/.bashrc 
```

## Task 14

With the current-context set to `research`, we are trying to access the cluster. However, something seems to be wrong.
Identify and fix the issue.

Try running the `kubectl get pods` command and look for the error. All users certificates are stored at
`/etc/kubenetes/pki/users`. 




