#!/bin/sh
# ptx initialize permissions

PERM_UNCONFIGURED="/etc/ptx_permissions.unconfigured"
PERM_CONFIGURED="/etc/ptx_permissions"

die(){
echo "nothing to do"
exit
}

fixperms(){
 mount -o remount,rw /

 while read file owner perms; do {
 chown $owner $file
 chmod $perms $file
 } 
 done < $PERM_UNCONFIGURED
 
 mv $PERM_UNCONFIGURED $PERM_CONFIGURED;
 mount -o remount,ro /
 echo "done"
}

echo -n "checking owner / permissions ... "
if [ -f $PERM_UNCONFIGURED ]; then 
    fixperms
else
    die
fi
