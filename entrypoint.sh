#!/bin/bash

x11vnc -storepasswd $VNC_PASSWORD /etc/x11vnc.pass

/usr/bin/supervisord -c /supervisord.conf
