.DEFAULT_GOAL := pkgsums

init: cardano-db-sync.service cardano-db-sync.tmpfiles
pkgsums: PKGBUILD

cardano-db-sync.service: ../../init/cardano-db-sync.service
	cp ../../init/cardano-db-sync.service cardano-db-sync.service

cardano-db-sync.tmpfiles: ../../init/cardano-db-sync.tmpfiles
	cp ../../init/cardano-db-sync.tmpfiles cardano-db-sync.tmpfiles

PKGBUILD: cardano-db-sync.service cardano-db-sync.tmpfiles
	updpkgsums

clean:
	rm -rf \
		cardano-db-sync.service cardano-db-sync.tmpfiles db-sync-config-*.json \
		src pkg \
		*.log *.pkg.tar.zst *.tar.gz 
