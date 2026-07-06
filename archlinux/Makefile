PKGS := cardano-conf cardano-node-bin cardano-db-sync-bin
.DEFAULT_GOAL := build

.PHONY: init build pkgsums clean
init: $(addsuffix .init, $(PKGS))
build: $(addsuffix .build, $(PKGS))
pkgsums: $(addsuffix .pkgsums, $(PKGS))
clean: $(addsuffix .clean, $(PKGS))

%.init:
	$(MAKE) -C $* init

%.pkgsums:
	$(MAKE) -C $* pkgsums

%.build:
	$(MAKE) -C $* build

cardano-node-bin.build: cardano-conf.build
cardano-db-sync-bin.build: cardano-conf.build cardano-node-bin.build

%.clean:
	$(MAKE) -C $* clean
