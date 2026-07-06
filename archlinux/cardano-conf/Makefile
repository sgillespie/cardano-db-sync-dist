PKGNAME := cardano-conf
PKG := $(PKGNAME).pkg.tar.zst
.DEFAULT_GOAL := build

init:

.PHONY: pkgsums
pkgsums: init
	updpkgsums

.PHONY: build
build: cardano-conf.pkg.tar.zst

$(PKG): PKGBUILD
	pkgctl build
	cp $(PKGNAME)-*-any.pkg.tar.zst $(PKG)

.PHONY: clean
clean:
	rm -rf \
		src pkg \
		*.log *.pkg.tar.zst *.tar.gz 
