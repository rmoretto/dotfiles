#!/bin/bash

NOTIFICATION_READ=$(notifdctl get-notifications-read | jq ".data.notifications_read")

if [[ "${NOTIFICATION_READ}" == "true" ]]
then
    echo "󰍩"
else
    echo "%{F#e6c384}󰍩%{F-}"
fi
