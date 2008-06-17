#!/bin/bash

# Library for acctest acceptance tests done by ssh/rsh access to the target
# To be sourced at beginning of tests/acctest bash script
#
# 2007-08, 2008-06 jfr@pengutronix.de

# Choose the communication method: 'ssh' or 'rsh'
SSH_COMMAND_DEFAULT='rsh'
SSH_COMMAND=${SSH_COMMAND:-${SSH_COMMAND_DEFAULT}}

LOGFILE="${PTXDIST_WORKSPACE}/test${PTXDIST_PLATFORMSUFFIX}.log"


RED='\0033[1;31m'
GREEN='\0033[1;32m'
NC='\0033[0m' # No Color
ok_count=0
fail_count=0

checking() {
	printf "%-71s" "checking $1" >&2
}

result_ok() {
	printf "%8b" "[${GREEN}  OK  ${NC}]\n" >&2
	(( ok_count++ ))
}

result_fail() {
	printf "%8b" "[${RED}FAILED${NC}]\n" >&2
	(( fail_count++ ))
}

result() {
	if [ "$?" = "0" ]; then
		printf "%8b" "[${GREEN}  OK  ${NC}]\n" >&2
		(( ok_count++ ))
	else
		printf "%8b" "[${RED}FAILED${NC}]\n" >&2
		(( fail_count++ ))
		if [ "$1" = "fatal" ]; then
			printf "%8b" "${RED}Fatal. Cannot continue.${NC}\n" >&2
			exit 1
		fi
	fi
}

#
# functions acting on target
#

remote() {
	case "$SSH_COMMAND" in
	'ssh')
		echo "ssh -q -o StrictHostKeyChecking=no -l root ${PTXCONF_BOARDSETUP_TARGETIP} \"$1\"" >> "$LOGFILE"
		local stdoutret=$(ssh -l root ${PTXCONF_BOARDSETUP_TARGETIP} "$1"'; echo ret=$?') 2>> "$LOGFILE"
		;;
	'rsh')
		echo "rsh -l root ${PTXCONF_BOARDSETUP_TARGETIP} \"$1\"" >> "$LOGFILE"
		local stdoutret=$(rsh -l root ${PTXCONF_BOARDSETUP_TARGETIP} "$1"'; echo ret=$?') 2>> "$LOGFILE"
		;;
	*)
		echo "Error: No or wrong remote-shell command defined in test script $0" >> "$LOGFILE"
		false
	esac


	local stdout=$(echo "$stdoutret" | head -n-1)
	local retvalline=$(echo "$stdoutret" | tail -n1)
	if [ "${retvalline:0:4}" = "ret=" ]
	then # The "ret=" is on a line of its own
		local retvallinestdoutpart=""
		local retvallineretpart=""
	else # There was no newline before "ret="
		local retvallineretpart=$(expr "$retvalline" : '.*\(ret=.*\)')
		local retvallinestdoutpart="${retvalline%$retvallineretpart}"
		retvalline="$retvallineretpart"
	fi
	echo "$stdout"
	echo -n "$retvallinestdoutpart"
	return ${retvalline:4}
}

remote_compare() {
	echo "test \"\$\(remote \"$1\"\)\" = \"$2\"" >> "$LOGFILE"
	local ret=$(remote "$1") 2>> "$LOGFILE"
	test "$ret" = "$2" 2>> "${PTXDIST_WORKSPACE}/test.log"
}

remote_assure_module() {
# This should not be used as an indicator for functionality:
# Don't just check on loaded modules; rather check their indirect signs of operationality.
	echo "remote \"lsmod | grep \\\"^$1 \\\"\"" >> "$LOGFILE"
	local ret=$(remote "lsmod | grep \"^$1 \"") 2>> "$LOGFILE"
	test "${ret:0:${#1}}" = "$1" 2>> "${PTXDIST_WORKSPACE}/test.log"
}

remote_assure_process() {
	local bbtest=$(remote "ps --help 2>&1 | grep ^BusyBox") 2>> "$LOGFILE"
	if [ "${bbtest:0:7}" = "BusyBox" ]
	then
		echo "remote \"ps | grep $1 | grep -v grep\"" >> "$LOGFILE"
		local ret=$(remote "ps | grep $1 | grep -v grep") 2>> "$LOGFILE"
		echo "$ret" | grep "$1[$ ]" 2>> "${PTXDIST_WORKSPACE}/test.log"
	else
		echo "remote \"ps axo s,comm | grep \\\"^S $1\\\"\"" >> "$LOGFILE"
		local ret=$(remote "ps axo s,comm | grep \"^S $1\"") 2>> "$LOGFILE"
		test "${ret:2:${#1}}" = "$1" 2>> "${PTXDIST_WORKSPACE}/test.log"
	fi
}

remote_file() {
	case "$2" in
	'block')
		echo "remote \"test -b $1\"" >> "$LOGFILE"
		remote "test -b $1" 2>> "$LOGFILE"
		;;
	'character')
		echo "remote \"test -c $1\"" >> "$LOGFILE"
		remote "test -c $1" 2>> "$LOGFILE"
		;;
	'exists')
		echo "remote \"test -e $1\"" >> "$LOGFILE"
		remote "test -e $1" 2>> "$LOGFILE"
		;;
	'executable')
		echo "remote \"test -x $1\"" >> "$LOGFILE"
		remote "test -x $1" 2>> "$LOGFILE"
		;;
	*)
		echo "Syntax error in test script $0" >> "$LOGFILE"
		false
	esac
}

all_on_board() {
	checking "for sed on target"
	remote_file "/bin/sed" executable
	result fatal
	checking "for grep on target"
	remote_file "/bin/grep" executable
	result fatal
	checking "for regular ps on target"
	remote 'ps --help | grep "^-o"'
	result fatal
}

write_to_log() {
	echo "$1" >> "$LOGFILE"
}

