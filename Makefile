OS_NAME := $(shell uname -s | tr A-Z a-z)
TIMESTAMP ?= $$(date -u +'%Y%m%d%H%M%S')

include make/kind.mk
include make/minikube.mk
include make/ops.mk

ingress:
	@helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	@echo Installing Ingress Helm Chart
	@helm install -f minikube/nginx/values.yaml nginx ingress-nginx/ingress-nginx

mongo:
	@helm repo add mongodb https://mongodb.github.io/helm-charts
	@helm install community-operator mongodb/community-operator
	@kubectl apply -f minikube/mongo-community-operator/mongo.yaml

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

delete-app:
	@helm delete grafana prometheus
