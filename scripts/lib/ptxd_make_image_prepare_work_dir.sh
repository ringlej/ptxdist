#!/bin/bash
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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
ptxd_make_image_extract_ipkg_files() {
    # FIXME: consolidate "ptxd_install_setup_src"
    local src="/etc/ipkg.conf"
    local ipkg_conf="${PTXDIST_TEMPDIR}/${FUNCNAME}_ipkg.conf"
    local -a list ptxd_reply
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
	ptxd_replace_magic "${ptxd_reply}" > "${ipkg_conf}" &&

    DESTDIR="${image_work_dir}" \
	fakeroot -- ipkg-cl -f "${ipkg_conf}" -o "${image_work_dir}" \
	install "${ptxd_reply_ipkg_files[@]}" &&
    if ! cat "${ptxd_reply_perm_files[@]}" > "${image_permissions}"; then
	echo "${PTXDIST_LOG_PROMPT}error: failed read permission files" >&2
	return 1
    fi

    return
}
export -f ptxd_make_image_extract_ipkg_files


ptxd_make_image_prepare_work_dir() {
    ptxd_make_image_init &&
    ptxd_get_ipkg_files &&
    ptxd_make_image_extract_ipkg_files
}
export -f ptxd_make_image_prepare_work_dir
