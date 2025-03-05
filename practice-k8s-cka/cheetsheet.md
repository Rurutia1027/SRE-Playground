# Certification Tip!

Sometimes use CLI directly write a YAML file is difficult. We can use the following ommands to help us to generate a standard K8S YAML file for us. Then, based on the generated standard YAML file we can appending other configuration options and modify configuration details. 

### Create an NGINX Pod 
```shell 
kubectl run nginx --image=nginx 
```

### Generate POD Manifest YAML file (-o yam). Don't create it (--dry-run)

### Create a deployment 
```shell 
kubectl run nginx --image=nginx --dry-run=client -o yaml 
```


## Generate Deployment YAML file (-o yaml). Don't create it (--dry-run)`
```shell 
kubectl create deployment --image=nginx nginx 
```

## Generate Deployment YAML file (-o yaml).Don't create it (--dry-run) and save it to a file. 
```shell 
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml 
```

## Make necessary changes to the file
```shell 
kubectl create -f nginx-deployment.yaml 
```

## In k8s version 1.19+, we can specify the --replicas option to create a deployment with 4 replicas. 
```shell 
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml 
```



