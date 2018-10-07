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
# the actual opkg package creation, will run in fakeroot
#
ptxd_make_xpkg_finish_impl() {
    chown -R 0:0 "${pkg_xpkg_tmp}" "${pkg_xpkg_dbg_tmp}" &&
    ptxd_make_xpkg_pkg "${pkg_xpkg_tmp}" "${pkg_xpkg_dbg_tmp}" "${pkg_xpkg_cmds}" "${pkg_xpkg_perms}" &&
    opkg-build ${ptx_xpkg_extra_args} "${pkg_xpkg_tmp}" "${ptx_pkg_dir}"
    if [ "$(find "${pkg_xpkg_dbg_tmp}" -type f | wc -l)" -gt 1 ]; then
	# more than just the control file
	opkg-build ${ptx_xpkg_extra_args} "${pkg_xpkg_dbg_tmp}" "${ptx_pkg_dir}"
    fi
}
export -f ptxd_make_xpkg_finish_impl

#
# run the actual package creation in fakeroot
#
ptxd_make_xpkg_finish_run() {
    local -a fake_args
    if [ -f "${pkg_fake_env}" ]; then
	fake_args=( "-i" "${pkg_fake_env}" )
    fi
    fake_args[${#fake_args[@]}]="-u"

    export ${!pkg_*} ${!ptx_*}
    fakeroot "${fake_args[@]}" -- "ptxd_make_xpkg_finish_impl"
}
export -f ptxd_make_xpkg_finish_run

#
# function to create a generic package
#
ptxd_make_xpkg_finish() {
    ptxd_make_xpkg_init || return

    #
    # no command file -> no files to package -> exit
    #
    if [ \! -s "${pkg_xpkg_cmds}" ]; then
	rm -rf -- "${pkg_xpkg_tmp}" "${pkg_xpkg_dbg_tmp}" &&
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
ipkg:    '${pkg_xpkg}' and '$(< "${pkg_xpkg_map}")'


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
    # add pre-/postinst runs to the command list
    # make sure we replace in preinst first
    #
    (
	grep ptxd_install_script_replace < "${pkg_xpkg_cmds}"
	echo "ptxd_install_run preinst"
	grep -v ptxd_install_script_replace < "${pkg_xpkg_cmds}"
	echo "ptxd_install_run postinst"
    ) > "${pkg_xpkg_cmds}.tmp"
    mv "${pkg_xpkg_cmds}.tmp" "${pkg_xpkg_cmds}"

    #
    # create pkg
    #
    echo -e "xpkg_finish:	creating opkg package ...\n" &&
    ptxd_make_xpkg_finish_run &&
    rm -rf -- "${pkg_xpkg_tmp}" "${pkg_xpkg_dbg_tmp}" || {
	local ret=$?
	echo -e "\nxpkg_finish: failed.\n"
	return ${ret}
    }
    rm -f ${PTXDIST_TEMPDIR}/${pkg_stamp}.${pkg_xpkg}
    echo -e "\nxpkg_finish: done.\n"
}
export -f ptxd_make_xpkg_finish
