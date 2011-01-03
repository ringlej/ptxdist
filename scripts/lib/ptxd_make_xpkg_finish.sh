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
	local map="${ptx_state_dir}/${1}.xpkg.map"
	shift

	if [ \! -e "${map}" ]; then
	    continue
	fi

	while read dep; do
	    pkg_xpkg_deps=( "${pkg_xpkg_deps[@]}" "${dep}" )
	done < "${map}"
    done
}
export -f ptxd_make_xpkg_deps



#
# function to create a generic package
#
ptxd_make_xpkg_finish() {
    ptxd_make_xpkg_init || return

    #
    # no command file -> no files to package -> exit
    #
    if [ \! -s "${pkg_xpkg_cmds}" ]; then
	rm -rf -- "${pkg_xpkg_tmp}" &&
	ptxd_pedantic "Packet '${pkg_xpkg}' is empty. not generating"
	return
    fi &&

    #
    # track "pkg name" to "xpkg filename" mapping
    #
    if [ -e "${pkg_xpkg_map}" ]; then
	sed -i -e "/^${pkg_xpkg}$/d" "${pkg_xpkg_map}" &&
	if [ -s "${pkg_xpkg_map}" ]; then
	    cat >&2 <<EOF

${PTXDIST_LOG_PROMPT}warning: more than one ipkg per package detected:

package: '${pkg_pkg}'
ipkg:    '${pkg_xpkg}' and '$(cat "${pkg_xpkg_map}")'


EOF
	fi
    fi &&
    echo "${pkg_xpkg}" >> "${pkg_xpkg_map}" || return

    #
    # license
    #
    echo -n "xpkg_finish:	collecting license (${pkg_xpkg_license}) ... "
    echo "${pkg_xpkg_license}" > "${pkg_xpkg_license_file}"
    echo "done."


    #
    # create pkg
    #
    ptxd_make_xpkg_deps &&

    echo "xpkg_finish:	creating ${pkg_xpkg_type} package ... " &&
    "ptxd_make_${pkg_xpkg_type}_finish" &&
    rm -rf "${pkg_xpkg_tmp}" || {
	local ret=$?
	echo "failed"
	return ${ret}
    }

    echo "done."


    #
    # post install
    #
    # FIXME: install ipkg rather than executing script
    if ptxd_in_path PTXDIST_PATH_RULES "${pkg_xpkg}.postinst"; then
	echo "xpkg_finish:	running postinst"
	DESTDIR="${ptx_nfsroot}" /bin/sh "${ptxd_reply}"
	DESTDIR="${ptx_nfsroot_dbg}" /bin/sh "${ptxd_reply}"
    fi

    return
}
export -f ptxd_make_xpkg_finish
