REGISTRY ?= ghcr.io/sgillespie
NODE_VERSION ?= 11.0.1
DBSYNC_VERSION ?= 13.7.2.1
PLAYGROUND_COMMIT ?= e18bf6327fa9956c907739d049e9b3ec0c6a7dd6
CONF_IMAGE := $(REGISTRY)/cardano-conf:$(NODE_VERSION)

.DEFAULT_GOAL := build

.PHONY: build conf node db-sync push clean

build: node db-sync

conf:
	podman build \
	  --build-arg PLAYGROUND_COMMIT=$(PLAYGROUND_COMMIT) \
	  -t $(CONF_IMAGE) cardano-conf

node: conf
	podman build \
	  --build-arg NODE_VERSION=$(NODE_VERSION) \
	  --build-arg CONF_IMAGE=$(CONF_IMAGE) \
	  -t $(REGISTRY)/cardano-node:$(NODE_VERSION) cardano-node

db-sync: conf
	podman build \
	  --build-arg DBSYNC_VERSION=$(DBSYNC_VERSION) \
	  --build-arg CONF_IMAGE=$(CONF_IMAGE) \
	  -t $(REGISTRY)/cardano-db-sync:$(DBSYNC_VERSION) cardano-db-sync

push:
	podman push $(CONF_IMAGE)
	podman push $(REGISTRY)/cardano-node:$(NODE_VERSION)
	podman push $(REGISTRY)/cardano-db-sync:$(DBSYNC_VERSION)

clean:
	-podman rmi \
	  $(REGISTRY)/cardano-node:$(NODE_VERSION) \
	  $(REGISTRY)/cardano-db-sync:$(DBSYNC_VERSION) \
	  $(CONF_IMAGE)
