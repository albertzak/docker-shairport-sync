#!/bin/sh

set -e

echo "--> Starting dbus-daemon"
rm /var/run/dbus/pid || true
/usr/bin/dbus-daemon --system

# Set host-name and enable-dbus
sed -i -e "s@#enable-dbus=yes@enable-dbus=yes@" -e "s@#host-name=foo@host-name=$(echo $RESIN_DEVICE_UUID | cut -c1-7)@" /etc/avahi/avahi-daemon.conf

# Restart service
echo "--> Stopping avahi-daemon"
systemctl stop avahi-daemon

echo "--> Starting avahi-daemon"
avahi-daemon --no-drop-root --daemonize

sleep 1s

echo "--> Starting shairport-sync"
shairport-sync -a "$AIRPLAY_NAME" -- -d hw:$OUTPUT_ID
