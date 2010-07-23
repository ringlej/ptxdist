#!/bin/bash
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# -d DEST
#
ptxd_make_extract() {
    ptxd_make_world_init || return

    local opt

    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return 1

    while getopts "s:p:u:d:" opt; do
	case "${opt}" in
	    d)
		local dest="${OPTARG}"
		;;
	    *)
		return 1
		;;
	esac
    done

    dest="${dest:-${BUILDDIR}}"

    case "${pkg_url}" in
	file://*)
	    local thing="${pkg_url//file:\/\//}"
	    if [ -n "${packet_source}" ]; then
		ptxd_bailout "<PKG>_SOURCE must not be defined when using a file:// URL!"
	    fi
	    if [ -d "${thing}" ]; then
		echo "local directory instead of tar file, linking build dir"
		ln -sf "$(ptxd_abspath "${thing}")" "${pkg_dir}"
		return
	    elif [ -f "${thing}" ]; then
		echo
		echo "Using local archive"
		echo
		pkg_src="${thing}"
	    else
		ptxd_bailout "the URL '${pkg_url}' points to non existing directory or file."
	    fi
	    ;;
    esac

    if [ -z "${pkg_src}" ]; then
	echo
	echo "Error: empty parameter to 'extract()'"
	echo
	return 1
    fi

    if [ \! -d "${dest}" ]; then
	mkdir -p "${dest}" || return
    fi

    echo "extract: archive=${pkg_src}"
    echo "extract: dest=${dest}"

    ptxd_make_extract_archive "${pkg_src}" "${dest}"
}

export -f ptxd_make_extract
