#!/bin/bash
# if [ "$BASH" != "/bin/bash" ] ; then echo "Bash Only"; exit 1; fi
PROJECTDIR="$( cd "$( dirname "$( dirname "${BASH_SOURCE[0]}" )" )" && pwd )"
. ${PROJECTDIR}/util/util.sh

MACHINE=$(get_os_name)
echo $MACHINE
if [ "$MACHINE" == "Linux" ]; then
    echo "Network setup for linux"
    docker network create -d bridge --subnet 192.168.0.0/24 --gateway 192.168.0.1 dockernet
elif [ "$MACHINE" == "Mac" ]; then
    echo "Network setup for Mac"
    sudo ifconfig lo0 alias $LOOPBACK_ALIAS
else
    echo "Unknown OS"
fi