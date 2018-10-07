#!/bin/bash
# if [ "$BASH" != "/bin/bash" ] ; then echo "Bash Only"; exit 1; fi
PROJECTDIR="$( cd "$( dirname "$( dirname "${BASH_SOURCE[0]}" )" )" && pwd )"
PROM_YAML="${PROJECTDIR}/prometheus/prometheus.yml"
. ${PROJECTDIR}/util/util.sh
MACHINE=$(get_os_name)

docker build -t prometheus ./prometheus/.

if [[ "$MACHINE" == "Linux" ]]; then
    echo "docker run for linux"
    docker run -d -p 9090:9090 \
                --name prometheus \
                --net=dockernet \
                -v "$PROM_YAML":/etc/prometheus/prometheus.yml \
                prometheus
elif [[ "$MACHINE" == "Mac" ]]; then
    echo "docker run for mac"
    docker run -d -p 9090:9090 \
                --name prometheus \
                --add-host=dockerhost:$LOOPBACK_ALIAS \
                -v "$PROM_YAML":/etc/prometheus/prometheus.yml \
                prometheus
else
    echo "Unknown machine"
fi