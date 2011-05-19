#!/bin/bash
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# ptxd_make_image_extract_ipkg_files - extract ipkg for later image generation
#
# in:
# - $image_work_dir		directory where ipkg are extracted
# - $image_permissions		name of file that should contain all permissions
# - $image_pkgs_selected_target	space seperated list of selected
#				packages
# - $PTXDIST_IPKG_ARCH_STRING	ARCH variable for ipkg files
#
# out:
# - $image_permissions		file containing all permissions
#
ptxd_make_image_extract_xpkg_files() {
    # FIXME: consolidate "ptxd_install_setup_src"
    local src="/etc/ipkg.conf"
    local xpkg_conf="${PTXDIST_TEMPDIR}/${FUNCNAME}_xpkg.conf"
    local -a list ptxd_reply
    if ptxd_get_ptxconf "PTXCONF_HOST_PACKAGE_MANAGEMENT_OPKG" > /dev/null; then
	echo "option force_postinstall 1" > "${xpkg_conf}"
	src="/etc/opkg/opkg.conf"
    else
	src="/etc/ipkg.conf"
    fi
    list=( \
	"${PTXDIST_WORKSPACE}/projectroot${PTXDIST_PLATFORMSUFFIX}${src}" \
	"${PTXDIST_WORKSPACE}/projectroot${src}${PTXDIST_PLATFORMSUFFIX}" \
	"${PTXDIST_WORKSPACE}/projectroot${src}" \
	"${PTXDIST_TOPDIR}/generic${src}" \
	)

    if ! ptxd_get_path "${list[@]}"; then
	local IFS="
"
	ptxd_bailout "
unable to find '${src}'

These location have been searched:
${list[*]}
"
    fi

    rm -rf "${image_work_dir}" &&
    mkdir -p "${image_work_dir}" &&

    ARCH="${PTXDIST_IPKG_ARCH_STRING}" \
    SRC="" \
	ptxd_replace_magic "${ptxd_reply}" >> "${xpkg_conf}" &&

    DESTDIR="${image_work_dir}" \
	fakeroot -- ${image_xpkg_type}-cl -f "${xpkg_conf}" -o "${image_work_dir}" \
	install "${ptxd_reply_ipkg_files[@]}" &&
    if ! cat "${ptxd_reply_perm_files[@]}" > "${image_permissions}"; then
	echo "${PTXDIST_LOG_PROMPT}error: failed read permission files" >&2
	return 1
    fi

    return
}
export -f ptxd_make_image_extract_xpkg_files


ptxd_make_image_prepare_work_dir() {
    ptxd_make_image_init &&
    ptxd_get_ipkg_files &&
    ptxd_make_image_extract_xpkg_files
}
export -f ptxd_make_image_prepare_work_dir
