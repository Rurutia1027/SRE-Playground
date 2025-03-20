# Understanding Rollout in Kubernetes

In Kubernetes, rollout refers to the process of deploying a new version of an application while ensuring minimal
downtime. It mainly applies to **Deployments**, **DaemonSets**, and **StatefulSets**.

A **rollout** happens when you update a Deployment, such as changing the container image or modifying configurations.
Kubernetes handles the transition smoothly by controlling how new Pods replace old ones.

## Key Concepts in Kubernetes Rollouts

### Rolling Update (Default Strategy)

- Replaces old Pods gradually with new ones.
- Ensures minimal downtime and maintains application availability.
- Controlled by `maxUnavailable` and `maxSurge` parameters.

### Recreate Strategy

- Delete all existing Pods before creating new ones.
- Causes downtime but ensures a clean deployment.

### Rollout History & Rollback

- Kubernetes keeps track of previous revisions.
- Use `kubectl rollout undo deployment <deployment-name>` to revert to a previous version.

### Checking Rollout Status

- `kubectl rollout status deployment <deployment-name>` -> Show progress.
- `kubectl rollout history deployment <deployment-name>` -> List revision history.