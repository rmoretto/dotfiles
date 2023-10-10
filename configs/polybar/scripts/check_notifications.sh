#!/bin/bash

NOTIFICATION_COUNT=$(notifdctl list | jq ".data" | jq length)

if [[ ${NOTIFICATION_COUNT} -eq 0 ]]
then
    echo "󰍩"
else
    echo "%{F#e6c384}󰍩%{F-}"
fi
