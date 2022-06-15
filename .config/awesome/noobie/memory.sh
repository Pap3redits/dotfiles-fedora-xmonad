#! /bin/bash

ICON="cpu"
mem="$(free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }')"

echo "{ \"widget\": { \"icon\": \"$ICON\", \"text\": \"$mem\"}}"
