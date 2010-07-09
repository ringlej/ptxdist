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
#
ptxd_make_xpkg_prepare() {
    ptxd_make_xpkg_init || return

    echo "install_init:	preparing for image creation of '${pkg_xpkg}'..."

    rm -fr -- \
	"${pkg_xpkg_tmp}" \
	"${pkg_xpkg_cmds}" \
	"${pkg_xpkg_perms}" &&
    mkdir -p -- "${pkg_ipkg_control_dir}" &&
    touch "${pkg_xpkg_cmds}" || return

    #
    # replace ARCH and PACKAGE in control file
    #
    echo -e "\
install_init:	@ARCH@ -> ${PTXDIST_IPKG_ARCH_STRING}
install_init:	@PACKAGE@ -> ${pkg_xpkg}
install_init:	@VERSION@ -> ${pkg_xpkg_version}"

    ARCH="${PTXDIST_IPKG_ARCH_STRING}" \
	PACKAGE="${pkg_xpkg}" \
	VERSION="${pkg_xpkg_version}" \
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/xpkg/ipkg.control" > \
	"${pkg_ipkg_control}" || return

    local script
    for script in preinst postinst prerm postrm; do
	echo -n "install_init:	${script} "

	if ptxd_get_path "${PTXDIST_PATH_RULES//://${pkg_xpkg}.${script} }"; then
	    install -m 0755 \
		-D "${ptxd_reply}" \
		"${pkg_ipkg_control_dir}/${script}" || return

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
