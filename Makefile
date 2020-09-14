include .env

KEY_FILE=`cat ~/.ssh/id_rsa`
HOST_FILE=`cat ~/.ssh/known_hosts`
PUBKEY_FILE=`cat ~/.ssh/id_rsa.pub`

image:	## build docker image
	docker build -t $(DOCKER_REGISTRY_HOST)/golang-centos7:1.15.2 --build-arg key_file="$(KEY_FILE)" --build-arg host_file="$(HOST_FILE)" --build-arg pubkey_file="$(PUBKEY_FILE)" --squash .