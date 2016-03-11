#!/bin/sh

set -e

mkdir /var/run/dbus

echo "Starting dbus-daemon"
dbus-daemon --system --fork

# Set host-name and enable-dbus
sed -i -e "s@#enable-dbus=yes@enable-dbus=yes@" -e "s@#host-name=foo@host-name=$(echo $RESIN_DEVICE_UUID | cut -c1-7)@" /etc/avahi/avahi-daemon.conf

# Restart service
echo "Stopping avahi-daemon"
systemctl stop avahi-daemon

echo "Starting avahi-daemon"
avahi-daemon --debug

sleep 5s

echo "Starting shairport-sync"
shairport-sync -a "$AIRPLAY_NAME" -- -d hw:$OUTPUT_ID -c "$OUTPUT_NAME"
