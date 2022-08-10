.PHONY: charts
OS_NAME := $(shell uname -s | tr A-Z a-z)
TIMESTAMP ?= $$(date -u +'%Y%m%d%H%M%S')
HELM_VERSION := v3.9.0
KUBECTL_VERSION := v1.24.0
KIND_VERSION := 0.14.0

install-ops: ops

ops:
	@echo Install Helm for Ops
ifeq ($(findstring mingw64,$(OS_NAME)),mingw64)
	@choco install kubernetes-helm kind
endif

ifeq ($(findstring darwin,$(OS_NAME)),darwin)
	@brew install helm kubectl kind
endif

ifeq ($(findstring linux,$(OS_NAME)),linux)
	@curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
	@sudo apt-get install apt-transport-https --yes
	@echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
	@sudo apt-get update
	@sudo apt-get install helm
endif


ingress:
	@helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	@echo Installing Ingress Helm Chart
	@helm install -f minikube/nginx/values.yaml nginx ingress-nginx/ingress-nginx

clean-ingress:
	@helm delete nginx

mongo:
	@helm repo add mongodb https://mongodb.github.io/helm-charts
	@helm install community-operator mongodb/community-operator
	@kubectl apply -f minikube/mongo-community-operator/mongo.yaml

clean-mongo:
	@kubectl delete -f minikube/mongo-community-operator/mongo.yaml
	@helm delete community-operator

monitoring:
	@helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	@helm install -f minikube/prometheus/values.yaml prometheus prometheus-community/prometheus
	@helm repo add grafana https://grafana.github.io/helm-charts
	@helm install -f minikube/grafana/values.yaml grafana grafana/grafana

es:
	@helm install -f minikube/elastic-search/master.yaml elasticsearch-master elastic/elasticsearch
	@helm install -f minikube/elastic-search/data.yaml elasticsearch-data elastic/elasticsearch
	@helm install -f minikube/kibana/values.yaml kibana elastic/kibana

clean-es:
	@kubectl delete pvc elasticsearch-data-elasticsearch-data-0 elasticsearch-master-elasticsearch-master-0

prd-keycloak-wip:
	@kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/18.0.2/kubernetes/keycloaks.k8s.keycloak.org-v1.yml
	@kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/18.0.2/kubernetes/keycloakrealmimports.k8s.keycloak.org-v1.yml
	@kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/18.0.2/kubernetes/kubernetes.yml

clean-prd-keycloak-wip:
	@kubectl delete -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/18.0.2/kubernetes/kubernetes.yml
	@kubectl delete -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/18.0.2/kubernetes/keycloaks.k8s.keycloak.org-v1.yml
	@kubectl delete -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/18.0.2/kubernetes/keycloakrealmimports.k8s.keycloak.org-v1.yml

keycloak:
	@kubectl apply -f minikube/keycloak/dev-keycloak.yml

clean-keycloak:
	@kubectl delete -f minikube/keycloak/dev-keycloak.yml

delete-app:
	@helm delete grafana prometheus

kafka-prd-wip:
	@helm repo add confluentinc https://packages.confluent.io/helm
	@helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes
	@kubectl apply -f minikube/kafka/dev.yaml

delete-kafka-wip:
	@kubectl delete -f minikube/kafka/dev.yaml
	@helm delete confluent-operator

kafka:
	@helm repo add bitnami https://charts.bitnami.com/bitnami
	@helm install -f minikube/kafka/bitnami-kafka.yaml kafka bitnami/kafka --debug
	@kubectl apply -f minikube/kafka/bkafa-ingress.yaml

clean-kafka:
	@helm delete kafka