#!/bin/bash

# Verify if compton is running
COMPTON_PID=$(pidof picom)

# If is running kill the its process
if [[ ! -z ${COMPTON_PID} ]]; then
    kill -9 ${COMPTON_PID}
fi

# Retart the nitrogen
nitrogen --restore

# Waits to make sure that everithing was done 
sleep 1

# Starts the compton daemon
picom -b
