#!/bin/bash

# check if ampy is installed
command -v ampy >/dev/null 2>&1 || { echo >&2 "The ampy command is required but it's not installed. Please install it with 'pip install adafruit-ampy'."; exit 1; }

# check if device parameter is supplied
if [ -z "$1" ]
then
    echo "Error: No device provided. Please provide device as a parameter."
    exit 1
fi

DEVICE=$1

ampy -p "/dev/$DEVICE" put main.py
