#!/bin/bash

TEMP=$(curl -fs "https://api.openweathermap.org/data/2.5/weather?q=Florianopolis&appid=b3e3d4fc0128761c5db3524d6c1781a1&unit=metric&units=metric" | jq .main.temp)

echo $TEMP | xargs printf "%.*f\n" "1"
