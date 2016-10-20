#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# get stuff
#
ptxd_make_world_get() {
    ptxd_make_world_init &&

    case "${pkg_url}" in
	file://*)
	    if [ -n "${pkg_src}" ]; then
		ptxd_bailout "<PKG>_SOURCE must not be defined when using a file:// URL!"
	    fi
	    ;;
    esac

    if [ -n "${pkg_src}" -a \( \! -e "${pkg_src}" -o "${ptxd_make_get_dryrun}" = "y" \) ]; then
	ptxd_make_get "${pkg_src}" "${pkg_url}"
    fi
}
export -f ptxd_make_world_get
