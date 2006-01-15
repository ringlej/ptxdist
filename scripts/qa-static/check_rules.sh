#!/bin/bash

. $(dirname $0)/.config || { echo "failed to load config" ; exit ; }


Check_KConfig_Defs(){
	ident="Check_KConfig_Defs"
	description="check for broken KConfig Variables in Rules"
	cd $PTXDIST_TOPDIR/rules/
	MESSAGE=$(wcgrep ifdef |grep -v PTXCONF | grep -v NATIVE)
	show_message "$ident" "$description" "$MESSAGE"
}

echo "Running Checks on PTXdist rule definitions"
Check_KConfig_Defs
