#!/bin/bash
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# change permissions and ownership of files and create device nodes.
# the paths specified in the permissions file are prefixed with the
# current working directory.
#
# typically used to create dev nodes in a fakeroot environment in the
# imageing process
#
# $1: permissions file
#
ptxd_dopermissions() {
	gawk -f "${PTXDIST_LIB_DIR}/ptxd_lib_dopermissions.awk" "${@}"
}
export -f ptxd_dopermissions


#
# ptxd_do_xpkg_map - do the mapping from package name to xpkg name(s)
#
# in:
# ${@}	package name(s)
#
# out:
# ${ptxd_reply[@]}	array of xpkg names
#
# return:
# 0	if xpkg names are found
# 1	if no xpkg names are found
#
# ptxd_reply (array)
#
ptxd_do_xpkg_map() {
    if [ -n "${PTXDIST_BASE_PLATFORMDIR}" ]; then
	set -- "${@/#/${ptx_state_dir}/}" "${@/#/${PTXDIST_BASE_PLATFORMDIR}/state/}"
    else
	set -- "${@/#/${ptx_state_dir}/}"
    fi
    ptxd_reply=( $(cat "${@/%/.xpkg.map}" 2>/dev/null) )

    [ ${#ptxd_reply[@]} -ne 0 ]
}
export -f ptxd_do_xpkg_map


#
# initialize variables needed for packaging
#
ptxd_make_xpkg_init() {
    if [ -z "${pkg_xpkg_type}" -o -z "${pkg_xpkg}" ]; then
	ptxd_bailout "'pkg_xpkg' or 'pkg_xpkg_type' undefined"
    fi

    #
    # sanitize pkg_xpkg name
    #
    # replace "_" by "-"
    #
    pkg_xpkg="${pkg_xpkg//_/-}"

    #
    # sanitize pkg_version
    #
    # separate (alpha|beta|gamma|rc) with "~"
    # replace "_" by "."
    # replace "-" by "+"
    #
    pkg_xpkg_version="$(sed -r 's/[~-]?(alpha|beta|gamma|rc)/~\1/g' <<< ${pkg_version} | tr '_-' '.+')"
    if [ -z ${pkg_xpkg_version} ]; then
	ptxd_bailout "${FUNCNAME}: please define <PKG>_VERSION"
    fi

    ptxd_make_world_init || return

    # license
    pkg_license="${pkg_license:-unknown}"
    pkg_xpkg_license="${pkg_xpkg_license:-${pkg_license}}"
    pkg_xpkg_license_file="${ptx_state_dir}/${pkg_xpkg}.license"

    # packaging stuff
    pkg_xpkg_install_deps="${ptx_state_dir}/${pkg_xpkg}.deps"
    pkg_xpkg_perms="${ptx_state_dir}/${pkg_xpkg}.perms"
    pkg_xpkg_cmds="${ptx_state_dir}/${pkg_xpkg}.cmds"
    pkg_xpkg_tmp="${ptx_pkg_dir}/${pkg_xpkg}.tmp"

    "ptxd_make_${pkg_xpkg_type}_init"
}
export -f ptxd_make_xpkg_init
