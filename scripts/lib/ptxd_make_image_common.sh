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
# ptxd_get_ipkg_files - get full path to ipkgs that should be installed
#
# in:
# - $*				list of selected packages
#
# out:
# - $ptxd_reply_ipkg_files	array of ipkg files
# - $ptxd_reply_perm_files	array of permission files
#
ptxd_get_ipkg_files() {
    # map pkg_label to pkg's ipkg files
    local -a ptxd_reply
    ptxd_do_xpkg_map ${*}

    unset ptxd_reply_ipkg_files ptxd_reply_perm_files

    set -- "${ptxd_reply[@]}"
    while [ ${#} -ne 0 ]; do
	# look in "image_ipkg_repo_dirs" for ipkg files

	# FIXME: add IPKG_ARCH, pkg_version?
	local -a ipkg_files
	ipkg_files="${image_ipkg_repo_dirs[@]/%//${1}_*.ipk}"

	# take first hit
	if ptxd_get_path "${ipkg_files[@]}"; then
	    ptxd_reply_ipkg_files[${#ptxd_reply_ipkg_files[@]}]="${ptxd_reply}"
	    if [ -z "$(ptxd_get_ptxconf PTXCONF_IMAGE_INSTALL_FROM_IPKG_REPOSITORY)" ]; then
		ptxd_reply_perm_files[${#ptxd_reply_perm_files[@]}]="${ptxd_reply%/*/*}/state/${1}.perms"
	    else
		ptxd_reply_perm_files[${#ptxd_reply_perm_files[@]}]="${ptxd_reply%.ipk}.perms"
	    fi
	else
	    ptxd_bailout "\

Unable to find xpkg file for '${1}', this should not happen!
Run first 'ptxdist clean root' then 'ptxdist images' again.
"
	fi

	shift
    done
}
export -f ptxd_get_ipkg_files


#
# initialize variables needed for image creation
#
ptxd_make_image_init() {
    if [ -z "$(ptxd_get_ptxconf PTXCONF_IMAGE_INSTALL_FROM_IPKG_REPOSITORY)" ]; then
	image_ipkg_repo_dirs=( "${ptx_pkg_dir}" )
    else
	image_ipkg_repo_dirs=( "${image_repo_dist_dir}" )
    fi

    [ -n "${image_label}" ] && image_label_args='--label "${image_label}"'

    exec 2>&${PTXDIST_FD_LOGERR}
}
export -f ptxd_make_image_init
