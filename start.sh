#!/bin/sh

mkdir -p /var/run/dbus
shairport-sync -a "$AIRPLAY_NAME" -- -d hw:$OUTPUT_ID -c "$OUTPUT_NAME"
