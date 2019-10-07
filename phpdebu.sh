#!/bin/bash
CONTAINER=`docker ps --format '{{.ID}}\t{{.Names}}' | grep _ohtweb-toolbox_1 | cut -f1`
LOCAL_IP=`hostname -I | cut -d' ' -f1`

if [ "$1" = "sdeb" ]; then
    DEBUG_PARAMS="-dzend_extension=xdebug.so\
     -dxdebug.remote_enable=1\
     -dxdebug.remote_mode=req\
     -dxdebug.remote_port=9000\
     -dxdebug.remote_host=$2\
     -dxdebug.remote_connect_back=0"

    shift
    shift
    php $DEBUG_PARAMS $@
    exit;
fi

COMMAND_LINE="./phpdebug.sh sdeb $LOCAL_IP $@"
docker exec -w/ohtmain/oht -e="PHP_IDE_CONFIG=serverName=dev.oht.local"  -e="XDEBUG_CONFIG=idekey=PHPSTORM" $CONTAINER $COMMAND_LINE