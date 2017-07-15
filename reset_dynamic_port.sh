#!/bin/bash
# This script need to be executed as root

DEBUG=0

if [  -z ${1+x} ]
  then
    echo "Please define the serial number of the device."
    echo "Use 'lsusb -v' and look for the 'iSerial' field."
    echo ""
    echo "Then start the script like: 'sudo ./reset_dynamic_port.sh SN1234'."
fi


# get usb port where the device is connected
USBBUS=`lsusb -v | grep -B 14 "$1" | grep "^Bus" | cut -d " "  -f 2`
USBDEV=`lsusb -v | grep -B 14 "$1" | grep "^Bus" | cut -d " "  -f 4 | sed 's/://g'`

if [ $DEBUG -eq 1 ]
  then
    echo "USBBUS: $USBBUS"
    echo "USBDEV: $USBDEV"
fi

if [[ "$USBBUS" == "" || "$USBDEV" == "" ]]
  then
    logger "USB device not found. Cannot reset usb port. Check defined serial."
    if [ $DEBUG -eq 1 ]
      then
        echo "USB device not found. Cannot reset usb port. Check defined serial."
    fi
    exit 1
fi

# reset usb port
logger "Resetting /dev/bus/usb/$USBBUS/$USBDEV now"
usbreset /dev/bus/usb/$USBBUS/$USBDEV