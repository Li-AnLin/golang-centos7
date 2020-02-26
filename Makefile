include .env

KEY_FILE=`cat ~/.ssh/id_rsa`
HOST_FILE=`cat ~/.ssh/id_rsa.pub`

image:	## build docker image
	docker build -t test --build-arg key_file="$(KEY_FILE)" --build-arg host_file="$(HOST_FILE)" --squash .