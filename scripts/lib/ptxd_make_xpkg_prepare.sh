#!/bin/bash
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
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
#
ptxd_make_xpkg_prepare() {
    local dep
    ptxd_make_xpkg_init || return

    echo "install_init:	preparing for image creation of '${pkg_xpkg}'..."

    rm -fr -- \
	"${pkg_xpkg_tmp}" \
	"${pkg_xpkg_cmds}" \
	"${pkg_xpkg_perms}" \
	"${pkg_xpkg_install_deps}" &&
    mkdir -p -- "${pkg_xpkg_control_dir}" &&
    touch "${pkg_xpkg_cmds}" || return

    ptxd_make_xpkg_deps || return

    # replace space with ", "
    dep="${pkg_xpkg_deps[*]}"
    dep="${dep// /, }"

    #
    # replace ARCH PACKAGE, VERSION and DEPENDS in control file
    #
    echo -e "\
install_init:	@ARCH@ -> ${PTXDIST_IPKG_ARCH_STRING}
install_init:	@PACKAGE@ -> ${pkg_xpkg}
install_init:	@VERSION@ -> ${pkg_xpkg_version}
install_init:	@DEPENDS@ -> ${dep}"

    ARCH="${PTXDIST_IPKG_ARCH_STRING}" \
	PACKAGE="${pkg_xpkg}" \
	VERSION="${pkg_xpkg_version}" \
	DEPENDS="${dep}" \
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/xpkg/ipkg.control" > \
	"${pkg_xpkg_control}" || return

    local script
    for script in preinst postinst prerm postrm; do
	echo -n "install_init:	${script} "

	if ptxd_in_path PTXDIST_PATH_RULES "${pkg_xpkg}.${script}"; then
	    install -m 0755 \
		-D "${ptxd_reply}" \
		"${pkg_xpkg_control_dir}/${script}" || return

	    echo "packaging: '$(ptxd_print_path "${ptxd_reply}")'"

	    # FIXME: install ipkg rather than executing script
	    if [ "${script}" = "preinst" ]; then
		echo "install_init:	executing '${ptxd_reply}'"
		DESTDIR="${ptx_nfsroot}" /bin/sh "${ptxd_reply}"
		DESTDIR="${ptx_nfsroot_dbg}" /bin/sh "${ptxd_reply}"
	    fi
	else
	    echo "not available"
	fi
    done
}
export -f ptxd_make_xpkg_prepare
