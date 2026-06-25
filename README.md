# DB Sync Package Blueprints _(cardano-db-sync-dist)_

> systemd templates for packaging and deploying cardano-db-sync

This repository contains resources for packaging and distributing
[cardano-db-sync](https://github.com/IntersectMBO/cardano-db-sync) and
[cardano-node](https://github.com/IntersectMBO/cardano-node)

## Release Distributions

Static binaries can be found on the GitHub release pages:

 * [cardano-db-sync](https://github.com/IntersectMBO/cardano-db-sync/releases)
 * [cardano-node](https://github.com/IntersectMBO/cardano-node/releases)

Up-to-date environment configurations can be found in the 
[Cardano Operations Book](https://book.play.dev.cardano.org/environments.html)

## Installation

### Cardano Node

 1. Obtain the cardano-node static binaries from [Release
    Distributions](#release-distributions) (under _Assets_).

 2. Copy the binaries to `/usr/bin`:

        tar xzf cardano-node-X.Y.Z-linux-amd64.tar.gz
        sudo install -m755 bin/{cardano-cli,cardano-node} /usr/bin

 3. Install the systemd service unit files:

        sudo install -Dm644 init/cardano-node.service /usr/lib/systemd/system/cardano-node.service
        sudo install -Dm644 init/cardano-node.sysusers /usr/lib/sysusers.d/cardano-node.conf
        sudo install -Dm644 init/cardano-node.tmpfiles  /usr/lib/tmpfiles.d/cardano-node.conf
 
 4. Create the user and configuration directories

        sudo systemd-sysusers
        sudo systemd-tmpfiles --create

 5. Download the configuration for the network you want to run:

        cd /etc/cardano
        sudo curl -O "https://book.play.dev.cardano.org/environments/mainnet/{config,cardano-db-sync,submit-api-config,topology,byron-genesis,shelley-genesis,alonzo-genesis,conway-genesis,checkpoints}.json"

 6. Enable and start cardano-node

        sudo systemctl daemon-reload
        sudo systemctl enable --now cardano-node.service

### Cardano DB Sync

 1. Install the systemd service unit files:

        sudo install -Dm644 init/cardano-db-sync.service /usr/lib/systemd/system/cardano-db-sync
        sudo install -Dm644 init/cardano-db-sync.tmpfiles /usr/lib/tmpfiles.d/cardano-db-sync.conf

 2. Create the configuration directories:

        sudo systemd-tmpfiles --create

 3. Obtain the cardano-db-sync static binaries from [Release Distributions](#release-distributions)
    (under _Assets_).

 4. Copy the binaries and migrations to the system paths:

        tar xzf cardano-db-sync-W.X.Y.Z-linux.tar.gz
        sudo install -m755 bin/cardano-db-sync /usr/bin/cardano-db-sync
        sudo install -m644 schema/* /usr/share/cardano-db-sync/schema/
 
 5. Enable and start cardano-db-sync

        sudo systemctl daemon-reload
        sudo systemctl enable --now cardano-db-sync.service
