#!/bin/sh

#
# generic functions for bbinit
#

mount_root_rw() {

    touch "/.root_is_rw" > /dev/null 2>&1 && return

    echo -n "remounting root rw..."
    mount /dev/root / -n -o remount,rw > /dev/null 2>&1
    if [ "$?" -ne "0" ]; then
        echo "failed, aborting"
        return 1
    fi
    echo "done"
}

mount_root_restore() {

    rm "/.root_is_rw" > /dev/null 2>&1 && return

    echo -n "remounting root ro..."
    mount /dev/root / -n -o remount,ro > /dev/null 2>&1
    if [ "$?" -ne "0" ]; then
        echo "failed, aborting"
        return 1
    fi
    echo "done"
}

