#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# prepare
#
# create pkg_pkg_dir and typical subdirs if pkg_pkg_dir is defined
#
ptxd_make_world_install_prepare() {
    if [ -z "${pkg_pkg_dir}" ]; then
	return
    fi &&
    rm -rf -- "${pkg_pkg_dir}" &&
    mkdir -p -- "${pkg_pkg_dir}"/{etc,{,usr/}{lib,{,s}bin,include,{,share/}{man/man{1,2,3,4,5,6,7,8,9},misc}}}
}
export -f ptxd_make_world_install_prepare

ptxd_make_world_install_python_cleanup() {
    find "${pkg_pkg_dir}" -type f -name "*.so" -print | while read file; do
	# Python installs shared libraries with executable flags
	chmod -x "${file}"
    done &&
    find "${pkg_pkg_dir}" -type d -name bin -prune -o -name "*.py" -print | while read file; do
	if [ ! -d "$(dirname "${file}")/__pycache__" ]; then
	    # not python3 or already handled
	    continue
	fi
	cp -v "$(dirname "${file}")/__pycache__/$(basename "${file%py}")"cpython-??.pyc "${file}c" || return
    done &&
    check_pipe_status &&
    find "${pkg_pkg_dir}" -type d -name __pycache__  -print0 | xargs -0 rm -rf &&
    check_pipe_status ||
    ptxd_bailout "Cache cleanup for Python3 packages failed!"
}
export -f ptxd_make_world_install_python_cleanup

#
# FIXME: kick ${pkg_install_env}
#
ptxd_make_world_install() {
    local -a fakeargs cmd

    ptxd_make_world_init &&

    if [ -z "${pkg_build_dir}" ]; then
	# no build dir -> assume the package has nothing to install.
	return
    fi &&
    #
    # fakeroot is a host pkg and
    # might not be available, yet
    #
    if [ ! -e "${ptx_state_dir}/host-fakeroot.install.post" ]; then
	local echo="eval"
	local fakeroot="cat"
    fi &&

#    if [ -z "${fakeroot}" ]; then
#	fakeargs=( "-s" "${pkg_fake_env}" )
#    fi

    ptxd_make_world_install_prepare &&

    case "${pkg_conf_tool}" in
	python*)
	cmd=( \
	    cd "${pkg_build_dir}" '&&' \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${pkg_install_env}" \
	    "${ptx_build_python}" \
	    setup.py \
	    "${pkg_install_opt}" \
	)
        if [ "${pkg_type}" = target ]; then
	    cmd[${#cmd[@]}]='&&'
	    cmd[${#cmd[@]}]=ptxd_make_world_install_python_cleanup
	fi
	;;
	meson)
	cmd=( \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${pkg_install_env}" \
	    ninja \
	    -C "${pkg_build_dir}" \
	    "${pkg_install_opt}" \
	    -j1 \
	)
	;;
	*)
	cmd=( \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${pkg_install_env}" \
	    "${MAKE}" \
	    -C "${pkg_build_dir}" \
	    "${pkg_install_opt}" \
	    -j1 \
	)
	;;
    esac &&

    ptxd_verbose "executing:" "${cmd[@]}" &&

    "${echo:-echo}" \
	"${cmd[@]}" \
	| "${fakeroot:-fakeroot}" "${fakeargs[@]}" --
    check_pipe_status
}
export -f ptxd_make_world_install

#
# unpack
#
# unpack the dev tarball to pkg_pkg_dir
#
ptxd_make_world_install_unpack() {
    local pkg_prefix

    ptxd_make_world_init &&

    case "${pkg_type}" in
	host|cross) pkg_prefix="${pkg_type}-" ;;
	*)          pkg_prefix="" ;;
    esac &&

    if [ \! -e "${ptx_pkg_dev_dir}/${pkg_pkg_dev}" ]; then
	ptxd_bailout "Internal error: '$(ptxd_print_path ${ptx_pkg_dev_dir}/${pkg_pkg_dev})' does not exist."
    fi &&
    rm -rf -- "${pkg_pkg_dir}" &&
    mkdir -p -- "${ptx_pkg_dir}" &&
    tar -x -C "${ptx_pkg_dir}" -z -f "${ptx_pkg_dev_dir}/${pkg_pkg_dev}"
}
export -f ptxd_make_world_install_unpack

#
# pack
#
# pack the dev tarball from pkg_pkg_dir
#
ptxd_make_world_install_pack() {
    ptxd_make_world_init &&

    if [ -z "${pkg_pkg_dir}" ]; then
	# no pkg dir -> assume the package has nothing to install.
	return
    fi &&

    # remove empty dirs
    test \! -e "${pkg_pkg_dir}" || \
	find "${pkg_pkg_dir}" -depth -type d -print0 | xargs -r -0 -- \
	rmdir --ignore-fail-on-non-empty -- &&
    check_pipe_status &&

    if [ \! -e "${pkg_pkg_dir}" ]; then
	if [ -e "${pkg_dir}" ]; then
	    ptxd_warning "PKG didn't install anything to '${pkg_pkg_dir}'"
	fi
	return
    fi &&

    # make pkgconfig's pc files relocatable
    find "${pkg_pkg_dir}" -name "*.pc" -print0 | \
	xargs -r -0 gawk -f "${PTXDIST_LIB_DIR}/ptxd_make_world_install_mangle_pc.awk" &&
    check_pipe_status &&

    # relocatable rpaths in host/cross tools
    if [ "${pkg_type}" != "target" ]; then
	find "${pkg_pkg_dir}" -type f -print | while read file; do
	    if chrpath "${file}" >& /dev/null; then
		local rel="$(ptxd_abs2rel "$(dirname "${file}")" "${pkg_pkg_dir}/lib")"
		chmod +w "${file}" &&
		if ! chrpath --replace "\${ORIGIN}/${rel}" "${file}" > /dev/null; then
		    ptxd_bailout "Failed to adjust rpath for '${file}'"
		fi
	    fi
	done || return
    fi

    # remove la files. They are not needed
    find "${pkg_pkg_dir}" \( -type f -o -type l \) -name "*.la" -print0 | xargs -r -0 rm &&
    check_pipe_status &&

    local pkg_sysroot_dir_nolink="$(readlink -f "${pkg_sysroot_dir}")" &&
    local pkg_build_dir_nolink="$(readlink -f "${pkg_build_dir}")" &&
    find "${pkg_pkg_dir}" -name "*.prl" -print0 | xargs -r -0 -- \
	sed -i -E \
	-e "/^QMAKE_PRL_BUILD_DIR/d" \
	-e "/^QMAKE_PRL_LIBS/s:(-L|-R)(${pkg_build_dir}|${pkg_build_dir_nolink})[^ ]* ::g" \
	-e "/^QMAKE_PRL_LIBS/s:(-L|-R)(|${pkg_sysroot_dir}|${pkg_sysroot_dir_nolink}|${pkg_pkg_dir})/*(/lib|/usr/lib) ::g" \
	-e "/^QMAKE_PRL_LIBS/s:(-L|-R)(|${pkg_sysroot_dir}|${pkg_sysroot_dir_nolink})/*(|/usr)/lib:\1\$\$[QT_INSTALL_LIBS]:g" &&
    check_pipe_status &&
    find "${pkg_pkg_dir}" ! -type d -name "${pkg_binconfig_glob}" -print0 | xargs -r -0 -- \
	sed -i \
	-e "s:\(-L\|-Wl,\)\(${pkg_sysroot_dir}\|${pkg_sysroot_dir_nolink}\)/*\(/lib\|/usr/lib\):\1@SYSROOT@\3:g" \
	-e "s:\(-I\|-isystem \)\(${pkg_sysroot_dir}\|${pkg_sysroot_dir_nolink}\)/*\(/include\|/usr/include\):\1@SYSROOT@\3:g" &&
    check_pipe_status &&

    if [ "${pkg_pkg_dev}" != "NO" -a "$(ptxd_get_ptxconf PTXCONF_PROJECT_CREATE_DEVPKGS)" = "y" ]; then
	tar -c -C "${ptx_pkg_dir}" -z -f "${ptx_pkg_dir}/${pkg_pkg_dev}" "${pkg_pkg_dir##*/}"
    fi
}
export -f ptxd_make_world_install_pack

#
# post
#
# cleanup an copy to sysroot
#
ptxd_make_world_install_post() {
    ptxd_make_world_init &&
    (
	if [ -n "${pkg_pkg_dir}" -a -d "${pkg_pkg_dir}" ]; then
	    find "${pkg_pkg_dir}"{,/usr}/{lib,share}/pkgconfig -name *.pc \
		-printf "%f\n" 2>/dev/null | sed 's/\.pc$//'
	fi
	for dep in ${pkg_build_deps}; do
	    case "${dep}" in
		host-*|cross-*)
		    if [ "${pkg_type}" = "target" ]; then
			continue
		    fi
		    ;&
		*)
		    cat "${ptx_state_dir}/${dep}.pkgconfig" 2>/dev/null
		    ;;
	    esac
	done
    ) | sort -u > "${ptx_state_dir}/${pkg_label}.pkgconfig"
    # do nothing if pkg_pkg_dir does not exist
    if [ \! -d "${pkg_pkg_dir}" ]; then
	return
    fi &&

    # fix *-config and copy into sysroot_cross for target packages
    local config &&
    find "${pkg_pkg_dir}" ! -type d -name "${pkg_binconfig_glob}" | while read config; do
	sed -i -e "s:@SYSROOT@:${pkg_sysroot_dir}:g" "${config}" &&
	if [ "${pkg_type}" = "target" ]; then
	    cp -P -- "${config}" "${PTXDIST_SYSROOT_CROSS}/bin" || return
	fi
    done &&

    # create directories first to avoid race contitions with -jeX
    find "${pkg_pkg_dir}" -type d -printf "%P\0" | \
	xargs -0 -I{} mkdir -p "${pkg_sysroot_dir}/{}" &&
    cp -dpr --link --remove-destination -- "${pkg_pkg_dir}"/* "${pkg_sysroot_dir}" &&

    # host and cross packages
    if [ "${pkg_type}" != "target" ]; then
	ptxd_make_world_install_library_path
    fi
}
export -f ptxd_make_world_install_post
