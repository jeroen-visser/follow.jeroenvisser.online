SHELL := /bin/bash
.DELETE_ON_ERROR:

ROOT_DIR := $(abspath .)
MAKE_INCLUDES_DIR := make

export DOMAIN_NAME := follow.jeroenvisser.online
export PROJECT_NAME := follow.jeroenvisser.online

export KUBE_APP_NAMESPACE = follow-jeroenvisser-online
KUBE_YAMLS := env/prod/kube.yaml
KUBE_YAML_STAGING_ISSUER := env/prod/staging_issuer.yaml
KUBE_YAML_PRODUCTION_ISSUER := env/prod/production_issuer.yaml

APP_DEPS=docker/app/Dockerfile

include make/encrypt.mk
include make/docker.mk
include make/kubernetes.mk

.PHONY: build-image
build-image: docker/app/.built

.PHONY: push-image
push-image: docker/app/.pushed