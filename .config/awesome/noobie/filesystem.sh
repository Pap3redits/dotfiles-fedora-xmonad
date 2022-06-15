#! /bin/bash

ICON="server"
hdd="$(df -h | awk 'NR==4{print $3, $5}')"

echo "{ \"widget\": { \"icon\": \"$ICON\", \"text\": \"$hdd\"}}"
