#!/bin/bash

if [ -z "$1" ]
then
    echo "Error: No device provided. Please provide device as a parameter."
    exit 1
fi

DEVICE=$1

# Check if esptool.py is installed
command -v esptool.py >/dev/null 2>&1 || { echo >&2 "The esptool.py command is required but it's not installed. Please install it with 'pip install esptool'."; exit 1; }

# Download micropython.bin if it's not present
if [ ! -f micropython.bin ]; then
    echo "micropython.bin not found. Downloading..."
    curl -L https://micropython.org/resources/firmware/esp8266-1m-20230426-v1.20.0.bin -o micropython.bin
fi

# Flash micropython.bin to the ESP8266
esptool.py --port "/dev/$DEVICE" erase_flash && esptool.py --port "/dev/$DEVICE" --baud 460800 write_flash --flash_size=detect 0 micropython.bin
