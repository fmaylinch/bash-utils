#!/bin/bash
if [[ $# -lt 1 ]]; then
    echo "Arguments: <keyword-to-search> <other-args>"
    echo "Example:"
    echo "  ./dflogs.sh java"
    return
fi
keyword=$1; shift

./dlogs.sh "$keyword" -f --tail 10 "$@"
