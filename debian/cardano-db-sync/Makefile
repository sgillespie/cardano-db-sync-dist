PKGNAME := cardano-db-sync
PKGVER := 13.7.2.1
PKG_ARCHIVE := $(PKGNAME)-$(PKGVER)-linux.tar.gz
PKG_ARCHIVE_URL := https://github.com/IntersectMBO/$(PKGNAME)/releases/download/$(PKGVER)/$(PKG_ARCHIVE)
.DEFAULT_GOAL := build

.PHONY: init build extract fetch clean

build: debian/cardano-db-sync.tmpfiles debian/cardano-db-sync@.service .extract-stamp
	dpkg-buildpackage -b

init: debian/cardano-db-sync.tmpfiles debian/cardano-db-sync@.service

debian/cardano-db-sync.tmpfiles: ../../init/cardano-db-sync.tmpfiles
	cp "$<" "$@"

debian/cardano-db-sync@.service: ../../init/cardano-db-sync@.service
	cp "$<" "$@"

extract: .extract-stamp

.extract-stamp: $(PKG_ARCHIVE)
	tar xzf "$<"
	touch "$@"

fetch: $(PKG_ARCHIVE)

$(PKG_ARCHIVE):
	curl -fsSL -o "$@.tmp" "$(PKG_ARCHIVE_URL)"
	mv "$@.tmp" "$@"

clean:
	dh clean --without autoreconf
	rm -rf $(PKG_ARCHIVE) \
		bin schema .extract-stamp \
		debian/cardano-db-sync@.service debian/cardano-db-sync.tmpfiles
