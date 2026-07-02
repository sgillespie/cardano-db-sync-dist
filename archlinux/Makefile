.DEFAULT_GOAL := pkgsums

init: cardano-node.service cardano-node.sysusers
pkgsums: PKGBUILD

cardano-node.service: ../init/cardano-node.service
	cp ../init/cardano-node.service cardano-node.service

cardano-node.sysusers: ../init/cardano-node.sysusers
	cp ../init/cardano-node.sysusers cardano-node.sysusers

PKGBUILD: cardano-node.service cardano-node.sysusers
	updpkgsums

clean:
	rm -rf cardano-node.service cardano-node.sysusers *.log *.pkg.tar.zst *.tar.gz src
