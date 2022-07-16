OS_NAME := $(shell uname -s | tr A-Z a-z)
TIMESTAMP ?= $$(date -u +'%Y%m%d%H%M%S')

include make/kind.mk
include make/minikube.mk
include make/ops.mk
