#!/bin/bash
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# ptxd_make_world_extract
#
ptxd_make_world_extract() {
    ptxd_make_world_init || return

    pkg_extract_dir="${pkg_deprecated_extract_dir:-${pkg_extract_dir}}"

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
    echo "extract: dest=${pkg_extract_dir}"

    ptxd_make_extract_archive "${pkg_src}" "${pkg_extract_dir}"
}

export -f ptxd_make_world_extract
