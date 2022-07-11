# Kafka local deployments

As always, there are multiple options available for Kafka deployments in local.

Confluent Kafka vs Bitnami Kafka

Since the Confluent Kafka is available as SaaS platform just need to connect the platform for SaaS or production deployments.

Costing is not done in this R&D will do if required.

Note: Kafka need 3 replicas to start the Topic. So keeping one replica will fail.

Performance in local:

```
7 records sent, 1.3 records/sec (0.00 MB/sec), 95.0 ms avg latency, 512.0 ms max latency.
6 records sent, 1.0 records/sec (0.00 MB/sec), 23.2 ms avg latency, 57.0 ms max latency.
6 records sent, 1.0 records/sec (0.00 MB/sec), 12.2 ms avg latency, 18.0 ms max latency.
5 records sent, 1.0 records/sec (0.00 MB/sec), 11.6 ms avg latency, 14.0 ms max latency.
5 records sent, 1.0 records/sec (0.00 MB/sec), 10.6 ms avg latency, 13.0 ms max latency.
6 records sent, 1.0 records/sec (0.00 MB/sec), 10.2 ms avg latency, 12.0 ms max latency.
5 records sent, 1.0 records/sec (0.00 MB/sec), 9.0 ms avg latency, 10.0 ms max latency.
```

To check the Kafka performance

```bash
kubectl apply -f minikube/kafka/test-app.yaml
```

To install the complete environment from confluent

```bash
kubectl apply -f minikube/kafka/confluent-platform.yaml
```
