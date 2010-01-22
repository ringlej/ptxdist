#!/bin/bash
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# create an ipkg package
#
ptxd_make_ipkg_finish() {
    local dep

    # replace space with ", "
    dep="${pkg_xpkg_deps[*]}"
    dep="${dep// /, }"

    sed -i -e "s:@DEPENDS@:${dep}:g" "${pkg_ipkg_control}" || return

    {
	echo "pushd '${pkg_ipkg_tmp}' >/dev/null &&" &&
	ptxd_dopermissions "${pkg_xpkg_perms}" &&
	echo "popd >/dev/null &&" &&
	echo "ipkg-build ${pkg_ipkg_extra_args} '${pkg_ipkg_tmp}' '${ptx_pkg_dir}' >/dev/null"
    } | fakeroot -- &&
    check_pipe_status
}
export -f ptxd_make_ipkg_finish
