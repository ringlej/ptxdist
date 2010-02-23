#!/bin/bash
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#



#
# collect dependencies
#
# in some rare cases there is more than one xpkg per package and/or
# the names don't correspond, so we have to use the mapping file
#
# in:	$pkg_deps	(space seperated)
# out:	$pkg_xpkg_deps	(array)
#
ptxd_make_xpkg_deps() {
    # do deps
    if [ -z "${pkg_deps}" ]; then
	return
    fi

    set -- ${pkg_deps[*]}

    local dep
    while [ ${#} -ne 0 ]; do
	shift

	if [ \! -e "${pkg_xpkg_map}" ]; then
	    continue
	fi

	while read dep; do
	    pkg_xpkg_deps=( "${pkg_xpkg_deps[@]}" "${dep}" )
	done < "${pkg_xpkg_map}"
    done
}
export -f ptxd_make_xpkg_deps



#
# function to create a generic package
#
ptxd_make_xpkg_finish() {
    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return

    ptxd_make_xpkg_init || return

    #
    # no perm file -> no files to package -> exit
    #
    if [ \! -f "${pkg_xpkg_perms}" ]; then
	ptxd_warning "Packet '${pkg_xpkg}' is empty. not generating"
	rm -rf -- "${pkg_xpkg_tmp}"

	sed -i -e "/^${pkg_xpkg}$/d" "${pkg_xpkg_map}"	#FIXME: we rely in 1-to-1 mapping here

	if [ \! -s "${pkg_xpkg_map}" ]; then
	    rm -f -- "${pkg_xpkg_map}"
	fi
	return
    fi


    #
    # license
    #
    echo -n "xpkg_finish:	collecting license (${pkg_xpkg_license}) ... "
    echo "${pkg_xpkg_license}" > "${pkg_xpkg_license_file}"
    echo "done."


    #
    # create pkg
    #
    local ret=0

    ptxd_make_xpkg_deps || return

    echo -n "xpkg_finish:	creating ${pkg_xpkg_type} package ... " &&
    "ptxd_make_${pkg_xpkg_type}_finish" || ret=$?
    rm -rf "${pkg_xpkg_tmp}"

    if [ $? -ne 0 -o ${ret} -ne 0 ]; then
	echo "failed."
	return 1
    else
	echo "done."
    fi

    #
    # post install
    #
    if [ -f "${PTXDIST_WORKSPACE}/rules/${pkg_xpkg}.postinst" ]; then
	echo "xpkg_finish:	running postinst"
	DESTDIR="${ROOTDIR}" /bin/sh "${PTXDIST_WORKSPACE}/rules/${pkg_xpkg}.postinst"
    elif [ -f "${PTXDIST_TOPDIR}/rules/${pkg_xpkg}.postinst" ]; then
	echo "xpkg_finish:	running postinst"
	DESTDIR="${ROOTDIR}" /bin/sh "${PTXDIST_TOPDIR}/rules/${pkg_xpkg}.postinst"
    fi

    return
}
export -f ptxd_make_xpkg_finish
