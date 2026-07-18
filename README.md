# DB Sync Package Templates _(cardano-db-sync-dist)_

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

This repository contains multiple ways to install cardano-db-sync:

 * [Arch Linux](#arch-linux): pacman packages
 * [Docker](#docker): Docker images
 * [Installation Script](#installation-script): a script that automates the manual steps
 * [Manual Steps](#manual-steps): install the static binaries and systemd units by hand

### Arch Linux

These packages are on [AUR](https://aur.archlinux.org). Install with an 
[AUR helper](https://wiki.archlinux.org/title/AUR_helpers):

```
# With paru:
paru -S cardano-node-bin cardano-db-sync-bin 

# Or, with yay
yay -S cardano-node-bin cardano-db-sync-bin
```

For detailed instructions, see [archlinux/README.md](archlinux/README.md)

### Docker

See [docker/README.md](docker/README.md)

### Installation Script

The [Manual Steps](#manual-steps) can be automated by using the [install script](install.sh).
Before running, be sure to carefully review the script and the manual steps below.

```
sudo ./install.sh
```

### Manual Steps

#### Cardano Node

 1. Obtain the cardano-node static binaries from [Release
    Distributions](#release-distributions) (under _Assets_).

 2. Copy the binaries to `/usr/bin`:

        tar xzf cardano-node-X.Y.Z-linux-amd64.tar.gz
        sudo install -m755 bin/{cardano-cli,cardano-node} /usr/bin

 3. Install the systemd service unit files:

        sudo install -Dm644 init/cardano-node@.service /usr/lib/systemd/system/cardano-node@.service
        sudo install -Dm644 init/cardano-node.sysusers /usr/lib/sysusers.d/cardano-node.conf
        sudo install -Dm644 init/cardano-node.tmpfiles  /usr/lib/tmpfiles.d/cardano-node.conf
 
 4. Create the user and configuration directories

        sudo systemd-sysusers
        sudo systemd-tmpfiles --create

 5. Download the network configurations from the [Cardano Operations Book](https://book.play.dev.cardano.org/environments.html)

        # Create the configuration directory
        sudo install -d /etc/cardano
        # Download the environment configurations and extract to /etc/cardano/{environment}
        curl -L https://github.com/input-output-hk/cardano-playground/archive/refs/heads/main.tar.gz \
          | sudo tar --strip-components=4 -C /etc/cardano -xvz cardano-playground-main/static/book.play.dev.cardano.org/environments

 6. Enable and start cardano-node

        # Reload the systemd configuration
        sudo systemctl daemon-reload
        # Start and enable cardano-node for the desired network 
        # (eg, cardano-node@mainnet.service)
        sudo systemctl enable --now cardano-node@NETWORK.service

#### Cardano DB Sync

 1. Install the systemd service unit files:

        sudo install -Dm644 init/cardano-db-sync@.service /usr/lib/systemd/system/cardano-db-sync@.service
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

        # Reload the systemd configuration
        sudo systemctl daemon-reload
        # Start and enable cardano-db-sync for the desired network 
        # (eg, cardano-db-sync@mainnet.service)
        sudo systemctl enable --now cardano-db-sync@NETWORK.service

