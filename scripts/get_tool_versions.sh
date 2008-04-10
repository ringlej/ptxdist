#!/bin/bash
# check tool versions 
source .config

echo "=========================================="
echo "CROSSCHAIN CHECK"
echo "=========================================="
if [ "$PTXCONF_BUILD_CROSSCHAIN" != "y" ]; then {
echo "PATH    : $(which $PTXCONF_GNU_TARGET-gcc || echo "NOT FOUND")";
echo "Version : $($PTXCONF_GNU_TARGET-gcc -dumpversion)";
} else {
   if [ -x "$PTXCONF_SYSROOT_TARGET/bin/$PTXCONF_GNU_TARGET-gcc" ]; then {
   echo "PATH    : $PTXCONF_SYSROOT_TARGET/bin/$PTXCONF_GNU_TARGET-gcc";
   echo "Version : $($PTXCONF_SYSROOT_TARGET/bin/$PTXCONF_GNU_TARGET-gcc -dumpversion)";
   } else {
     echo "FATAL: cross-gcc ( $PTXCONF_SYSROOT_TARGET/bin/$PTXCONF_GNU_TARGET-gcc ) not found";
   } 
   fi;
} 
fi;

echo
echo "=========================================="
echo "TOOL CHECK"
echo "=========================================="

TOOL_LIST="config/get_tool_versions.config"

while read tool opts ; do {
[ "$tool" = "#" ] || cat << _EOF_

------------------------------------------
$tool:
------------------------------------------
PATH   : $(which $tool) 
Type   : $(type $tool)
Version: $($tool $opts)
_EOF_
} 
done < $TOOL_LIST;

