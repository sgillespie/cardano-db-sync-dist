PKGS := cardano-conf cardano-node
.DEFAULT_GOAL := build

.PHONY: init build clean
init: $(addsuffix .init, $(PKGS))
build: $(addsuffix .build, $(PKGS))
clean: $(addsuffix .clean, $(PKS))

%.init:
	$(MAKE) -C "$*" init

%.build:
	$(MAKE) -C "$*" build

cardano-node-bin.build: cardano-conf.build

%.clean:
	$(MAKE) -C "$*" clean
