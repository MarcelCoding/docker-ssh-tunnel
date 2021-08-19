#!/bin/sh

ssh-keygen -A -f /etc/ssh/keys
chown -R tunnel:tunnel /home/tunnel
chmod 700 /home/tunnel/.ssh
chmod 600 /home/tunnel/.ssh/authorized_keys

/usr/sbin/sshd -De