# macOS Packages _(cardano-db-sync-dist)_

> Homebrew formulae for deploying cardano-db-sync and its dependencies

This directory contains [Homebrew](https://brew.sh) formulae for installing
cardano-db-sync on macOS. [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux)
is also supported.

The following formulae are included here:

 * `cardano-conf`: network configuration files for `mainnet`, `preprod`, and `preview`
 * `cardano-node`: cardano-node static binaries
 * `cardano-node-mainnet`: cardano-node background service for `mainnet`
 * `cardano-node-preview`: cardano-node background service for `preview`
 * `cardano-node-preprod`: cardano-node background service for `preprod`
 * `cardano-db-sync`: cardano-db-sync static binaries
 * `cardano-db-sync-mainnet`: cardano-db-sync background service for `mainnet`
 * `cardano-db-sync-preview`: cardano-db-sync background service for `preview`
 * `cardano-db-sync-preprod`: cardano-db-sync background service for `preprod`

## Prerequisites

To use these packages, you need only [Homebrew](brew.sh) on macOS or Linux.

## Quick Start

Add this formula repository and mark it as trusted:

```
brew tap https://github.com/sgillespie/cardano-db-sync-dist
brew trust sgillespie/cardano-db-sync-dist
```

Install cardano-node for the desired network:

```
# eg, cardano-node-mainnet
brew install cardano-node-NETWORK
brew services start cardano-node-NETWORK
```

Install postgresql and create the database:

```
brew install postgresql
brew services start postgresql
# eg, cardano-db-sync-mainnet
createdb cardano-db-sync-NETWORK
```

Install cardano-db-sync for the desired network, start it now, and restart at login: 

```
# eg, cardano-db-sync-mainnet
brew install cardano-db-sync-NETWORK
brew services start cardano-db-sync-NETWORK
```
