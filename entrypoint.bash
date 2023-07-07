#!/bin/bash

# Prepare
USER=$(whoami)
sudo service dbus start

# Must run before qtile!
sudo /usr/bin/Xtigervnc :0 -rfbport 5901 -SecurityTypes VncAuth,TLSVnc \
     -PasswordFile /opt/mps/tools/tigervnc/tiger-vnc-password.txt \
     -Log *:stderr:100 \
     -geometry 1920x1080 -desktop localhost:0 -depth 32 -auth /root/.Xauthority &

# Run
CMD=$*
if [ "$CMD" == "" ] ; then
    CMD="/home/$USER/.local/bin/qtile start"
fi
DISPLAY=:0 $CMD
