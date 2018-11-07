#/bin/bash
ONLPSTDY_CONTAINER=`docker ps -a | grep ONLPSTDY | awk '{print $1}'`
if [ "${ONLPSTDY_CONTAINER}" == "" ];then
    # do not have docker image, pull it.
    USERNAME=`whoami`
    PWD=`pwd`
    docker run --privileged -i -t -e DOCKER_IMAGE=opennetworklinux/builder8:1.9 --name ONLPSTDY -v /lib/modules:/lib/modules -v ${PWD}:${PWD} -e USER=${USERNAME} --net host -w ${PWD} -e HOME=${PWD} -v ${PWD}:${PWD} opennetworklinux/builder8:1.9 /bin/docker_shell --user ${USERNAME}:1000 -c bash
else
    # into exist docekr env.
    docker start ONLPSTDY;docker attach ONLPSTDY
fi
