#!/bin/bash

# Verify if compton is running
COMPTON_PID=$(pidof picom)

# If is running kill the its process
if [[ ! -z ${COMPTON_PID} ]]; then
    kill -9 ${COMPTON_PID}
fi

# Retart the nitrogen
# nitrogen --restore

feh --bg-fill $HOME/Pictures/1452371862297-1.jpg & 

# Waits to make sure that everithing was done 
sleep 1

# Starts the compton daemon
picom -b
