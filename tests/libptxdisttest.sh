# Library for acctest acceptance tests done by ssh access to the target
# to be sourced at beginning of tests/acctest bash script
#
# 2007-08 PTX,JFR

# needs bash

RED='\0033[1;31m'
GREEN='\0033[1;32m'
NC='\0033[0m' # No Color
ok_count=0
fail_count=0

# SSH_COMMAND='ssh -q -o StrictHostKeyChecking=no'
SSH_COMMAND='rsh'
LOGFILE="${PTXDIST_WORKSPACE}/test.log"

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
        echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} $1" >> "$LOGFILE"
        $SSH_COMMAND -l root ${PTXCONF_BOARDSETUP_TARGETIP} $1 2>> "$LOGFILE"
}


remote_compare() {
        echo "test \"\$\($SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} $1\)\" = \"$2\"" >> "$LOGFILE"
        local ret=$($SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} $1) 2>> "$LOGFILE"
        test "$ret" = "$2" 2>> "${PTXDIST_WORKSPACE}/test.log"
}

remote_assure_module() {
# this should not be used as an indicator for functionality:
# don't just check on loaded modules; rather check their indirect signs of operationality.
        echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} lsmod | grep \"^$1 \"" >> "$LOGFILE"
        local ret=$($SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} lsmod | grep "^$1 ") 2>> "$LOGFILE"
        test "${ret:0:${#1}}" = "$1" 2>> "${PTXDIST_WORKSPACE}/test.log"
}

remote_assure_process() {
        local bbtest=$($SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} ps --help 2>&1 | grep ^BusyBox) 2>> "$LOGFILE"
        if [ "${bbtest:0:7}" = "BusyBox" ]
        then
                echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} ps | grep \"$1\" | grep -v grep" >> "$LOGFILE"
                local ret=$($SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} ps | grep $1 | grep -v grep) 2>> "$LOGFILE"
                echo "$ret" | grep "$1[$ ]" 2>> "${PTXDIST_WORKSPACE}/test.log"
        else
                echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} ps axo s,comm | grep \"^S $1\"" >> "$LOGFILE"
                local ret=$($SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} ps axo s,comm | grep "^S $1") 2>> "$LOGFILE"
                test "${ret:2:${#1}}" = "$1" 2>> "${PTXDIST_WORKSPACE}/test.log"
        fi
}

remote_file() {
        case "$2" in
        'block')
                echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -b \"$1\"" >> "$LOGFILE"
                $SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -b "$1" 2>> "$LOGFILE"
                ;;
        'character')
                echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -c \"$1\"" >> "$LOGFILE"
                $SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -c "$1" 2>> "$LOGFILE"
                ;;
        'exists')
                echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -e \"$1\"" >> "$LOGFILE"
                $SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -e "$1" 2>> "$LOGFILE"
                ;;
        'executable')
                echo "$SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -x \"$1\"" >> "$LOGFILE"
                $SSH_COMMAND root@${PTXCONF_BOARDSETUP_TARGETIP} test -x "$1" 2>> "$LOGFILE"
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

