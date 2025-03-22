# TLS Certificates

## Questions We need to figure out

- What are TLS Certificates?
- How does Kubernetes use Certificates?
- How to generate them?
- How to configure them ?
- How to view them?
- How to troubleshoot issues related to Certificates?

## TLS in Kubernetes

### Certificate Authority (CA)

### Root Certificates

The **CA certificates** is the root of trust in Kubernetes. It is used to sign and verify other certificates.

#### Certificate Files in Root Certificates

- **ca.crt**(CA Certificates): The public certificate used to verify signed certificates.
- **ca.key**(CA Private Key): The private key used to sign other certificates.

#### Root Certificates Responsibilities

- Used to sign all Kubernetes certificates (client, server, etc).
- Ensures secure communication by verifying authenticity.
- Required by Kubernetes API Server, and kubelets.

### Server Certificates

These certificates secure communication **between Kubernetes components** and ensure encrypted connections.

#### Certificate Files:

- **server.crt**(Server Certificate): Used to verify the identity of the API server.
- **server.key**(Server Private Key): Private key associated with the server certificate.
- **ca.crt**(CA Certificate): Required to verify the certificate.

#### Responsibilities:

- Ensure API server and etcd expose secure TLS endpoints.
- Used when **kubectl** or kubeletes communicate with the API server.
- Must be signed by a trusted CA (i.e., ca.crt).

### Client Certificates

These certificates are used by **kubectl**, **kubelet**, and **controllers** to authenticate against the Kubernetes API
server.

#### Certificate Files:

- **client.crt**(Client Certificate): Identity of the client (e.g., user or kubelet)
- **client.key**(Client Private Key): Private Key to prove client ownership.
- **ca.crt**(CA Certificate): Used to verify the API server's identity.

#### Responsibilities:

- Required when users authenticate via `kubectl` with certificate-based authentication.
- Used by internal Kubernetes components (e.g., scheduler, controller-manager) to authenticate with the API server.

### Kubernetes Component Certificates

Kubernetes control plane components use certificates to **secure inter-component communication**.

#### Certificate Files:

- **apiserver.crt** & **apiserver.key** - Used by API server.
- **etcd.crt** & **etcd.key** - Used for securing etcd communication.
- **front-proxy-ca.crt** & **front-proxy-ca.key** -Used for front-proxy authentication.
- **sa.key** & **sa.pub** - Used for signing service account tokens.

#### Responsibilities

- Protects API server and etcd communication.
- Ensures Kubernetes scheduler, controller-manager, and kubelet communicate securely.

### TLS Certificates for Ingress and Services.

Ingress controllers and services used **TLS certificates** to encrypt communication for external clients.

#### Certificate Files:

- `tls.crt`(TLS certificate for Services)
- `tls.key`(TLS Private Key for Services)
- `ca.crt` (CA Certificate, if using a custom CA)

#### Responsibilities

- Used to enable HTTPs for Kubernetes Ingress controllers.
- Ensure encrypted communication for applications inside Kubernetes.

### kubeconfig and Certificate-based Authentication

When using **kubectl** to interact with a Kubernetes cluster, the configuration must include the correct certificate
files.

#### Files Needed for Authentication

- **Client Certificate** (client.crt) - Identifies the user.
- **Client Key** (client.key) - Private key for authentication.
- **CA Certificate**(ca.crt) - Verifies the API server's identity.
- **Kubeconfig File(~/.kube/config)** - Stores the certificate paths and cluster details.

### Summary Table

#### Root Certificate (CA)

**Required Files**: ca.crt, ca.key
**Purpose**: Signs and verifies other certificates

#### Server Certificate

**Purpose**: Secures API server, & etcd.
**Required Files**: server.crt, server.key, ca.crt

#### Client Certificate

**Purpose**: Authenticates users and components
**Required Files**: client.crt, client.key, ca.crt

#### Kubernetes Components

**Purpose**: Secures Kubernetes internal communication.
**Required Files**: apiserver.crt, etcd.crt, front-proxy-ca.crt, etc.

#### TLS for Ingress & Services

- **Purpose**: Enables HTTPS for services.
- **Required Files**: tls.crt, tls.key, ca.crt

#### kubectl Authentication

- **Purpose**: Allows users to interact with the cluster.
- **Required Files**: client.crt, client.key, ca.crt, and kubeconfig. 