FROM haskell:9.2.8-slim-buster AS builder

COPY GRANULE_* /tmp/
RUN apt-get update && \
    apt-get install -y z3 && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/granule-project/granule -b v$(cat /tmp/GRANULE_VERSION) && \
    cd granule && \
    stack install

FROM debian:bookworm-20241223 AS app
COPY --from=builder /root/.local/bin/gr* /usr/local/bin/
COPY --from=builder /opt/granule/StdLib/* /usr/local/lib/
ENV LANG=C.UTF-8
RUN apt-get update && \
    apt-get install -y z3 && \
    rm -rf /var/lib/apt/lists/*
