#!/bin/sh
set -eu

: "${NETWORK:=mainnet}"
CONF_DIR="/etc/cardano/${NETWORK}"
STATE_DIR="/var/lib/cardano-db-sync/${NETWORK}"
mkdir -p "${STATE_DIR}/cardano-db-sync"

# If $PGPASSFILE is set and exists (or default /tmp/pgpass), use it. Otherwise, generate
# one from environment variables
: "${PGPASSFILE:=/tmp/pgpass}"
if [ ! -f "$PGPASSFILE" ]; then
  if [ -z "${PGHOST:-}" ]; then
    echo "set PGHOST or mount PGPASSFILE" >&2
    exit 1
  fi

  printf '%s:%s:%s:%s:%s\n' \
    "${PGHOST}" \
    "${PGPORT:-5432}" \
    "${PGDATABASE:-cardano-db-sync-$NETWORK}" \
    "${PGUSER:-cardano}" \
    "${PGPASSWORD:?set PGPASSWORD}" \
    > "$PGPASSFILE"
  chmod 600 "$PGPASSFILE"
fi
export PGPASSFILE

exec cardano-db-sync \
  --config "${CONF_DIR}/db-sync-config.json" \
  --state-dir "${STATE_DIR}/cardano-db-sync" \
  --socket-path "/run/cardano/${NETWORK}/node.socket" \
  --schema-dir /usr/share/cardano-db-sync/schema \
  "$@"
