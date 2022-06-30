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

### Cluster requirements

Kubernetes used for Production workloads. Each docker image will be packaged as Helm chart.

Will deliver Helm charts for Kubernetes. All application helm charts will be delivered.

Production work loads - 3 worker nodes (Any configurations)

Vizual Platform application - 4 Pods (BPMN - 1, Notification - 1, UI - 1, Front-end - 1 )

Pods requirements

BPMN & Notification - 512m + 1 Core each ( 1GB+ 2core) If use 3 replicas for High avilablity then mutliply by 3.

Frontend & UI - 400m + 0.5 milli core (if more replicas, this will be increased)

Dependencies:

1. Mongo
2. Kafka
3. KeyCloak
4. Monitoring (Prometheus - preffered )
5. Logging (Anylogging solution, dashboard should be available to see the logs)
6. Nginx

On high usage, this should be scalable. Which dont block the Applciation.
