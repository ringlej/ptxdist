#!/bin/sh

if [ -f /etc/ssh/ssh_host_key ]; then
    echo "/etc/ssh/ssh_host_key already exists, skipping."
else
    /usr/bin/ssh-keygen -t rsa1 -f /etc/ssh/ssh_host_key -N ""
fi


if [ -f /etc/ssh/ssh_host_dsa_key ]; then
    echo "/etc/ssh/ssh_host_dsa_key already exists, skipping."
else
    /usr/bin/ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""
fi


if [ -f /etc/ssh/ssh_host_rsa_key ]; then
    echo "/etc/ssh/ssh_host_rsa_key already exists, skipping."
else
    /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
fi


mkdir -p /var/run/sshd
chown root.root /var/run/sshd
chmod 700 /var/run/sshd
