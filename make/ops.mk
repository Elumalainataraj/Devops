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
