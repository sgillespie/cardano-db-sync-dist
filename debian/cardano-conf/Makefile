PLAYGROUND_COMMIT := e18bf6327fa9956c907739d049e9b3ec0c6a7dd6
ARCHIVE := cardano-playground-$(PLAYGROUND_COMMIT).tar.gz
EXTRACT_STAMP := etc/cardano/.$(PLAYGROUND_COMMIT)

.PHONY: build
build: etc/cardano/.$(PLAYGROUND_COMMIT) 
	dpkg-buildpackage

.PHONY: extract
extract: $(EXTRACT_STAMP)

$(EXTRACT_STAMP): $(ARCHIVE)
	rm -rf etc/cardano
	mkdir -p etc/cardano
	tar -C etc/cardano \
		--strip-components 4 \
		-xzf "$<" \
		cardano-playground-$(PLAYGROUND_COMMIT)/static/book.play.dev.cardano.org/environments
	touch "$@"

.PHONY: fetch
fetch: $(ARCHIVE)

$(ARCHIVE):
	curl -fsSL -o "$@.tmp" \
		"https://github.com/input-output-hk/cardano-playground/archive/$(PLAYGROUND_COMMIT).tar.gz"
	mv "$@.tmp" "$@"

.PHONY: clean
clean:
	rm -rf "$(ARCHIVE)" etc
