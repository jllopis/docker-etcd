docker-etcd
===========

Build a etcd server docker image under 30MB. The image contain the etcd and etcdctl binaries.

# Version
etcd **v2.2.3**

    docker pull jllopis/etcd:2.2.3

This tiny image starts **etcd** with the default configuration.

# Build

Use the provided _Makefile_ to download the binaries and build the image.

    $ make image

The above command clean up the previous files if any, download the binaries from github, unpack it and build the docker image.

You can get help by running

    $ make

# Check the resulting image with *docker*:

```bash
docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
my_user/etcd        2.2.3               846344ecbfec        4 minutes ago       28.92 MB
jllopis/redis       latest              084ebf298232        26 hours ago        502.4 MB
base                latest              f28c2cabcb3e        30 hours ago        478.3 MB
ubuntu              12.04               9cd978db300e        3 weeks ago         204.4 MB
```
# Start

To start the container execute:

    docker run -v local_fs:/data -h {node_host_name} -name {image_name} -p 4001:4001 -p 7001:7001 -p 2379:2379 -p 2380:2380 jllopis/etcd:2.2.3

where:

 - ***local_fs*** is the local storage to keep data safe. If not specified it will use the container so the data will be lost upon restart.
 - ***node_hostname*** is the name that will hold the *HOSTNAME* variable inside the container.
This is accessible to CMD so *etcd* will use it as their node name. If not specified a default name will be used.
 - ***image_name*** is the name given to the image so you don't have to play with ids

It is also possible to map other ports on the host. Do it adding **-p local_port:container_port** to **docker run**:

    docker run -d -p 4242:4001 -v local_fs:/data jllopis/etcd:2.2.3

# Ports

The ports used are:

 - 2379
 - 2380
 - 4001
 - 7001

Remember that if you want access from outside the container you must **explicitly** tell docker to do so by setting **-p** at image launch.

# Login

You can not login to the image as it just contain the binaries. Should be no need to do it anyway.

# etcdctl

The command is packed with the image. Can run with:

    docker run --rm -ti -entrypoint "/etcdctl" jllopis/etcd:2.2.3 -v


