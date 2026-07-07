# Arch Linux Packages _(cardano-db-sync-dist)_

> Arch Linux packages for deploying cardano-db-sync and its dependencies

This directory contains the following Arch Linux packages:

 * `cardano-conf`: network configuration files for `mainnet`, `preprod`, and `preview`
 * `cardano-node-bin`: cardano-node with static binaries
 * `cardano-db-sync-bin`: cardano-db-sync with static binaries

Because they depend on each other, they must be built in order, eg `cardano-conf` -> 
`cardano-node-bin` -> `cardano-db-sync-bin`

## Prerequisites

The following Arch Linux packages are required:

 * [base-devel](https://archlinux.org/packages/core/any/base-devel/)
 * [devtools](https://archlinux.org/packages/extra/x86_64/devtools/)
 * [pacman-contrib](https://archlinux.org/packages/extra/x86_64/pacman-contrib/)

```
sudo pacman -S --needed base-devel devtools pacman-contrib git
```

## Quick Start

Build the packages:

```
cd archlinux
make
```

Install them:

```
sudo pacman -U \
    cardano-conf/cardano-conf.pkg.tar.zst \
    cardano-node-bin/cardano-node-bin.pkg.tar.zst \
    cardano-db-sync-bin/cardano-db-sync-bin.pkg.tar.zst
```

Enable and start the services for the desired network:

```
# eg cardano-node@mainnet.service
sudo systemctl enable --now cardano-node@NETWORK.service
# eg cardano-db-sync@mainnet.service
sudo systemctl enable --now cardano-db-sync@mainnet.service
```

## Updating Package Checksums

After updating files in `init/` or a `PKGBUILD`, the `sha256sums` can be updated by
running:

```
make pkgsums
```
