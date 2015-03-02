FROM jpetazzo/busybox
MAINTAINER Joan Llopis <jllopisg@gmail.com>

ENV LC_ALL en_US.UTF-8
ENV PATH /opt/etcd-server/bin:$PATH

RUN mkdir -p /opt/etcd-server/bin ; mkdir -p /opt/etcd-server/data
ADD etcd-v2.0.4-linux-amd64/etcd /opt/etcd-server/bin/etcd
ADD run.sh /opt/etcd-server/bin/run.sh
ADD etcd-v2.0.4-linux-amd64/etcdctl /opt/etcd-server/bin/etcdctl
ADD etcd-v2.0.4-linux-amd64/etcd-migrate /opt/etcd-server/bin/etcd-migrate
ADD etcd-v2.0.4-linux-amd64/etcd-dump-logs /opt/etcd-server/bin/etcd-dump-logs

EXPOSE 4001
EXPOSE 7001

VOLUME /opt/etcd-server/data

#ENTRYPOINT ["/opt/etcd-server/bin/etcd"]
ENTRYPOINT ["/opt/etcd-server/bin/run.sh"]

# To run:
# docker run -i -p 4001:4001 -p 7001:7001 -v /tmp/etcd_data:/opt/etcd-server/data -t etcd-server:test
# To start etcd-server with command line options:
# docker run -i -p 4444:4444 -p 11111:11111 -v /tmp/etcd_data:/opt/etcd-server/data -t etcd-server:test -data-dir /opt/app/data -addr 127.0.0.1:4444 -bind-addr 0.0.0.0:4444 -peer-addr 127.0.0.1:11111 -peer-bind-addr 0.0.0.0:11111
