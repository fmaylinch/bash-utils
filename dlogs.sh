#!/bin/bash
if [[ $# -lt 1 ]]; then
    echo "Arguments: <keyword-to-search> <other-args>"
    echo "Examples:"
    echo "  ./dlogs.sh java"
    echo "  ./dlogs.sh java -f --tail 10"
    return
fi
keyword=$1; shift

count=$(sudo docker ps | grep $keyword | wc -l)
if [[ "$count" != "1" ]]; then
    RED='\033[0;31m'
    RESET='\033[0m'
    printf "${RED}Expected to find 1 container with keyword '$keyword' but found $count${RESET}\n"
    exit 1
fi

container=$(sudo docker ps | grep $keyword | sed -E 's/^([a-z0-9]+) (.*)$/\1/')
sudo docker logs $container "$@"
