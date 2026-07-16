# syntax=docker/dockerfile:1
# cardano-conf: Baked-in Cardano configs, fetched from https://book.play.dev.cardano.org/.
# Includes mainnet, preprod and preview networks.
ARG PLAYGROUND_COMMIT=e18bf6327fa9956c907739d049e9b3ec0c6a7dd6

FROM alpine:3 AS fetcher
ARG PLAYGROUND_COMMIT
RUN apk add --no-cache curl tar
# Fetch cardano-playground source tarball
RUN curl -fsSL -o /tmp/playground.tar.gz \
      "https://github.com/input-output-hk/cardano-playground/archive/${PLAYGROUND_COMMIT}.tar.gz"
# Unpack it
RUN tar -xzf /tmp/playground.tar.gz -C /tmp
# Extract each network to /etc/cardano/
ENV ENVIRONMENTS_DIR=/tmp/cardano-playground-${PLAYGROUND_COMMIT}/static/book.play.dev.cardano.org/environments
RUN install -d /etc/cardano/mainnet && cp "${ENVIRONMENTS_DIR}/mainnet/"* /etc/cardano/mainnet/
RUN install -d /etc/cardano/preprod && cp "${ENVIRONMENTS_DIR}/preprod/"* /etc/cardano/preprod/
RUN install -d /etc/cardano/preview && cp "${ENVIRONMENTS_DIR}/preview/"* /etc/cardano/preview/

FROM busybox:stable
COPY --from=fetcher /etc/cardano /etc/cardano
# To initialize custom configs: 
#
#     docker run --rm cardano-conf | tar -C ./config -x
CMD ["tar", "-c", "-C", "/etc/cardano", "."]
