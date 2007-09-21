#!/bin/bash
# -----------------------------------------------------
# Description:	Basic Script Functions
# Author: 	Bjørn Bürger <b.buerger@pengutronix.de> 
# Date:		Wed Mar 21 17:03:39 CET 2007
# -----------------------------------------------------

PTXLIB="true"
MY_VERSION="2"

if [ "$PTX_LIB_VERSION" -lt "$MY_VERSION" ] ; then
	echo "WARNING: ptxlib.bash not compatible"
	echo "WARNING: please audit your script"
	exit 1
fi

FULLARGS="$@"
DEBUG=${DEBUG:="false"}

#
# customized exit functions
#
# $1 --> Error Message
# $2 --> Exit Code
#
ptx_exit(){
	echo "$0: $1"
	exit $2
}
ptx_exit_silent(){
	ptx_debug "$0: $1"
	exit $2
}

#
# print out error message and exit with status 1
#
# $1: error message
# ${PREFIX}: to be printed before message
#
ptx_bailout () {
	echo "${PREFIX}error: $1" >&2
	exit 1
}


#
# print out warning message
#
# $1: warning message
# ${PREFIX}: to be printed before message
#
ptx_warning() {
	echo "${PREFIX}warning: $1" >&2
}

#
# print out classic message
#
# $1: warning message
# ${PREFIX}: to be printed before message
#
ptx_message() {
	echo "${PREFIX}: $1" >&1
}

ptx_message_n() {
	if [ -n "$PREFIX" ]; then
	echo -n "${PREFIX}: $1" >&1
	else
	echo -n "$1" >&1
	fi
}

#
# Debugging Output
#
ptx_debug(){
	[ "$DEBUG" = "true" ] && echo "$0: $1" >&2
}
ptx_debug "Debugging is enabled - Turn off with DEBUG=false"


#
# check if a previously executed pipe returned an error
#
ptx_check_pipe_status() {
	for i in  "${PIPESTATUS[@]}"; do [ $i -gt 0 ] && {
		echo
		echo "error: a command in the pipe returned $i, bailing out"
		echo
		exit $i
	}
	done
}

#
# present a choice [y/n] and execute command
#
# $1: question / message
# $2: command
# $3: yes message
# $4: no message
# ${PREFIX}: to be printed before message
#
#
ptx_yesno_choice(){
	ptx_debug "Message: $1"
	ptx_debug "Command: $2"
	dialog --yesno "$1" 0 0
	case $? in
		0)
		ptx_message "${PREFIX} [YES] - $3"
		$2 || ptx_error "command $2 failed"
		;;
		*)
		ptx_warning "${PREFIX} [NO]  - $4"
		;;
	esac
}

#
# create a directory 
#
ptx_check_create_dir(){
	[ -d "$1" ] || ptx_yesno_choice "$1 does not exist, create it?" "mkdir -pv $1" "[SUCCESS]" "[ABORTED]"
}

#
# dependency check for needed files
#
# if any one of these variables is
# set, a dependency check is performed:
#
# dependency_check_files_recommends
# dependency_check_files_depends
# dependency_check_files_conflicts
#
ptx_dependency_check_files(){
	[ -z "$dependency_check_files_recommends" ] && ptx_debug "[file check] no file recommendation defined"
	for file in $dependency_check_files_recommends; do
		test -e $file
		case $? in
			0)
			ptx_debug "[file check] This Script recommends $file: OK"
			;;
			*)
			ptx_warning "[file check] This Script recommends $file: FILE NOT FOUND"
			;;
		esac
	done
	[ -z "$dependency_check_files_depends" ] && ptx_debug "[file check] no file dependency defined"
	for file in $dependency_check_files_depends; do
		test -e $file
		case $? in
			0)
			ptx_debug "[file check] This Script depends on $file: OK"
			;;
			*)
			ptx_bailout "[file check] This Script depends on $file: FILE NOT FOUND"
			;;
		esac
	done
	[ -z "$dependency_check_files_conflicts" ] && ptx_debug "[file check] no file conflict defined"
	for file in $dependency_check_files_conflicts; do
		test -e $file
		case $? in
			0)
			ptx_bailout "[file check] This Script conflicts with $file: FILE EXISTS"
			;;
			*)
			ptx_debug "[file check] This Script conflicts with $file: OK (does not exist)"
			;;
		esac
	done
}

#
# dependency check for needed directories
#
# if any one of these variables is
# set, a dependency check is performed:
#
# dependency_check_dirs_recommends
# dependency_check_dirs_depends
# dependency_check_dirs_conflicts
#
ptx_dependency_check_dirs(){
	[ -z "$dependency_check_dirs_recommends" ] && ptx_debug "[dir check] no directory recommendation defined"
	for directory in $dependency_check_dirs_recommends; do
		test -d $directory
		case $? in
			0)
			ptx_debug "[dir check] This Script recommends $directory: OK"
			;;
			*)
			ptx_warning "[dir check] This Script recommends $directory: directory NOT FOUND"
			;;
		esac
	done
	[ -z "$dependency_check_dirs_depends" ] && ptx_debug "[dir check] no directory dependency defined"
	for directory in $dependency_check_dirs_depends; do
		test -d $directory
		case $? in
			0)
			ptx_debug "[dir check] This Script depends on $directory: OK"
			;;
			*)
			ptx_bailout "[dir check] This Script depends on $directory: directory NOT FOUND"
			;;
		esac
	done
	[ -z "$dependency_check_dirs_conflicts" ] && ptx_debug "[dir check] no directory conflict defined"
	for directory in $dependency_check_dirs_conflicts; do
		test -d $directory
		case $? in
			0)
			ptx_bailout "[dir check] This Script conflicts with $directory: directory EXISTS"
			;;
			*)
			ptx_debug "[dir check] This Script conflicts with $directory: OK (does not exist)"
			;;
		esac
	done
}

#
# dependency check for needed tools
#
# if any one of these variables is
# set, a dependency check is performed:
#
# dependency_check_tools_recommends
# dependency_check_tools_depends
# dependency_check_tools_conflicts
#
ptx_dependency_check_tools(){
	[ -z "$dependency_check_files_recommends" ] && ptx_debug "[file check] no tool recommendation defined"
	for tool in $dependency_check_tools_recommends; do
		which $tool >/dev/null 2>&1
		case $? in
			0)
			ptx_debug "[tool check] This Script recommends $tool: OK"
			;;
			*)
			ptx_warning "[tool check] This Script recommends $tool: MISSING"
			;;
		esac
	done
	[ -z "$dependency_check_tools_depends" ] && ptx_debug "[file check] no tool dependency defined"
	for tool in $dependency_check_tools_depends; do
		which $tool >/dev/null 2>&1
		case $? in
			0)
			ptx_debug "[tool check] This Script depends on $tool: OK"
			;;
			*)
			ptx_bailout "[tool check] This Script depends on $tool: MISSING"
			;;
		esac
	done
	[ -z "$dependency_check_tools_conflicts" ] && ptx_debug "[file check] no file conflict defined"
	for tool in $dependency_check_tools_conflicts; do
		which $tool >/dev/null 2>&1
		case $? in
			0)
			ptx_bailout "[tool check] This Script conflicts with on $tool: CONFLICT FOUND"
			;;
			*)
			ptx_debug "[tool check] This Script conflicts with $tool: OK"
			;;
		esac
	done
}

ptx_dependency_check_hostname(){
	[ -z "$dependency_check_hostname_recommends" ] && ptx_debug "[hostname check] no hostname recommendation defined"
	for hostname in $dependency_check_hostname_recommends; do
		[ "`hostname`" = "$hostname" ] >/dev/null 2>&1
		case $? in
			0)
			ptx_debug "[hostname check] This Script recommends host $hostname: OK"
			;;
			*)
			ptx_warning "[hostname check] This Script recommends host $hostname: THIS IS NOT ME"
			;;
		esac
	done
	[ -z "$dependency_check_hostname_depends" ] && ptx_debug "[hostname check] no hostname dependency defined"
	for hostname in $dependency_check_hostname_depends; do
		[ "`hostname`" = "$hostname" ] >/dev/null 2>&1
		case $? in
			0)
			ptx_debug "[hostname check] This Script depends on host $hostname: OK"
			;;
			*)
			ptx_bailout "[hostname check] This Script depends on host $hostname: THIS IS NOT ME"
			;;
		esac
	done
	[ -z "$dependency_check_hostname_conflicts" ] && ptx_debug "[hostname check] no hostname conflict defined"
	for hostname in $dependency_check_hostname_conflicts; do
		[ "`hostname`" = "$hostname" ] >/dev/null 2>&1
		case $? in
			0)
			ptx_bailout "[hostname check] This Script conflicts with host $hostname: CONFLICT FOUND"
			;;
			*)
			ptx_debug "[hostname check] This Script conflicts with host $hostname: OK"
			;;
		esac
	done
}

#
# convenience wrapper for the functions above
#
# performs all available checks
#
ptx_dependency_check(){
	ptx_dependency_check_hostname
	ptx_dependency_check_dirs
	ptx_dependency_check_files
	ptx_dependency_check_tools
}

# service specific lib functions, based on script domains:
#
# - dumb_tool
# - tool
# - development
# - system_management
#

if [ -n "$PTX_SCRIPT_DOMAINS" ]; then
for ptx_script_domain in $PTX_SCRIPT_DOMAINS; do
	ptx_debug "loading config for domain: ${ptx_script_domain}"
	SCONFS="$HOME/.ptxsd-${ptx_script_domain}.conf \
	/usr/local/etc/ptxsd-${ptx_script_domain}.conf \
	/etc/ptxsd-${ptx_script_domain}.conf \
	`dirname $0`/ptxsd-${ptx_script_domain}.conf \
	`dirname $0`/../lib/ptxsd-${ptx_script_domain}.conf"
	for scriptconf in $SCONFS; do
		if [ -e "$scriptconf" ] ; then 
			. $scriptconf && { ptx_debug "$scriptconf loaded"; break; }
		fi
	done
	[ "$PTXSD" = "true" ] || ptx_warning " No valid Configuration for Domain: ${ptx_script_domain} found \
	[ $conf (version $MY_VERSION) ] [ caller: $0 ]"
done
fi
