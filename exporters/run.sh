#!/bin/bash
# if [ "$BASH" != "/bin/bash" ] ; then echo "Bash Only"; exit 1; fi

PROJECTDIR="$( cd "$( dirname "$( dirname "${BASH_SOURCE[0]}" )" )" && pwd )"

. ${PROJECTDIR}/util/util.sh
MACHINE=$(get_os_name)

docker build -t promexporters ./exporters/.

if [[ "$MACHINE" == "Linux" ]]; then
    echo "docker run for linux"
    docker run -d -p 9100:9100 \
                --name promexporters \
                --net="dockernet" \
                promexporters
elif [[ "$MACHINE" == "Mac" ]]; then
    echo "docker run for mac"
    docker run -d -p 9100:9100 \
                --name promexporters \
                --add-host=dockerhost:$LOOPBACK_ALIAS \
                promexporters
else
    echo "Unknown machine"
fi