PKGNAME := cardano-node-bin
PKG := $(PKGNAME).pkg.tar.zst
.DEFAULT_GOAL := build

.PHONY: init
init: cardano-node.service cardano-node.sysusers

cardano-node.service: ../../init/cardano-node.service
	cp ../../init/cardano-node.service cardano-node.service

cardano-node.sysusers: ../../init/cardano-node.sysusers
	cp ../../init/cardano-node.sysusers cardano-node.sysusers

.PHONY: pkgsums
pkgsums: init
	updpkgsums

.PHONY: build
build: $(PKG)

$(PKG): cardano-node.service cardano-node.sysusers PKGBUILD
	pkgctl build -I ../cardano-conf/cardano-conf.pkg.tar.zst
	cp $(PKGNAME)-*-x86_64.pkg.tar.zst $(PKG)

.PHONY: clean
clean:
	rm -rf \
		cardano-node.service cardano-node.sysusers \
		src pkg \
		*.log *.pkg.tar.zst *.tar.gz 
