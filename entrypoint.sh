#!/bin/sh -e

if [ -n "$AUTHORIZED_KEY" ]; then
    echo $AUTHORIZED_KEY >> /root/.ssh/authorized_keys
    # echo $AUTHORIZED_KEY >> /home/tunnel/.ssh/authorized_keys
    /usr/sbin/sshd -D
else
    echo "Environment variable AUTHORIZED_KEY is missing"
    exit 1
fi
