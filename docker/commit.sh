#!/bin/bash
#提交本地image到私有库
function docker_commit() {
	DOCKER_NAME=$1
	IMAGE_NAME=$2
	IMAGE_TAG=$3

	IMAGE_NAME_TAG=${IMAGE_NAME}':'${IMAGE_TAG}

	sudo docker stop ${DOCKER_NAME}

	DATE=`date --date='TZ="Asia/Shanghai" now' +'%Y-%m-%d %H:%M:%S'`

	sudo docker commit -a 'bupt1987@gmail.com' -m "$DATE" ${DOCKER_NAME} ${IMAGE_NAME_TAG}

	set -x

	sudo docker tag -f ${IMAGE_NAME_TAG} ${IMAGE_NAME_TAG}
	sudo docker push ${IMAGE_NAME_TAG}

}

if [ ! -n "$1" ] ;then
	echo 'please input tag version, for example: commit.sh latest'
	exit
fi

sudo docker login

docker_commit 'bupt1987-php' 'bupt1987/php' $1
