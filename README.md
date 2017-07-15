# usbreset

This tool can reset an USB port on the Raspberry Pi  
Source: http://www.gtkdb.de/index_36_2304.html

# Requirements

```
sudo apt-get install gcc
```

# Install

## Compile

```
gcc usbreset.c -o usbreset
```

## Copy

```
sudo mv usbreset /usr/local/sbin/
sudo chown root:root /usr/local/sbin/usbreset
sudo chmod 0755 /usr/local/sbin/usbreset
```

# Use

Identify your device with the following command and look for bus and device number.

```
lsusb
```

Execute the command to reset the usb port.

```
sudo usbreset /dev/bus/usb/001/006
```

# Use in a dynamic script

To make sure you reset the right usb device even if it is pliugged into another port you can use this script which will detect the correct port and reset it.

```
sudo ./reset_dynamic_port.sh SN1234
```

## Using the script with cron

In case you need to reset the port after every reboot of your system and need to restart a service afterwards you can define a cron job like this.
You may want to add a little sleep time to let your system start everything frst.

/etc/cron.d/reset_usb

```
@reboot  root   sleep 30 && <yourpath>/reset_dynamic_port.sh SN1234 && systemctl restart <Yourservice>
```