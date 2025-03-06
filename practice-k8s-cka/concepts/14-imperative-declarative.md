# IaC: Imperative vs. Declarative

Kubernetes allows you to manage resources using **imperative** and **declarative** approaches. The key difference lies
in how you apply configurations and interact with the cluster.

## Imperative

### Definition

- You directly tell Kubernetes **how** to create, update, or delete resources using commands.
- Actions are performed immediately but are not stored for future references.

### Examples

-- Create Objects -- 
- `kubectl run --image=nginx nginx`
- `kubectl create deployment --image=nginx nginx`
- `kubectl expose deployment nginx --port 80` 

-- Update Objects --

- `kubectl edit deployment nginx`
- `kubectl scale deployment nginx --replicas=5`
- `kubectl set image deployment nginx nginx=nginx:1.18`

- `kubectl create -f nginx.yml`
- `kubectl replace -f nginx.yml`
- `kubect delete -f nignx.yml`

## Declarative

### Definition

- You define the **desired state** in YAML files and apply them using `kubectl apply` command to execute.
- Kubernetes ensures the cluster matches the desired state and handles updates automatically.

### Example

- `kubectl apply -f ./nginx.yml`

