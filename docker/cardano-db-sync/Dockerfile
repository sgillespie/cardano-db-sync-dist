# syntax=docker/dockerfile:1
# cardano-db-sync: cardano-db-sync binary + baked-in migrations and network-configs.
# Includes upstream static release binaries.
ARG DBSYNC_VERSION=13.7.2.1
ARG CONF_IMAGE=ghcr.io/sgillespie/cardano-conf:11.0.1

# Baked-in network configs
FROM ${CONF_IMAGE} AS conf

FROM debian:trixie-slim AS fetcher
ARG DBSYNC_VERSION
# Fetch the release tarball
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates
RUN curl -fsSL -o /tmp/db-sync.tar.gz \
      "https://github.com/IntersectMBO/cardano-db-sync/releases/download/${DBSYNC_VERSION}/cardano-db-sync-${DBSYNC_VERSION}-linux.tar.gz"
# Unpack it
RUN mkdir -p /tmp/db-sync && tar -xzf /tmp/db-sync.tar.gz -C /tmp/db-sync
# Copy the binaries/migrations
RUN install -d /usr/share/cardano-db-sync/schema && \
  install -m0755 /tmp/db-sync/bin/cardano-db-sync /usr/bin/cardano-db-sync && \
  install -m0644 /tmp/db-sync/schema/* /usr/share/cardano-db-sync/schema/

FROM debian:trixie-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends postgresql-client
# Create a fixed cardano user (uid/gid 10000) to access the node socket
RUN groupadd --system --gid 10000 cardano; \
    useradd --system --uid 10000 --gid 10000 \
      --home-dir /var/lib/cardano-db-sync --shell /usr/sbin/nologin cardano; \
    install -d -o cardano -g cardano /var/lib/cardano-db-sync /run/cardano
# Copy migrations/binaries
COPY --from=fetcher /usr/bin/cardano-db-sync /usr/bin/
COPY --from=fetcher /usr/share/cardano-db-sync /usr/share/cardano-db-sync
# Copy network configs
COPY --from=conf /etc/cardano /etc/cardano
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

USER cardano
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
