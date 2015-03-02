#!/usr/bin/env sh

# Get the container ip
HOSTIP=`ifconfig eth0 | grep "inet addr" | awk '{print $2}' | cut -d ':' -f 2`
echo "This container has ip ${HOSTIP} on dev eth0"

if [[ $# -gt 1 ]]; then
	exec /opt/etcd-server/bin/etcd $@
else
	exec /opt/etcd-server/bin/etcd  -name etcd0 \
		-advertise-client-urls http://${HOSTIP}:2379,http://${HOSTIP}:4001 \
		-listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
		-initial-advertise-peer-urls http://${HOSTIP}:2380 \
		-listen-peer-urls http://0.0.0.0:2380 \
		-initial-cluster-token etcd-cluster-1 \
		-initial-cluster etcd0=http://${HOSTIP}:2380 \
		-initial-cluster-state new
fi
