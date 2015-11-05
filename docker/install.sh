#!/bin/bash

IMAGE_NAME='bupt1987/php'
PHP_DOCKER_NAME='php'

cd $(cd `dirname $0`; pwd)

sudo docker ps -a | grep -q ${PHP_DOCKER_NAME} && ( sudo docker stop ${PHP_DOCKER_NAME} ; sudo docker rm ${PHP_DOCKER_NAME} )

build_param=''
if [[ "${@: -1}" == "reset" ]]; then
	build_param='--force-rm=true --no-cache=true'
fi

set -e

sudo docker build ${build_param} --tag ${IMAGE_NAME} .
