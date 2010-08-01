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

    if [ -z "${pkg_url}" -a -z "${pkg_src}" ]; then
	# no <PKG>_URL and no <PKG>_SOURCE -> assume the package has nothing to extract.
	return
    fi

    pkg_extract_dir="${pkg_deprecated_extract_dir:-${pkg_extract_dir}}"

    case "${pkg_url}" in
	file://*)
	    local url="${pkg_url//file:\/\//}"
	    if [ -n "${packet_source}" ]; then
		ptxd_bailout "<PKG>_SOURCE must not be defined when using a file:// URL!"
	    fi
	    if [ -d "${url}" ]; then
		echo "local directory instead of tar file, linking build dir"
		ln -sf "$(ptxd_abspath "${url}")" "${pkg_dir}"
		return
	    elif [ -f "${url}" ]; then
		echo
		echo "Using local archive"
		echo
		pkg_src="${url}"
	    else
		ptxd_bailout "the URL '${pkg_url}' points to non existing directory or file."
	    fi
	    ;;
    esac

    mkdir -p "${pkg_extract_dir}" || return

    echo "\
extract: pkg_src=$(ptxd_print_path ${pkg_src})
extract: pkg_extract_dir=$(ptxd_print_path ${pkg_extract_dir})"

    ptxd_make_extract_archive "${pkg_src}" "${pkg_extract_dir}"
}

export -f ptxd_make_world_extract
