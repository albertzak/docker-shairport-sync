#!/bin/sh

set -e

echo $(ps aux | grep systemd | grep -v grep)

echo "Starting dbus-daemon"
/usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation

# Set host-name and enable-dbus
sed -i -e "s@#enable-dbus=yes@enable-dbus=yes@" -e "s@#host-name=foo@host-name=$(echo $RESIN_DEVICE_UUID | cut -c1-7)@" /etc/avahi/avahi-daemon.conf

# Restart service
echo "Stopping avahi-daemon"
systemctl stop avahi-daemon

echo "Starting avahi-daemon"
avahi-daemon --no-drop-root --debug

sleep 5s

echo "Starting shairport-sync"
shairport-sync -a "$AIRPLAY_NAME" -- -d hw:$OUTPUT_ID -c "$OUTPUT_NAME"
