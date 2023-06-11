#!/bin/bash

for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
    (
        syspath="${sysdevpath%/dev}"
        devname="$(udevadm info -q name -p "$syspath")"
        [[ "$devname" == "tty"* ]] && echo "/dev/$devname"
    )
done
