.DEFAULT_GOAL := pkgsums

init: cardano-node.service cardano-node.sysusers cardano-node.tmpfiles
pkgsums: PKGBUILD

cardano-node.service: ../init/cardano-node.service
	cp ../init/cardano-node.service cardano-node.service

cardano-node.sysusers: ../init/cardano-node.sysusers
	cp ../init/cardano-node.sysusers cardano-node.sysusers

cardano-node.tmpfiles: ../init/cardano-node.tmpfiles
	cp ../init/cardano-node.tmpfiles cardano-node.tmpfiles

PKGBUILD: cardano-node.service cardano-node.sysusers cardano-node.tmpfiles
	updpkgsums

clean:
	rm cardano-node.service cardano-node.sysusers cardano-node.tmpfiles
