#!/bin/bash
# if [ "$BASH" != "/bin/bash" ] ; then echo "Bash Only"; exit 1; fi
AWS_PROFILES=""
AWS_ACCESS_KEY=""
AWS_SECRET_KEY=""
AWS_REGION=""
PROJECTDIR="$( cd "$( dirname "$( dirname "${BASH_SOURCE[0]}" )" )" && pwd )"
DOCKER_CONF="${PROJECTDIR}/grafana/conf.ini"
. ${PROJECTDIR}/util/util.sh
MACHINE=$(get_os_name)

docker build -t grafana:latest-with-plugins \
  --build-arg "GRAFANA_VERSION=latest" \
  --build-arg "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource" ./grafana/.

if [ -z "$AWS_PROFILES"]; then
    if [[ "$MACHINE" == "Linux" ]]; then
        echo "docker run for linux"
        docker run \
        -d \
        -p 3000:3000 \
        --net=dockernet \
        --name=grafana \
        -v $DOCKER_CONF:/etc/grafana/grafana.ini \
        grafana:latest-with-plugins
    elif [[ "$MACHINE" == "Mac" ]]; then
        echo "docker run for mac"
        docker run \
        -d \
        -p 3000:3000 \
        --add-host=dockerhost:$LOOPBACK_ALIAS \
        --name=grafana \
        -v $DOCKER_CONF:/etc/grafana/grafana.ini \
        grafana:latest-with-plugins
    else
        echo "Unknown machine"
    fi
else
    if [[ "$MACHINE" == "Linux" ]]; then
        echo "docker run for linux"
        docker run \
        -d \
        -p 3000:3000 \
        --name=grafana \
        --net=dockernet \
        -e "GF_AWS_PROFILES=$AWS_PROFILES" \
        -e "GF_AWS_default_ACCESS_KEY_ID=$AWS_ACCESS_KEY" \
        -e "GF_AWS_default_SECRET_ACCESS_KEY=$AWS_SECRET_KEY" \
        -e "GF_AWS_default_REGION=$AWS_REGION" \
        -v $DOCKER_CONF:/etc/grafana/grafana.ini \
        grafana:latest-with-plugins
    elif [[ "$MACHINE" == "Mac" ]]; then
        echo "docker run for mac"
        docker run \
        -d \
        -p 3000:3000 \
        --name=grafana \
        --add-host=dockerhost:$LOOPBACK_ALIAS \
        -e "GF_AWS_PROFILES=$AWS_PROFILES" \
        -e "GF_AWS_default_ACCESS_KEY_ID=$AWS_ACCESS_KEY" \
        -e "GF_AWS_default_SECRET_ACCESS_KEY=$AWS_SECRET_KEY" \
        -e "GF_AWS_default_REGION=$AWS_REGION" \
        -v $DOCKER_CONF:/etc/grafana/grafana.ini \
        grafana:latest-with-plugins
    else
        echo "Unknown machine"
    fi
fi