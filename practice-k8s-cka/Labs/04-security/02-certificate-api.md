# Certificate API Practice Tests

## Task 1

A new member `aksha` joined our team. He requires access to our cluster. The Certificate Signing Request is at the
`/root/` location. You need to inspect it.

### Solutions

```shell

controlplane ~ ➜  ls
akshay.csr  akshay.key
```

## Task2

Create a **CertificateSigningRequest** object with the name `akshay` with the contents of `akshay.csr` file.

As of kubernetes 1.19, the API to use for CSR is `certificates.k8s.io/v1`.

Please note that an additional called `signedName` should also be added when creating CSR. For client authentication to
the API server we will use the built-in signer `kubernetes.io/kube-apiserver-client`.

### Solutions

```shell
controlplane ~ ➜  cat akshay.csr | base64 -w 0 
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQW5oMFNoUEpQVDhaYzU0VVM0MlZFUjVVUWkxNjdybk5ZNkFERTUzMXlhNmt5CjJHS2QvYWRBUVFvSnk3T1ZjSnF6RktrU2hnM2lLWUJqbDhMbE10aVhaVTIvRDNWU2NuMVpSZ1pWWDhrZHg4MmwKRmxLZGxPcXhWanVmM3dmMWpQRmREMitGTHBQcjZWdDg3SGRjcnR0eURvc1dQSXhGM0FJY3M5Mml0T1NVc3B4UwpsajNGNGo3ZG9HSDVNOGViR0pNWGtQVE9BaisvRjNXN2l1MU80anhqaVl4VUZtSHNqcGpSc0FZVkxKMzJoSmJQClFxUFljR2JuRUR1ZkRXbE93cVUwUGk3dHpUd1pCRHFVcUp1TUNwbFl3RlJISDE0Z09KcFNNUjNTWE1sZnc4NmsKVldOU2U3UldlVG9BTWUySVZ6dkRSL0M3NlFFUk9DaTEvdzFFaktyOUF3SURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBRlhoUVBYZFlPMlpmVmllZnZGaTJ5cUtXNWpWUGNCeHVvODNCQVlmSVFZRk9FWjQzVHR2CjYyb1pCeGNiY09HQnY3MGZkSXE4VjQ2dU5UdUpQM2VQcElFbUt2VEg4VnRMWjIwakxFdXRPS1dyY3gwOHliVkgKNlViSHNMR3JhWUdrTFlTcm5QeXJhdktFS1J6U2pvYTNXVVJMaGMwL1RhZ1NYY0QwT1h6MzNVbWpaVm0xdzc1TgpsQTNiLzBia0V3OVZvcmFTenhxdmt6dml0VkhYbEZzdU83R1V6b1JTVHczV3hURy85cmZnTlhVWkd5OTExUlVkCm9kZWhQVkI1WHVjMDZqTzNtRWhsWDlHenBIdk14bHYzbXprWjVBUE8wekEzNXppdXpnbWR6ako3ZzJHTkxRK3AKbm9xY1NUNk1GTk5LVnNYNGhnV0hqcDU0Ty9rZHozRnR3Vnc9Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
controlplane ~ ➜  cat akshay-csr.yaml 
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: akshay
spec:
  groups:
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQW5oMFNoUEpQVDhaYzU0VVM0MlZFUjVVUWkxNjdybk5ZNkFERTUzMXlhNmt5CjJHS2QvYWRBUVFvSnk3T1ZjSnF6RktrU2hnM2lLWUJqbDhMbE10aVhaVTIvRDNWU2NuMVpSZ1pWWDhrZHg4MmwKRmxLZGxPcXhWanVmM3dmMWpQRmREMitGTHBQcjZWdDg3SGRjcnR0eURvc1dQSXhGM0FJY3M5Mml0T1NVc3B4UwpsajNGNGo3ZG9HSDVNOGViR0pNWGtQVE9BaisvRjNXN2l1MU80anhqaVl4VUZtSHNqcGpSc0FZVkxKMzJoSmJQClFxUFljR2JuRUR1ZkRXbE93cVUwUGk3dHpUd1pCRHFVcUp1TUNwbFl3RlJISDE0Z09KcFNNUjNTWE1sZnc4NmsKVldOU2U3UldlVG9BTWUySVZ6dkRSL0M3NlFFUk9DaTEvdzFFaktyOUF3SURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBRlhoUVBYZFlPMlpmVmllZnZGaTJ5cUtXNWpWUGNCeHVvODNCQVlmSVFZRk9FWjQzVHR2CjYyb1pCeGNiY09HQnY3MGZkSXE4VjQ2dU5UdUpQM2VQcElFbUt2VEg4VnRMWjIwakxFdXRPS1dyY3gwOHliVkgKNlViSHNMR3JhWUdrTFlTcm5QeXJhdktFS1J6U2pvYTNXVVJMaGMwL1RhZ1NYY0QwT1h6MzNVbWpaVm0xdzc1TgpsQTNiLzBia0V3OVZvcmFTenhxdmt6dml0VkhYbEZzdU83R1V6b1JTVHczV3hURy85cmZnTlhVWkd5OTExUlVkCm9kZWhQVkI1WHVjMDZqTzNtRWhsWDlHenBIdk14bHYzbXprWjVBUE8wekEzNXppdXpnbWR6ako3ZzJHTkxRK3AKbm9xY1NUNk1GTk5LVnNYNGhnV0hqcDU0Ty9rZHozRnR3Vnc9Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/kube-api-server-client
  usages:
      - client auth 
      

controlplane ~ ➜  kubectl apply -f ./akshay-csr.yaml 
certificatesigningrequest.certificates.k8s.io/akshay created
```

## Task 3

What's the Condition of the newly created Certificate Signing Request object?

### Solutions

```shell
controlplane ~ ✖ kubectl get csr 
NAME     AGE     SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
akshay   9m51s   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Pending

```

### Final Answer

```shell
Pending 
```

## Task 4

Since you are the Kubernetes Cluster Admin, Approve the CSR request.

### Solutions

```shell

controlplane ~ ➜  kubectl certificate approve akshay 
certificatesigningrequest.certificates.k8s.io/akshay approved

controlplane ~ ➜  kubectl get csr 
NAME     AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
akshay   11m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved

```

## Task 5

How many CSR request are available on the cluster ?
_including approved and pending_

### Solutions

```shell

controlplane ~ ➜  kubectl get csr --namespace=all
NAME     AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
akshay   12m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved

```

### Final Answer

```shell
1 
```

## Task 6

During a routine check you realized that there is a new CSR request in place. What's the name of this request ?

### Solutions

```shell
controlplane ~ ➜  kubectl get csr 
NAME          AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
agent-smith   39s   kubernetes.io/kube-apiserver-client    agent-x            <none>              Pending
akshay        13m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved

```

### Final Answer

```shell
NAME: agent-smith
```

## Task 7

Hmmm... You are not aware of a request coming in. What groups is this CSR requesting access to.
Check the details about the request. Preferably in YAML.

### Solutions

```shell
controlplane ~ ➜  kubectl get csr 
NAME          AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
agent-smith   19m   kubernetes.io/kube-apiserver-client    agent-x            <none>              Pending
akshay        32m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved

controlplane ~ ➜  kubectl get csr agent-smith -o yaml 
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  creationTimestamp: "2025-03-23T04:52:41Z"
  name: agent-smith
  resourceVersion: "2871"
  uid: d30ad0db-097e-4e24-aaf4-26b1f70e0868
spec:
  extra:
    authentication.kubernetes.io/credential-id:
    - X509SHA256=ad2f29a515a9936aa63abe81768cd0c8faa05cfdbdb531e8f7ad54db5638f9ce
  groups:
  - system:masters
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1dEQ0NBVUFDQVFBd0V6RVJNQThHQTFVRUF3d0libVYzTFhWelpYSXdnZ0VpTUEwR0NTcUdTSWIzRFFFQgpBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRRE8wV0pXK0RYc0FKU0lyanBObzV2UklCcGxuemcrNnhjOStVVndrS2kwCkxmQzI3dCsxZUVuT041TXVxOTlOZXZtTUVPbnJEVU8vdGh5VnFQMncyWE5JRFJYall5RjQwRmJtRCs1eld5Q0sKeTNCaWhoQjkzTUo3T3FsM1VUdlo4VEVMcXlhRGtuUmwvanYvU3hnWGtvazBBQlVUcFdNeDRCcFNpS2IwVSt0RQpJRjVueEF0dE1Wa0RQUTdOYmVaUkc0M2IrUVdsVkdSL3o2RFdPZkpuYmZlek90YUF5ZEdMVFpGQy93VHB6NTJrCkVjQ1hBd3FDaGpCTGt6MkJIUFI0Sjg5RDZYYjhrMzlwdTZqcHluZ1Y2dVAwdEliT3pwcU52MFkwcWRFWnB3bXcKajJxRUwraFpFV2trRno4MGxOTnR5VDVMeE1xRU5EQ25JZ3dDNEdaaVJHYnJBZ01CQUFHZ0FEQU5CZ2txaGtpRwo5dzBCQVFzRkFBT0NBUUVBUzlpUzZDMXV4VHVmNUJCWVNVN1FGUUhVemFsTnhBZFlzYU9SUlFOd0had0hxR2k0CmhPSzRhMnp5TnlpNDRPT2lqeWFENnRVVzhEU3hrcjhCTEs4S2czc3JSRXRKcWw1ckxaeTlMUlZyc0pnaEQ0Z1kKUDlOTCthRFJTeFJPVlNxQmFCMm5XZVlwTTVjSjVURjUzbGVzTlNOTUxRMisrUk1uakRRSjdqdVBFaWM4L2RoawpXcjJFVU02VWF3enlrcmRISW13VHYybWxNWTBSK0ROdFYxWWllKzBIOS9ZRWx0K0ZTR2poNUw1WVV2STFEcWl5CjRsM0UveTNxTDcxV2ZBY3VIM09zVnBVVW5RSVNNZFFzMHFXQ3NiRTU2Q0M1RGhQR1pJcFVibktVcEF3a2ErOEUKdndRMDdqRytocGtueG11RkFlWHhnVXdvZEFMYUo3anUvVERJY3c9PQotLS0tLUVORCBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0K
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - server auth
  username: agent-x
status: {}

controlplane ~ ➜  kubectl get csr agent-smith -o yaml | grep groups -A3
  groups:
  - system:masters
  - system:authenticated
```

### Final Answers

```shell
system:masters
```

## Task 8

That doesn't look very right. Reject that request.

### Solutions

```shell
controlplane ~ ✖ kubectl get csr 
NAME          AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
agent-smith   22m   kubernetes.io/kube-apiserver-client    agent-x            <none>              Pending
akshay        35m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved

controlplane ~ ➜  kubectl certificate --help 
Modify certificate resources.

Available Commands:
  approve       Approve a certificate signing request
  deny          Deny a certificate signing request

Usage:
  kubectl certificate SUBCOMMAND [options]

Use "kubectl certificate <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  kubectl deny agent-smith
error: unknown command "deny" for "kubectl"

controlplane ~ ✖ kubectl certificate deny agent-smith
certificatesigningrequest.certificates.k8s.io/agent-smith denied

controlplane ~ ➜  kubectl get csr 
NAME          AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
agent-smith   23m   kubernetes.io/kube-apiserver-client    agent-x            <none>              Denied
akshay        36m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved
```

## Task 9 
Let's get rid of it. Delete the new CSR object. 

### Solutions 
```shell
controlplane ~ ➜  kubectl get csr 
NAME          AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
agent-smith   25m   kubernetes.io/kube-apiserver-client    agent-x            <none>              Denied
akshay        37m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved

controlplane ~ ➜  kubectl delete csr agent-smith
certificatesigningrequest.certificates.k8s.io "agent-smith" deleted

controlplane ~ ➜  kubectl get csr 
NAME     AGE   SIGNERNAME                             REQUESTOR          REQUESTEDDURATION   CONDITION
akshay   37m   kubernetes.io/kube-api-server-client   kubernetes-admin   <none>              Approved
```