#!/bin/bash

if [ -z "$1" ]
then
    echo "Error: No device provided. Please provide device as a parameter."
    exit 1
fi

DEVICE=$1
echo "Device: $DEVICE"

# Check if mpfshell is installed
command -v mpfshell >/dev/null 2>&1 || { echo >&2 "The mpfshell command is required but it's not installed. Please install it with 'pip install mpfshell'."; exit 1; }

# Open a REPL session with mpfshell
mpfshell -n -c "open $DEVICE; repl"
