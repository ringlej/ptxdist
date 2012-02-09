#!/bin/sh

# configure NM to regard already configured interfaces as unmanaged (for NFS root)

CONFFILE=/var/run/NetworkManager.conf

if [ ! -f $CONFFILE ]; then
	# set previously enabled interfaces to unmanaged
	cat /etc/NetworkManager/NetworkManager.conf > $CONFFILE

	UNMANAGED=""
	for IF in $(ls /sys/class/net); do
		IF_FLAGS="$(cat /sys/class/net/$IF/flags)"
		if [ "$((IF_FLAGS&1))" = "1" -a "$IF" != "lo" ]; then
			IF_ADDR="$(cat /sys/class/net/$IF/address)"
			UNMANAGED="$UNMANAGED;mac:$IF_ADDR"
		fi
	done

	echo "" >> $CONFFILE
	echo "[keyfile]" >> $CONFFILE
	echo "# unmanaged-devices added by $0" >> $CONFFILE
	echo "unmanaged-devices=${UNMANAGED:1}" >> $CONFFILE
fi

