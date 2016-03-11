#!/bin/sh

mkdir -p /var/run/dbus

# Set host-name and enable-dbus
sed -i -e "s@#enable-dbus=yes@enable-dbus=no@" -e "s@#host-name=foo@host-name=$(echo $RESIN_DEVICE_UUID | cut -c1-7)@" /etc/avahi/avahi-daemon.conf

# Restart service
systemctl stop avahi-daemon
avahi-daemon --daemonize

sleep 10s

shairport-sync -a "$AIRPLAY_NAME" -- -d hw:$OUTPUT_ID -c "$OUTPUT_NAME"
