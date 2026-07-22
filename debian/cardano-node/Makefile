PKGNAME := cardano-node
PKGVER := 11.0.1
ARCHIVE := $(PKGNAME)-$(PKGVER)-linux-amd64.tar.gz
ARCHIVE_URL := https://github.com/IntersectMBO/$(PKGNAME)/releases/download/$(PKGVER)/$(ARCHIVE)
.DEFAULT_GOAL := build

.PHONY: init
init: debian/cardano-node.sysusers debian/cardano-node@.service

debian/cardano-node.sysusers: ../../init/cardano-node.sysusers
	cp "$<" "$@"

debian/cardano-node@.service: ../../init/cardano-node@.service
	cp "$<" "$@"

.PHONY: build
build: .extract-stamp debian/cardano-node.sysusers debian/cardano-node@.service
	dpkg-buildpackage -b

.PHONY: extract
extract: .extract-stamp

.extract-stamp: $(ARCHIVE)
	tar xzf "$<"
	touch "$@"

.PHONY: fetch
fetch: $(ARCHIVE)

$(ARCHIVE):
	curl -fsSL -o "$@.tmp" "$(ARCHIVE_URL)"
	mv "$@.tmp" "$@"

.PHONY: clean
clean:
	dh clean --without autoreconf
	rm -rf "$(ARCHIVE)" \
		bin share .extract-stamp \
		debian/cardano-node.sysusers debian/cardano-node@.service
