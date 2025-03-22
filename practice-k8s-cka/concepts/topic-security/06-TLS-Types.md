# TLS in Kubernetes - Certificates Creation

## Steps to Create Certificates (Root CA) in Kubernetes

### Step-1: Generate Keys

- ca.key

```shell
openssl genrsa -out ca.key 2048

# this will generate a ca.key file  
```

### Step-2: Certificate Signing Request

- ca.csr

```shell
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out.ca 
```

### Step-3: Sign Certificates

- ca.crt

```shell
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt 
```

## Steps to Create Admin User Certificate

### Step-1: Generate Keys

- admin.key

```shell
openssl genrsa -out admin.key 2048 
```

### Step-2: Certificate Signing Request

- admin.csr

```shell
openssl req -new -key admin.key -subj \
  "/CN=kube-admin" -out admin.csr
```

### Step-3: Sign Certificates

- admin.crt

```shell
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt 
```