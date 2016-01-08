# VERSION          v0.2.0
# DOCKER-VERSION   v1.9.0
# AUTHOR:          Joan Llopis <jllopisg@gmail.com>
# DESCRIPTION:     etcd and etcdctl binaries
FROM scratch
MAINTAINER Joan Llopis <jllopisg@gmail.com>

EXPOSE 2380
EXPOSE 2379
EXPOSE 4001
EXPOSE 7001

VOLUME ["/data"]
VOLUME ["/certs"]

ENV ETCD_VERSION v2.2.3

COPY etcd-${ETCD_VERSION}-linux-amd64/etcd* /
COPY certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
WORKDIR /

ENTRYPOINT ["/etcd"]

# To run:
# docker run -i -p 4001:4001 -p 7001:7001 -v /tmp/etcd_data:/opt/etcd-server/data -t etcd-server:test
# To start etcd-server with command line options:
# docker run -i -p 4444:4444 -p 11111:11111 -v /tmp/etcd_data:/opt/etcd-server/data -t etcd-server:test -data-dir /opt/app/data -addr 127.0.0.1:4444 -bind-addr 0.0.0.0:4444 -peer-addr 127.0.0.1:11111 -peer-bind-addr 0.0.0.0:11111
