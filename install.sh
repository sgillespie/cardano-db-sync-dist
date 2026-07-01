#!/usr/bin/env bash
set -eu -o pipefail
# Remove me when you're comfortable
set -x

# Versions to fetch
export CARDANO_NODE_VERSION=11.0.1
export CARDANO_DB_SYNC_VERSION=13.7.2.1
export CARDANO_ENVIRONMENT=mainnet

# Create a directory to work in
mkdir -p tmp

## cardano-node
WORKDIR="$(mktemp --tmpdir=tmp --directory cardano-node.XXXXX)"
ARCHIVE="cardano-node-$CARDANO_NODE_VERSION-linux-amd64.tar.gz"

# Create a working directory
mkdir -p "$WORKDIR"

# Fetch the static binaries
wget \
  "https://github.com/IntersectMBO/cardano-node/releases/download/$CARDANO_NODE_VERSION/$ARCHIVE" \
  --timestamping \
  --no-verbose

# Install the binaries
tar -C "$WORKDIR" -xzf "$ARCHIVE"
install -m755 "$WORKDIR/bin/"{cardano-cli,cardano-node} /usr/bin

# Install the systemd service unit files
install -Dm644 init/cardano-node.service /usr/lib/systemd/system/cardano-node.service
install -Dm644 init/cardano-node.sysusers /usr/lib/sysusers.d/cardano-node.conf
install -Dm644 init/cardano-node.tmpfiles  /usr/lib/tmpfiles.d/cardano-node.conf

# Create user and config directories
systemd-sysusers
systemd-tmpfiles --create

# Download config files
declare -a CFG_FILES
CFG_FILES=(
  "config.json"
  "db-sync-config.json"
  "submit-api-config.json"
  "submit-api-config.json"
  "topology.json"
  "byron-genesis.json"
  "shelley-genesis.json"
  "alonzo-genesis.json"
  "conway-genesis.json"
  "checkpoints.json"
)
ENV_PREFIX="https://book.play.dev.cardano.org/environments/$CARDANO_ENVIRONMENT"

printf "${ENV_PREFIX}/%s\n" "${CFG_FILES[@]}" \
  | xargs wget --directory-prefix /etc/cardano --timestamping --no-verbose

# Clean up working directory
rm -r $WORKDIR

## cardano-db-sync
WORKDIR="$(mktemp --tmpdir=tmp --directory cardano-db-sync.XXXXX)"
ARCHIVE="cardano-db-sync-$CARDANO_DB_SYNC_VERSION-linux.tar.gz"

# Create a working directory
mkdir -p "$WORKDIR"

# Fetch the static binaries
wget \
  "https://github.com/IntersectMBO/cardano-db-sync/releases/download/$CARDANO_DB_SYNC_VERSION/$ARCHIVE" \
  --timestamping \
  --no-verbose

# Install systemd service unit files
install -Dm644 init/cardano-db-sync.service /usr/lib/systemd/system/cardano-db-sync.service
install -Dm644 init/cardano-db-sync.tmpfiles /usr/lib/tmpfiles.d/cardano-db-sync.conf

# Create config dirs
systemd-tmpfiles --create

# Install binaries and migrations
tar -C "$WORKDIR" -xzf "$ARCHIVE"
install -m755 "$WORKDIR/bin/cardano-db-sync" /usr/bin/cardano-db-sync
install -m644 "$WORKDIR/schema/"* /usr/share/cardano-db-sync/schema/

# Uncomment me when comfortable
rm -r $WORKDIR

systemctl daemon-reload
