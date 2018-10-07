#!/bin/bash
# if [ "$BASH" != "/bin/bash" ] ; then echo "Bash Only"; exit 1; fi

LOOPBACK_ALIAS="172.21.111.223" 

print_task_name() {
    echo ""
    echo "---"
    echo "[$(date +"%T")] > $1"
}

echo_and_eval() {
    echo "[$(date +"%T")] $ $1"
    eval "${1}"
}

get_os_name() {
    UNAME="$(uname -s)"
    case "${UNAME}" in
        Linux*)     MACHINE=Linux;;
        Darwin*)    MACHINE=Mac;;
        CYGWIN*)    MACHINE=Cygwin;;
        MINGW*)     MACHINE=MinGw;;
        *)          MACHINE="UNKNOWN:${UNAME}"
    esac
    echo "$MACHINE"
}

set -e
