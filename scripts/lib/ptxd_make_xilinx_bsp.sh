#!/bin/bash
#
# Copyright (C) 2011 by Stephan Linz <linz@li-pro.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# apply project files (remove old, link new)
#
ptxd_make_xilinx_bsp_apply_files()
{
    local ptx_xlbsp_dir
    local pkg_xlbsp_file
    local pkg_xlbsp_files

    if [ $# -ne 2 ]; then
	echo "xlbsp: ${pkg_xlbsp_apply}: missing arguments (<dir>,<filelist>)"
	return
    fi
    ptx_xlbsp_dir="${1}"
    pkg_xlbsp_files="${2}"

    echo "xlbsp: ${pkg_xlbsp_apply}: board '$(ptxd_print_path "${ptx_xlbsp_dir:-<none>}")'"
    pushd "${ptx_xlbsp_dir}" > /dev/null &&
    for pkg_xlbsp_file in ${pkg_xlbsp_files}; do
	echo "xlbsp: ${pkg_xlbsp_apply}: rm/ln '$(ptxd_print_path "${pkg_xlbsp_file:-<none>}")'"

	local pkg_file="$(basename "${pkg_xlbsp_file}")" &&
	ln -sf ${pkg_xlbsp_file} ${pkg_file}

    done &&
    popd > /dev/null
}
export -f ptxd_make_xilinx_bsp_apply_files

# apply Xilinx BSP for U-Boot
#
ptxd_make_xilinx_bsp_apply_uboot()
{
    local ptx_xlbsp_uboot_cfg="$(ptxd_get_ptxconf PTXCONF_U_BOOT_CONFIG)"
    local pkg_xlbsp_uboot_files="${pkg_xlbsp_dir}config.mk		\
				 ${pkg_xlbsp_dir}xparameters.h"
    local pkg_xlbsp_uboot_file
    local ptx_xlbsp_uboot_dir

    # find ptx_xlbsp_uboot_dir
    if ! ptxd_get_path "${pkg_build_dir}/board/xilinx/${ptx_xlbsp_uboot_cfg%%_config}"; then
	echo "xlbsp: ${pkg_xlbsp_apply}: no board path found"
	return
    fi
    ptx_xlbsp_uboot_dir="${ptxd_reply}"

    # apply files (remove old, link new)
    ptxd_make_xilinx_bsp_apply_files "${ptx_xlbsp_uboot_dir}" "${pkg_xlbsp_uboot_files}"
}
export -f ptxd_make_xilinx_bsp_apply_uboot

#
# apply Xilinx BSP for Linux kernel 2.6
#
ptxd_make_xilinx_bsp_apply_kernel()
{
    local ptx_xlbsp_kernel_arch="$(ptxd_get_ptxconf PTXCONF_KERNEL_ARCH_STRING)"
    local pkg_xlbsp_kernel24_files="${pkg_xlbsp_dir}auto-config.in"
    local pkg_xlbsp_kernel26_files="${pkg_xlbsp_dir}Kconfig.auto"
    local ptx_xlbsp_kernel_platform
    local pkg_xlbsp_kernel_files
    local pkg_xlbsp_kernel_file
    local ptx_xlbsp_kernel_dir

    # files and platform to use per version
    case "${pkg_pkg}" in
	linux-24*|linux-2.4*)
	    pkg_xlbsp_kernel_files=${pkg_xlbsp_kernel24_files};
	    ptx_xlbsp_kernel_platform="uclinux-auto";
	    ;;
	linux-26*|linux-2.6*)
	    pkg_xlbsp_kernel_files=${pkg_xlbsp_kernel26_files};
	    ptx_xlbsp_kernel_platform="generic";
	    ;;
	*)
	    echo "xlbsp: ${pkg_xlbsp_apply}: unsupported kernel version: ${pkg_pkg##linux-}"
	    return
	    ;;
    esac

    # find ptx_xlbsp_kernel_dir
    if ! ptxd_get_path "${pkg_build_dir}/arch/${ptx_xlbsp_kernel_arch}/platform/${ptx_xlbsp_kernel_platform}"; then
	echo "xlbsp: ${pkg_xlbsp_apply}: no board path found"
	return
    fi
    ptx_xlbsp_kernel_dir="${ptxd_reply}"

    # apply files (remove old, link new)
    ptxd_make_xilinx_bsp_apply_files "${ptx_xlbsp_kernel_dir}" "${pkg_xlbsp_kernel_files}"
}
export -f ptxd_make_xilinx_bsp_apply_kernel

#
# generic apply Xilinx BSP function
#
ptxd_make_xilinx_bsp_apply()
{
    local pkg_xlbsp_dir
    local pkg_xlbsp_apply

    ptxd_in_path PTXDIST_PATH_PLATFORMS_XLBSP || return
    pkg_xlbsp_dir="${ptxd_reply}"

    # files to use per package
    case "${pkg_pkg}" in
	u-boot*)
	    pkg_xlbsp_apply="uboot";
	    ;;
	linux*)
	    pkg_xlbsp_apply="kernel";
	    ;;
	*)
	    echo "xlbsp: unsupported package: ${pkg_pkg}"
	    return
	    ;;
    esac

    echo "pkg_xlbsp_dir:     '$(ptxd_print_path "${pkg_xlbsp_dir:-<none>}")'"
    echo "pkg_build_dir:     '$(ptxd_print_path "${pkg_build_dir:-<none>}")'"
    echo

    # apply Xilinx BSP per package if files are available
    if [ -n "${pkg_xlbsp_apply}" ]; then
	echo    "xlbsp: ${pkg_xlbsp_apply}: apply '$(ptxd_print_path "${pkg_xlbsp_dir:-<none>}")'"
	"ptxd_make_xilinx_bsp_apply_${pkg_xlbsp_apply}" || return
	echo -e "xlbsp: ${pkg_xlbsp_apply}: done\n"
    fi
}
export -f ptxd_make_xilinx_bsp_apply

#
# copy and adjust per package
#
ptxd_make_xilinx_bsp() {
    ptxd_make_world_init || return
    ptxd_make_xilinx_bsp_apply
}
export -f ptxd_make_xilinx_bsp
