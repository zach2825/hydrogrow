#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Error: No device provided. Please provide device as a parameter."
    exit 1
fi

CURR_DIRECTORY=$(pwd)
DEVICE=$1
echo "Device: $DEVICE"

echo "Checking if ampy is installed..."
# Check if ampy is installed
if ! command -v ampy >/dev/null 2>&1; then
    echo "The ampy command is required but it's not installed. Please install it with 'pip install adafruit-ampy'."
    exit 1
fi

# Libraries to check and upload if not found
LIBS=("umqtt")

# Check if the /lib directory exists on the ESP8266, if not, create it
if ! ampy -p "/dev/$DEVICE" ls /lib >/dev/null 2>&1; then
    echo "Creating libs directory on device..."
    ampy -p "/dev/$DEVICE"  mkdir /lib
fi

for LIB in "${LIBS[@]}"
do
    # Check if the library is already on the ESP8266
    if ! ampy -p "/dev/$DEVICE" ls /lib | grep -q "$LIB"; then
        echo "$LIB not found on ESP8266. Uploading..."
        ampy -p "/dev/$DEVICE" put "$CURR_DIRECTORY/libs/$LIB" "/lib/$LIB"
    fi
done

echo "Uploading config code to ESP8266..."
# Upload the config file
ampy -p "/dev/$DEVICE" put config.py

echo "Uploading main.py code to ESP8266..."
# Upload the main script
ampy -p "/dev/$DEVICE" put main.py
