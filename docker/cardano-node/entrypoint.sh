#!/bin/sh
set -eu

: "${NETWORK:=mainnet}"
CONF_DIR="/etc/cardano/${NETWORK}"
STATE_DIR="/var/lib/cardano/${NETWORK}"
RUN_DIR="/run/cardano/${NETWORK}"

mkdir -p "$STATE_DIR/db" "$RUN_DIR"
exec cardano-node run \
  --config "${CONF_DIR}/config.json" \
  --topology "${CONF_DIR}/topology.json" \
  --database-path "${STATE_DIR}/db" \
  --socket-path "${RUN_DIR}/node.socket" \
  --host-addr 0.0.0.0 \
  --port "${CARDANO_PORT:-3001}" \
  "$@"
