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
# run the actual package creation in fakeroot
#
ptxd_make_xpkg_finish_impl() {
    local -a fake_args
    if [ -f "${pkg_fake_env}" ]; then
	fake_args=( "-i" "${pkg_fake_env}" )
    fi
    fake_args[${#fake_args[@]}]="-u"

    export ${!pkg_*} ${!ptx_*}
    fakeroot "${fake_args[@]}" -- "ptxd_make_${pkg_xpkg_type}_finish_impl"
}
export -f ptxd_make_xpkg_finish_impl

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
    # remove old pkgs
    # note: no version here, so we remove packages with old versions too
    #
    rm -f "${ptx_pkg_dir}/${pkg_xpkg}"_*"${PTXDIST_IPKG_ARCH_STRING}.ipk"

    #
    # create pkg
    #
    echo "xpkg_finish:	creating ${pkg_xpkg_type} package ... " &&
    ptxd_make_xpkg_finish_impl &&
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
