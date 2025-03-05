# Deployment

A **Deployment** is a Kubernetes resource that manages and updates **Pods** in a controlled way. It ensures your applicaiton runs as expected and allows rolling updates, rollbacks, and scaling. 

## Responsiblity 
- **Pod Management** Creates and maintains the desired number of pod replicas. 
- **Rolling Updates**: Updates pods gradually to prevent downtime. 
- **Rollback**: Revert to a previous version is something goes wrong. 
- **Self-Healing**: Replaces failed pods automatically.
- **Scaling**: Increasing or decreases pod count based on demand. 
