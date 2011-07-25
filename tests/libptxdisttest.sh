#!/bin/bash

# Library for acctest acceptance tests done by ssh/rsh access to the target
# To be sourced at beginning of tests/acctest bash script
#
# 2007-08, 2008-06 jfr@pengutronix.de

# Choose the communication method: 'ssh' or 'rsh'
SSH_COMMAND_DEFAULT='rsh'
SSH_COMMAND=${SSH_COMMAND:-${SSH_COMMAND_DEFAULT}}

LOGFILE="${PTXDIST_WORKSPACE}/test${PTXDIST_PLATFORMSUFFIX}.log"
REPORTFILE="${PTXDIST_WORKSPACE}/test${PTXDIST_PLATFORMSUFFIX}.report"
TESTRUNDIRBASE="${PTXDIST_WORKSPACE}/results/result${PTXDIST_PLATFORMSUFFIX}"
[ -d "$TESTRUNDIRBASE" ] || mkdir -p "$TESTRUNDIRBASE"


RED='\0033[1;31m'
GREEN='\0033[1;32m'
BLUE='\0033[1;34m'
NC='\0033[0m' # No Color
OKSTRING="OK"
FAILSTRING="FAILED"
ok_count=0
fail_count=0
testseq=0


datenohyphen=$(date +%Y%m%d)
lastrundir=$(find ${TESTRUNDIRBASE} -name "${datenohyphen}-*" -printf "%P\n" | sort | tail -n1)
# when empty, set to "newdate", so that the -d test below will turn out negative => testrunseq="0001"
lastrundir=${lastrundir:-"newdate"}
if [ -d "${TESTRUNDIRBASE}/${lastrundir}" ]
then  # create a new dir with testrun sequence one up
	oldtestrunseq=${lastrundir/"${datenohyphen}-"/}
	# remove leading zeros and add 1 with bc, then add leading zeros
	testrunseq=$(printf "%04d"  $(echo "$oldtestrunseq+1" | bc))
else
	testrunseq="0001"
fi
TESTRUNDIR="${TESTRUNDIRBASE}/${datenohyphen}-${testrunseq}"
mkdir -p "${TESTRUNDIR}"


reportwrite() {
	case "$1" in
	'checking')
		echo "<checking>$2</checking>" >> "$REPORTFILE"
		;;
	'remote')
		echo "<remote>$2</remote>" >> "$REPORTFILE"
		echo "[remote]" > "${TESTDIR}/cmdline"
		echo "$2" >> "${TESTDIR}/cmdline"
		;;
	'host')
		echo "<host>$2</host>" >> "$REPORTFILE"
		echo "[host]" > "${TESTDIR}/cmdline"
		echo "$2" >> "${TESTDIR}/cmdline"
		;;
	'compare')
		echo "<compare>$2</compare>" >> "$REPORTFILE"
		;;
	'boolresult')
		if [ "$2" = "true" ]; then
			echo "<result>${OKSTRING}</result>" >> "$REPORTFILE"
			echo "${OKSTRING}" > "${TESTDIR}/result"
		fi
		if [ "$2" = "false" ]; then
			echo "<result>${FAILSTRING}</result>" >> "$REPORTFILE"
			echo "${FAILSTRING}" > "${TESTDIR}/result"
		fi
		;;
	'stdout')
		echo "<stdout>" >> "$REPORTFILE"
		echo "$2" >> "$REPORTFILE"
		echo "$2" > "${TESTDIR}/stdout"
		echo "</stdout>" >> "$REPORTFILE"
		;;
	'exitstatus')
		echo "<exitstatus>$2</exitstatus>" >> "$REPORTFILE"
		echo "$2" > "${TESTDIR}/exitstatus"
		;;
	'time')
		if [ $2 = "begin" ]
		then
			echo "<starttime>$(date -u +%FT%T.%3NZ)</starttime>" >> "$REPORTFILE"
			echo "$(date -u +%FT%T.%3NZ)" > "${TESTDIR}/starttime"
		fi
		if [ $2 = "end" ]
		then
			echo "<endtime>$(date -u +%FT%T.%3NZ)</endtime>" >> "$REPORTFILE"
			echo "$(date -u +%FT%T.%3NZ)" > "${TESTDIR}/endtime"
		fi
		;;
	*)
		echo "Error: No or wrong action given in reportwrite call in $0" >> "$LOGFILE"
		false
	esac
}

report_begin() {
	echo "<report starttime=\"$(date +%FT%T.%N)\">" > "$REPORTFILE"
}

report_end() {
	echo "</report>" >> "$REPORTFILE"
	cp "$REPORTFILE" "$TESTRUNDIRBASE/test${PTXDIST_PLATFORMSUFFIX}-${datenohyphen}-${testrunseq}.report"
}

test_begin() {
	(( testseq++ ))
	local testname=${FUNCNAME[1]/"acctest_"}
	local testseqstring=$(printf "%04d" $testseq)
	echo "<test name=\"${testname}\" sequence=\"${testseqstring}\">" >> "$REPORTFILE"
	TESTDIR="${TESTRUNDIR}/${testseqstring}-$testname"
	if [ ! -e "${TESTDIR}" ]
	then
		mkdir -p "${TESTDIR}"
	else
		echo "Directory \"${TESTDIR}\" already exists. Something is going wrong." >&2
	fi
	reportwrite time begin
}

test_end() {
	reportwrite time end
	echo "</test>" >> "$REPORTFILE"
	if [ "$exit_now" = "1" ]; then exit 1; fi
}

checking() {
	printf "%-71s" "checking $1" >&2
	reportwrite checking "$1"
}

result_ok() {
	printf "%8b" "[${GREEN}  OK  ${NC}]\n" >&2
	reportwrite boolresult true
	(( ok_count++ ))
}

result_fail() {
	printf "%8b" "[${RED}FAILED${NC}]\n" >&2
	reportwrite boolresult false
	(( fail_count++ ))
}

result() {
	if [ "$?" = "0" ]; then
		result_ok
		return 0
	else
		result_fail
		if [ "$1" = "fatal" ]; then
			printf "%8b" "${RED}Fatal. Cannot continue.${NC}\n" >&2
			exit_now="1" # actually exiting is done in test_end
		fi
		return 1
	fi
}

#
# functions acting on target
#

remote() {
	case "$SSH_COMMAND" in
	'ssh')
		echo "ssh -q -o StrictHostKeyChecking=no -l root ${PTXCONF_BOARDSETUP_TARGETIP} \"$1\"" >> "$LOGFILE"
		local stdoutret=$(ssh -q -o StrictHostKeyChecking=no -l root ${PTXCONF_BOARDSETUP_TARGETIP} "$1"'; echo ret=$?') 2>> "$LOGFILE"
		;;
	'rsh')
		echo "rsh -l root ${PTXCONF_BOARDSETUP_TARGETIP} \"$1\"" >> "$LOGFILE"
		local stdoutret=$(rsh -l root ${PTXCONF_BOARDSETUP_TARGETIP} "$1"'; echo ret=$?') 2>> "$LOGFILE"
		;;
	*)
		echo "Error: No or wrong remote-shell command defined in test script $0" >> "$LOGFILE"
		false
	esac

	reportwrite remote "$1"
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
	reportwrite stdout "${stdout}${retvallinestdoutpart}"
	reportwrite exitstatus ${retvalline:4}
	return ${retvalline:4}
}

host() {
	local stdout

	echo "${1}" >> "$LOGFILE"
	reportwrite host "${1}"
	stdout=$(eval ${1}; exit ${?}) 2>>"$LOGFILE"
	local retval=${?}
	reportwrite stdout "${stdout}"
	reportwrite exitstatus ${retval}
	echo "$stdout"
	return ${retval}
}



remote_compare() {
	echo "test \"\$\(remote \"$1\"\)\" = \"$2\"" >> "$LOGFILE"
	local ret=$(remote "$1") 2>> "$LOGFILE"
	reportwrite compare "$2"
	test "$ret" = "$2" 2>> "$LOGFILE"
}

remote_assure_module() {
# This should not be used as an indicator for functionality:
# Don't just check on loaded modules; rather check their indirect signs of operationality.
	echo "remote \"lsmod | grep \\\"^$1 \\\"\"" >> "$LOGFILE"
	local ret=$(remote "lsmod | grep \"^$1 \"") 2>> "$LOGFILE"
	test "${ret:0:${#1}}" = "$1" 2>> "$LOGFILE"
}

remote_busyboxps() {
	if [ -z $BUSYBOX ]
	then
		local bbtest=$(remote "ps --help 2>&1 | grep ^BusyBox") 2>> "$LOGFILE"
		test "${bbtest:0:7}" = "BusyBox"
		BUSYBOX=$?
	fi
	return $BUSYBOX
}

remote_assure_process() {
	if remote_busyboxps
	then
		#put brackets around the first char of search string, so grep won't hit its own pid
		local lookfor="[${1:0:1}]${1:1}"
		echo "remote \"ps | grep $lookfor\"" >> "$LOGFILE"
		local ret=$(remote "ps | grep $lookfor") 2>> "$LOGFILE"
		echo "$ret" | grep "$1[$ ]" 2>> "$LOGFILE"
	else
		echo "remote \"ps axo s,comm | grep \\\"^S $1\\\"\"" >> "$LOGFILE"
		local ret=$(remote "ps axo s,comm | grep \"^S $1\"") 2>> "$LOGFILE"
		test "${ret:2:${#1}}" = "$1" 2>> "$LOGFILE"
	fi
}

remote_file() {
	case "$2" in
	'block')
		echo "remote \"test -b $1\"" >> "$LOGFILE"
		remote "test -b \"$1\"" 2>> "$LOGFILE"
		;;
	'character')
		echo "remote \"test -c $1\"" >> "$LOGFILE"
		remote "test -c \"$1\"" 2>> "$LOGFILE"
		;;
	'exists')
		echo "remote \"test -e $1\"" >> "$LOGFILE"
		remote "test -e \"$1\"" 2>> "$LOGFILE"
		;;
	'executable')
		echo "remote \"test -x $1\"" >> "$LOGFILE"
		remote "test -x \"$1\"" 2>> "$LOGFILE"
		;;
	*)
		echo "Syntax error in test script $0" >> "$LOGFILE"
		false
	esac
}

all_on_board() {
	if test "$SSH_COMMAND" = "rsh"
	then
		test_begin
		checking "for local real rsh availability"
		# not all 'rsh' of this world starting a sentence with lower case
		rsh 2>&1 | grep -q "sage: rsh"
		result fatal
		test_end
	fi
	if test "$SSH_COMMAND" = "ssh"
	then
		test_begin
		checking "for local ssh availability"
		ssh 2>&1 | grep -q "usage: ssh"
		result fatal
		test_end
	fi
	test_begin
	checking "for grep on target"
	remote_file "/bin/grep" executable 2>> "$LOGFILE"
	result fatal
	test_end
	test_begin
	checking "for regular ps on target"
	remote 'ps --help | grep -q "^-o"' 2>> "$LOGFILE"
	result fatal
	test_end
}

write_to_log() {
	echo "$1" >> "$LOGFILE"
}
