OS_NAME := $(shell uname -s | tr A-Z a-z)
TIMESTAMP ?= $$(date -u +'%Y%m%d%H%M%S')

default: build

install: install-protoc

install-protoc:
	@echo Installing protoc $(PROTOCV) binaries to $(PROTOLOC)
ifeq ($(findstring mingw64,$(OS_NAME)),mingw64)
	@curl -sSLO https://github.com/protocolbuffers/protobuf/releases/download/v$(PROTOCV)/$(PROTOZIP)
	@mkdir -p /c/protoc
	@unzip -o $(PROTOZIP) -d $(PROTOLOC) bin/protoc* > /dev/null
	@unzip -o $(PROTOZIP) -d $(PROTOLOC) include/* > /dev/null
	@rm -f $(PROTOZIP)
	@echo
	@echo Please update your PATH to include $(PROTOLOC)/bin
endif

ifeq ($(findstring darwin,$(OS_NAME)),darwin)
	@mkdir -p $(HOME)/.protobuf/bin
	@cd $(HOME)/.protobuf
	@curl -sSLO https://github.com/protocolbuffers/protobuf/releases/download/v$(PROTOCV)/$(PROTOZIP)
	@unzip -o $(PROTOZIP) -d $(PROTOLOC) bin/protoc > /dev/null
	@unzip -o $(PROTOZIP) -d $(PROTOLOC) include/* > /dev/null
	@rm -f $(PROTOZIP)
endif

ifeq ($(findstring linux,$(OS_NAME)),linux)
	@curl -sSLO https://github.com/protocolbuffers/protobuf/releases/download/v$(PROTOCV)/$(PROTOZIP)
	@sudo unzip -o $(PROTOZIP) -d $(PROTOLOC) bin/protoc > /dev/null
	@sudo unzip -o $(PROTOZIP) -d $(PROTOLOC) include/* > /dev/null
	@rm -f $(PROTOZIP)
endif

dirty:
ifneq ($(DIRTY),)
	@echo modified/untracked files; echo $(DIRTY); exit 1
else
	@echo 'clean'
endif

include make/kind.mk
include make/minikube.mk

#### Run this command once minikube available
## eval $(minikube -p minikube docker-env)
####

ingress:
	@helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	@echo Installing Ingress Helm Chart
	@helm install -f minikube/nginx/values.yaml nginx ingress-nginx/ingress-nginx --version 4.0.13

install-canary-app:
	@helm install -f minikube/dev/staging.yaml canary-dev charts/dev
	@helm install -f minikube/dev/prd.yaml prd-dev charts/dev

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
