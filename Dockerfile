FROM haskell:9.2.8-slim-buster AS builder

COPY GRANULE_* /tmp/
RUN apt-get update && \
    apt-get install -y z3 && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/granule-project/granule && \
    cd granule && \
    git reset --hard $(cat /tmp/GRANULE_COMMIT) && \
    stack install

FROM debian:buster-20240423-slim AS app
COPY --from=builder /root/.local/bin/gr* /usr/local/bin/
