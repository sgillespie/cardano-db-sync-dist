PKGS := cardano-conf cardano-node cardano-db-sync
.DEFAULT_GOAL := build

.PHONY: init build clean
init: $(addsuffix .init, $(PKGS))
build: $(addsuffix .build, $(PKGS))
clean: $(addsuffix .clean, $(PKGS))

%.init:
	$(MAKE) -C "$*" init

%.build:
	$(MAKE) -C "$*" build

cardano-node.build: cardano-conf.build
cardano-db-sync.build: cardano-node.build

%.clean:
	$(MAKE) -C "$*" clean
