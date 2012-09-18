#!/bin/bash
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_nfsd_exec() {
    local port
    local root="/$(basename "${ptx_nfsroot}")"
    local base="$(dirname "${ptx_nfsroot}")"

    if ! port="$(ptxd_get_kconfig "${PTXDIST_BOARDSETUP}" "PTXCONF_BOARDSETUP_NFSPORT")"; then
	port=2049
    fi

    echo
    echo "Mount rootfs with nfsroot=${root},v3,tcp,port=${port},mountport=${port}"
    echo

    echo "/ (rw,no_root_squash)" > "${PTXDIST_TEMPDIR}/exports" &&
    UNFS_BASE="${base}" unfsd -e "${PTXDIST_TEMPDIR}/exports" -n ${port} -m ${port} -p -d
}
export -f ptxd_make_nfsd_exec

ptxd_make_nfsd() {
    ptxd_make_image_init &&
    ptxd_get_ipkg_files ${image_pkgs_selected_target} &&

    cd "${ptx_nfsroot}" &&
    {
	ptxd_dopermissions "${ptxd_reply_perm_files[@]}"
	echo ptxd_make_nfsd_exec
    } | fakeroot --
}
export -f ptxd_make_nfsd

