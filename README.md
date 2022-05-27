# devops

Install tools automation for Linux, Mac and Windows

```bash
make ops
```

Note: If you are using Windows make sure you can use choco, so pakage maanger can install required toold for development.

### kind

To bring local kube cluster on top of Docker

```bash
make kind
```

### helm

Install all required tools to run in kube

```bash
make mongo ingress
```

### Delete cluster

```bash
kind delete cluster --name k8s-1.21.1
```
