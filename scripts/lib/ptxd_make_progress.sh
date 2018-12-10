#!/bin/bash
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_setup_progress() {
    if [ -n "${PTXDIST_PROGRESS}" -a -n "${PTXDIST_QUIET}" ]; then
	ptxd_make_target_count=$( \
	    "${PTXCONF_SETUP_HOST_MAKE}" --dry-run \
	    -f "${RULESDIR}/other/Toplevel.make" "${@}" 2>/dev/null | \
		grep -E '^target=.*\.(get|extract|prepare|compile|install|targetinstall|report).* touch' | \
		wc -l)
	export ptxd_make_target_count
	exec {ptxd_make_target_count_start}>> "${PTXDIST_TEMPDIR}/ptxd_make_target_count_start"
	exec {ptxd_make_target_count_stop}>> "${PTXDIST_TEMPDIR}/ptxd_make_target_count_stop"
	export ptxd_make_target_count_start ptxd_make_target_count_stop
	:> "${PTXDIST_TEMPDIR}/ptxd_make_target_count"
    fi
}

ptxd_make_print_progress() {
    if [ -n "${ptxd_make_target_count}" ]; then
	local start stop len
	if [[ "${2}" =~ .*\.(get|extract|prepare|compile|install|targetinstall|report).* ]]; then
	    local ptr="ptxd_make_target_count_${1}"
	    echo -n + >&${!ptr}
	    if [ "${2}" = "world.targetinstall" ]; then
		# world.targetinstall has no 'targetinfo'
		echo -n + >&${ptxd_make_target_count_start}
	    fi
	fi
	start=$(wc -c < "${PTXDIST_TEMPDIR}/ptxd_make_target_count_start")
	stop=$(wc -c < "${PTXDIST_TEMPDIR}/ptxd_make_target_count_stop")
	len="$(wc -c <<<${ptxd_make_target_count})"
	printf "[%$[len-1]d/%d] " "${stop}" "${ptxd_make_target_count}"
    fi
}
export -f ptxd_make_print_progress
