#!/bin/bash
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

license_file="${1}"
exception_file="${2}"
output="$(dirname "$0")/lib/ptxd_make_spdx.sh"
delim='|'

if [ "${#}" -ne 2 ]; then
	echo "usage: $0 <license-file> <exception-file>"
	exit 1
fi
if [ ! -f "${license_file}" ]; then
	echo "license file missing!"
	exit 1
fi
if [ ! -f "${exception_file}" ]; then
	echo "exception file missing!"
	exit 1
fi

export IFS="${delim}"

(
    sed '/^$/q' "$0"

    cat <<EOF
#
# WARNING: This file is generated with '$(basename "${0}")' from
# '$(basename "${license_file}")' and '$(basename "${exception_file}")'.
#
# To regenerate this file export the license and exception sheets from the
# original SPDX license list using '${delim}' as field delimiter and run
# '$(basename "${0}")'.

ptxd_make_spdx() {
    license="\${1}"

    case "\${license}" in
EOF

    last=
    cols=0
    echo "parsing license file ..." >&2
    cat "${license_file}" | while read line; do
	line="${last} ${line}"
	last=
	count="$(echo "${line}" | sed "s/[^${delim}]//g" | wc -c)"
	if [ "${cols}" -eq 0 ]; then
	    cols="${count}"
	fi
	if [ "${count}" -lt "${cols}" ]; then
	    last="${line}"
	    continue
	fi
	if [ "${count}" -gt "${cols}" ]; then
	    echo "Too many columns: ${count}!" >&2
	    exit 1
	fi
	set -- ${line}
	if [ "${2}" = "License Identifier" -o -z "${2}" ]; then
	    continue
	fi
	echo -n "	${2}) "
	if [ "${5}" = "YES" ]; then
	    echo -n 'osi="true" '
	fi
	echo ";;"
    done
    last=
    cols=0
    echo "parsing exception file ..." >&2
    cat "${exception_file}" | while read line; do
	line="${last} ${line}"
	last=
	count="$(echo "${line}" | sed "s/[^${delim}]//g" | wc -c)"
	if [ "${cols}" -eq 0 ]; then
	    cols="${count}"
	fi
	if [ "${count}" -lt "${cols}" ]; then
	    last="${line}"
	    continue
	fi
	if [ "${count}" -gt "${cols}" ]; then
	    echo "Too many columns: ${count}!" >&2
	    exit 1
	fi
	set -- ${line}
	if [ "${2}" = "Exception Identifier" -o -z "${2}" ]; then
	    continue
	fi
	echo -n "	${2}) exception=\"true\" "
	echo ";;"
    done

cat <<EOF
	*) return 1 ;;
    esac
}
export -f ptxd_make_spdx
EOF
) > "${output}"
