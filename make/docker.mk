export HOST_UID=$(shell id -u)
export HOST_GID=$(shell id -g)

export GIT_HASH  ?= $(shell git --no-pager show -s --format="%h")

DOCKER_RUN = docker run --rm -u $(HOST_UID):$(HOST_GID) -e HOME=/home
DOCKER_IMAGE_PREFIX := jvisser
DOCKER_IMAGE := $(DOCKER_IMAGE_PREFIX)/$(PROJECT_NAME)-website
export DOCKER_IMAGE_TAG := $(DOCKER_IMAGE):$(GIT_HASH)
DOCKER_IMAGE_TAG_DIST := $(DOCKER_IMAGE):dist

docker/app/.built: $(APP_DEPS)
	docker build -f $< -t $(DOCKER_IMAGE_TAG) -t $(DOCKER_IMAGE_TAG_DIST) .

	touch $@

docker/app/.pushed: docker/app/.built
	# Push alias for dist images with the timestamp and hash of the current git commit
	docker push $(DOCKER_IMAGE_TAG)
	docker push $(DOCKER_IMAGE_TAG_DIST)

	touch $@
