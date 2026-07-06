PKGNAME := cardano-db-sync-bin
PKG := $(PKGNAME).pkg.tar.zst
.DEFAULT_GOAL := build

.PHONY: init
init: cardano-db-sync@.service cardano-db-sync.tmpfiles

cardano-db-sync@.service: ../../init/cardano-db-sync@.service
	cp ../../init/cardano-db-sync@.service cardano-db-sync@.service

cardano-db-sync.tmpfiles: ../../init/cardano-db-sync.tmpfiles
	cp ../../init/cardano-db-sync.tmpfiles cardano-db-sync.tmpfiles

.PHONY: pkgsums
pkgsums: init
	updpkgsums

.PHONY: build
build: $(PKG)

$(PKG): cardano-db-sync@.service cardano-db-sync.tmpfiles PKGBUILD
	pkgctl build \
		-I ../cardano-conf/cardano-conf.pkg.tar.zst \
		-I ../cardano-node-bin/cardano-node-bin.pkg.tar.zst
	cp $(PKGNAME)-*-x86_64.pkg.tar.zst $(PKG)

.PHONY: clean
clean:
	rm -rf \
		cardano-db-sync@.service cardano-db-sync.tmpfiles db-sync-config-*.json \
		src pkg \
		*.log *.pkg.tar.zst *.tar.gz 
