docker-etcd
===========

Build a etcd server docker image with busybox (under 20MB).

# Version
etcd **v0.3.0**

    docker pull jllopis/etcd:0.3.0

This tiny image starts **etcd** with the default configuration.

# Build

## Using ansible

This will compile etcd from sources and will use it inside the container.

Install [Ansible](http://docs.ansible.com/intro_installation.html) (recommended) and run

    ansible-playbook etcd-server.yml -i hosts -e "docker_image_tag=my_user/etcd:0.3.0"

## From compiled binaries

Get the binary files:

    $ curl -L -O https://github.com/coreos/etcd/releases/download/v0.3.0/etcd-v0.3.0-linux-amd64.tar.gz
    $ tar zxvf etcd-v0.3.0-linux-amd64.tar.gz
    $ docker build -t my_user/etcd:0.3.0

# Check the resulting image with *docker*:

```bash
docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
my_user/etcd        0.3.0               846344ecbfec         4 minutes ago      19.22 MB
jllopis/redis       latest              084ebf298232        26 hours ago        502.4 MB
base                latest              f28c2cabcb3e        30 hours ago        478.3 MB
ubuntu              12.04               9cd978db300e        3 weeks ago         204.4 MB
jpetazzo/busybox    latest              0c0468ea37af        8 months ago        3.229 MB
```
# Start

To start the container execute:

    docker run -v local_fs:/opt/etcd-server/data -h {node_host_name} -name {image_name} -p 4001:4001 -p 7001:7001 jllopis/etcd:0.3.0

where:

 - ***local_fs*** is the local storage to keep data safe. If not specified it will use the container so the data will be lost upon restart.
 - ***node_hostname*** is the name that will hold the *HOSTNAME* variable inside the container. 
This is accessible to CMD so *etcd* will use it as their node name. If not specified a default name wil be used.
 - ***image_name*** is the name given to the image so you don't have to play with ids

It is also possible to map another ports on the host. Do it adding **-p local_port:container_port** to **docker run**:

    docker run -d -p 4242:4001 -v local_fs:/opt/etcd-server/data jllopis/etcd:0.3.0

# Ports
The ports used are:

 - 4001
 - 7001

Remember that if you want access from outside the container you must **explicitly** tell docker to do so by setting **-p** at image launch.

# Login
You can also login to the image

    docker run -t -i -entrypoint "/bin/sh" jllopis/etcd:0.3.0 -l

Note the _-l_ at the end. If not specified it will try to pass the default **CMD** to the shell that will die with an error.
