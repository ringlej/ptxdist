#!/bin/bash
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# try to update the md5sum of the current package
# this only works if the makefile contains a "<PKG>_MD5 := ..." line.
#
ptxd_make_world_update_md5() {
    local PKG="$(ptxd_name_to_NAME "${pkg_label}")"
    set -- $(md5sum "${pkg_src}")
    local md5="${1}"

    local PKG_MD5="PTXCONF_${PKG}_MD5"
    for conf in "${PTXDIST_PLATFORMCONFIG}" "${PTXDIST_PTXCONFIG}"; do
	conf="$(readlink -f "${conf}")"
	if [ $(grep "^${PKG_MD5}=\"" "${conf}" 2> /dev/null | wc -l) = 1 ]; then
	    sed -i "s/^${PKG_MD5}=\".*$/${PKG_MD5}=\"${md5}\"/" "${conf}"
	    ptxd_warning "New checksum for ${pkg_label}: ${md5} in $(ptxd_print_path "${conf}")"
	    return
	fi
    done
    if [ -z "${pkg_makefile}" ]; then
	ptxd_bailout "Could not update md5sum for '${pkg_label}': makefile not found"
    fi
    local count=$(grep "^${PKG}_MD5[ 	]*:=" "${pkg_makefile}" 2> /dev/null | wc -l)
    if [ "${count}" -gt 1 ]; then
	ptxd_bailout "Could not update md5sum for '${pkg_label}': ${PKG}_MD5 found ${count} times in '$(ptxd_print_path ${pkg_makefile})'."
    fi
    sed -i "s/^\(\<${PKG}_MD5[ 	]*:=\) *[a-f0-9]*\$/\1 ${md5}/" "${pkg_makefile}"
    if ! grep -q "${md5}\$" "${pkg_makefile}"; then
	ptxd_bailout "Could not update md5sum for '${pkg_label}': ${PKG}_MD5 not found"
    fi
    ptxd_warning "New checksum for ${pkg_label}: ${md5} in $(ptxd_print_path "${pkg_makefile}")"
}
export -f ptxd_make_world_update_md5

#
# verify the md5sum of the source file of the current package
#
ptxd_make_world_check_src() {
    ptxd_make_world_init &&

    if [ -z "${pkg_src}" ]; then
        return
    fi
    ptxd_make_check_src_impl "${pkg_src}" "${pkg_md5}" && return

    if [ "${PTXCONF_SETUP_CHECK}" = "update" ]; then
	ptxd_make_world_update_md5
    elif [ -z "${pkg_md5}" ]; then
	ptxd_bailout "md5sum for '${pkg_label}' (${pkg_src}) missing."
    else
	ptxd_bailout "Wrong md5sum for '${pkg_label}' (${pkg_src})"
    fi
}
export -f ptxd_make_world_check_src
