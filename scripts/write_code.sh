#!/bin/bash

if [ -z "$1" ]
then
    echo "Error: No device provided. Please provide device as a parameter."
    exit 1
fi

DEVICE=$1

# Check if ampy is installed
command -v ampy >/dev/null 2>&1 || { echo >&2 "The ampy command is required but it's not installed. Please install it with 'pip install adafruit-ampy'."; exit 1; }

# Libraries to check and upload if not found
LIBS=("umqtt")

for LIB in "${LIBS[@]}"
do
    # Check if the library is already on the ESP8266
    if ! ampy -p "/dev/$DEVICE" ls /lib | grep -q "$LIB.py"; then
        echo "$LIB.py not found on ESP8266. Uploading..."
        ampy -p "/dev/$DEVICE" put "$LIB.py" /lib/
    fi
done

# Upload the config file
ampy -p "/dev/$DEVICE" put config.py
# Upload the main script
ampy -p "/dev/$DEVICE" put main.py
