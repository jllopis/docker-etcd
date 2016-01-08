ETCD_VERSION=2.2.3
TMPDIR="tmp/"

default:
	@echo "etcd docker image builder options:"
	@echo "\tmake download : download the binary package from github"
	@echo "\tmake image : build the image"

download:
	@echo "downloading last etcd binary"
	@curl -L  https://github.com/coreos/etcd/releases/download/v$(ETCD_VERSION)/etcd-v$(ETCD_VERSION)-linux-amd64.tar.gz -o etcd-v$(ETCD_VERSION)-linux-amd64.tar.gz
	@tar zxvf etcd-v$(ETCD_VERSION)-linux-amd64.tar.gz etcd-v$(ETCD_VERSION)-linux-amd64/etcd etcd-v$(ETCD_VERSION)-linux-amd64/etcdctl
	@mv etcd-v$(ETCD_VERSION)-linux-amd64/ $(TMPDIR)

#image: clean download
image:
	@echo "Building docker image on ${PWD} for etcd ${ETCD_VERSION}"
	docker build --no-cache -t jllopis/etcd:${ETCD_VERSION} .

clean:
	@echo "cleaning up this mess"
	@rm -vfr $(TMPDIR)
	@rm -v etcd-v$(ETCD_VERSION)-linux-amd64.tar.gz


