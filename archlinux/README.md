# Arch Linux Packages _(cardano-db-sync-dist)_

> Arch Linux packages for deploying cardano-db-sync and its dependencies

These packages are now on [AUR](https://aur.archlinux.org). They consist of:

 * [cardano-conf](https://aur.archlinux.org/packages/cardano-conf): network configuration 
   files for `mainnet`, `preprod`, and `preview`
 * [cardano-node-bin](https://aur.archlinux.org/packages/cardano-node-bin): cardano-node 
   with static binaries
 * [cardano-db-sync-bin](https://aur.archlinux.org/packages/cardano-db-sync-bin): 
   cardano-db-sync with static binaries

Because they depend on each other, they must be built in order, eg `cardano-conf` -> 
`cardano-node-bin` -> `cardano-db-sync-bin`

## Prerequisites

For installation with an [AUR helper](https://wiki.archlinux.org/title/AUR_helpers), only
the helper is required. [Yay](https://github.com/Jguer/yay) and 
[Paru](https://github.com/morganamilo/paru) are popular choices.

To manually build, the following Arch Linux packages are required:

 * [base-devel](https://archlinux.org/packages/core/any/base-devel/)
 * [git](https://archlinux.org/packages/extra/x86_64/git/)

## Quick Start

To install `cardano-node-bin` and `cardano-db-sync-bin`:

```
# With paru:
paru -S cardano-node-bin cardano-db-sync-bin 

# Or, with yay
yay -S cardano-node-bin cardano-db-sync-bin
```

Install [postgresql](https://wiki.archlinux.org/title/PostgreSQL) and create the database:

```
sudo -u postgres createuser cardano-node --no-superuser --createdb
# eg cardano-db-sync-mainnet
sudo -u cardano-node createdb cardano-db-sync-NETWORK
```

Enable and start the services for the desired network:

```
# eg cardano-node@mainnet.service
sudo systemctl enable --now cardano-node@NETWORK.service
# eg cardano-db-sync@mainnet.service
sudo systemctl enable --now cardano-db-sync@NETWORK.service
```

**Note:** The cardano-db-sync network must match the cardano-node network!

## Building Manually

To build without an AUR helper, first clone the packages from AUR:

```
git clone https://aur.archlinux.org/cardano-conf.git
git clone https://aur.archlinux.org/cardano-node-bin.git
git clone https://aur.archlinux.org/cardano-db-sync-bin.git
```

Carefully inspect each `PKGBUILD` along with the `.install` files, then build and install 
them in order:

```
cd cardano-conf
makepkg --syncdeps --install

cd ../cardano-node-bin
makepkg --syncdeps --install

cd ../cardano-db-sync-bin
makepkg --syncdeps --install
```

