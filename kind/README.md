# Kubernetes in Docker (KIND)

<https://sookocheff.com/post/kubernetes/local-kubernetes-development-with-kind/>
<https://kind.sigs.k8s.io/docs/user/local-registry/> - Hope this works after years.

## Pre-requsites

Assuming Docker already running.

```zsh
brew install kind helm
```

To Install the version, check out the release documentation.

<https://github.com/kubernetes-sigs/kind/releases>

```bash
kind create cluster --config kind/config.yaml --name k8s
```

## Makefile

Just run the make command to run the k8s and install nginx and sample application.

```bash
$ make snapshot
$ make kind-cluster
$ make load-image
$ make ingress
$ make install-app
```
