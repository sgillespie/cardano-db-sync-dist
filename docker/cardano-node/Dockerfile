# syntax=docker/dockerfile:1
# cardano-node: cardano-node binary + baked-in network configs. Includes upstream static
# release binaries cardano-node/cardano-cli.
ARG NODE_VERSION=11.0.1
ARG CONF_IMAGE=ghcr.io/sgillespie/cardano-conf:11.0.1

# Baked-in network configs
FROM ${CONF_IMAGE} AS conf

FROM debian:trixie-slim AS fetcher
ARG NODE_VERSION
# Fetch the release tarball
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates
RUN curl -fsSL -o /tmp/node.tar.gz \
      "https://github.com/IntersectMBO/cardano-node/releases/download/${NODE_VERSION}/cardano-node-${NODE_VERSION}-linux-amd64.tar.gz"
# Unpack it
RUN mkdir -p /tmp/node && tar -xzf /tmp/node.tar.gz -C /tmp/node
# Copy the binaries
RUN install -m0755 /tmp/node/bin/cardano-node /usr/bin/cardano-node && \
  install -m0755 /tmp/node/bin/cardano-cli /usr/bin/cardano-cli

FROM debian:trixie-slim
COPY --from=fetcher /usr/bin/cardano-node /usr/bin/cardano-cli /usr/bin/
# Create a fixed cardano user (uid/gid 10000) to expose the node socket
RUN groupadd --system --gid 10000 cardano && \
    useradd --system --uid 10000 --gid 10000 \
      --home-dir /var/lib/cardano --shell /usr/sbin/nologin cardano
# Create runtime directories
RUN install -d -o cardano -g cardano /var/lib/cardano /run/cardano
# Copy network configs
COPY --from=conf /etc/cardano /etc/cardano
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

USER cardano
EXPOSE 3001
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
