#!/bin/bash

set -e

if [[ $# -lt 1 ]]; then
    echo "Arguments: <keyword-to-search> <other-args>"
    echo "Examples:"
    echo "  ./dlogs.sh java"
    echo "  ./dlogs.sh java -f --tail 10"
    return
fi
keyword=$1; shift

container=$(./container.sh $keyword)
sudo docker logs $container "$@"
