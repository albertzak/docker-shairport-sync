#!/bin/sh

mkdir -p /var/run/dbus
shairport-sync -a "$AIRPLAY_NAME" -- -d hw:0 -t hardware -c "$OUTPUT_NAME"
