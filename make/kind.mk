.PHONY: charts

cluster: kind-cluster

kind: kind-cluster

kind-cluster:
	@echo Creating Kind environment
	@kind create cluster --config kind/config.yaml --name k8s-1.21.1

delete-kind:
	@kind delete cluster --name k8s-1.21.1
