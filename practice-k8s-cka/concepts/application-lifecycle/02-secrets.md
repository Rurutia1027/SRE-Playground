# Secrets

## Secrets in Pods

When we use secrets we first create the secret declaration files, and then refer the secrets defined in the secret files
like this.

## Secrets Declaration

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
data:
  DB_Host: db_host
  DB_User: db_user
  DB_Password: db_password
```

## Pod Definition
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 8080
      envFrom:
        - secretRef:
            name: app-secret
```

## Note on Secrets

- Secrets are not Encrypted. Only encoded.
- Do not check-in Secret objects to SCM along with code. 
- 