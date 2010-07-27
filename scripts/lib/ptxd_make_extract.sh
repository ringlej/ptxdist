#!/bin/bash
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# -d DEST
# -s PACKET_SOURCE
# -p PACKET_DIR
# -u PACKET_URL
#
ptxd_make_extract() {
    local opt

    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return 1

    while getopts "s:p:u:d:" opt; do
	case "${opt}" in
	    s)
		local packet_source="${OPTARG}"
		;;
 	    p)
		local packet_dir="${OPTARG}"
		;;
	    u)
		local packet_url="${OPTARG}"
		;;
	    d)
		local dest="${OPTARG}"
		;;
	    *)
		return 1
		;;
	esac
    done

    dest="${dest:-${BUILDDIR}}"

    case "${packet_url}" in
	file://*)
	    local thing="${packet_url//file:\/\//}"
	    if [ -n "${packet_source}" ]; then
		ptxd_bailout "<PKG>_SOURCE must not be defined when using a file:// URL!"
	    fi
	    if [ -d "${thing}" ]; then
		echo "local directory instead of tar file, linking build dir"
		ln -sf "$(ptxd_abspath "${thing}")" "${packet_dir}"
		return
	    elif [ -f "${thing}" ]; then
		echo
		echo "Using local archive"
		echo
		packet_source="${thing}"
	    else
		ptxd_bailout "the URL '${packet_url}' points to non existing directory or file."
	    fi
	    ;;
    esac

    if [ -z "${packet_source}" ]; then
	echo
	echo "Error: empty parameter to 'extract()'"
	echo
	return 1
    fi

    if [ \! -d "${dest}" ]; then
	mkdir -p "${dest}" || return
    fi

    echo "extract: archive=${packet_source}"
    echo "extract: dest=${dest}"

    ptxd_make_extract_archive "${packet_source}" "${dest}" &&
    echo "$(basename "${packet_source}")" >> "${STATEDIR}/packetlist"
}

export -f ptxd_make_extract
