#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# check for deprecated vars and print them
#
ptxd_make_world_init_deprecation_check() {
    local -a dep=(
	pkg_deprecated_install_builddir
	pkg_deprecated_install_hosttool
	pkg_deprecated_install_opt

	pkg_deprecated_builddir
	pkg_deprecated_env
	pkg_deprecated_autoconf
	pkg_deprecated_cmake
	pkg_deprecated_compile_env
	pkg_deprecated_makevars
	)
    local i

    for ((i = 0; i < ${#dep[@]}; i++)); do
	local var="${dep[i]}"
	local val="${!var}"

	[ -z "${val}" ] && continue

	echo "${var}=\"${val}\""
	echo
    done

}
export -f ptxd_make_world_init_deprecation_check



#
# initialize deprecated variables to work with the new sheme
# (wich is still WIP)
#
ptxd_make_world_init_compat() {
    if [ "${pkg_stage}" = "prepare" ]; then
	ptxd_make_world_init_deprecation_check || return
    fi

    # build_dir
    if [ -n "${pkg_deprecated_install_builddir}" -a -n "${pkg_deprecated_builddir}" -a \
	"${pkg_deprecated_install_builddir}" != "${pkg_deprecated_builddir}" -o \
	-n "${pkg_build_dir}" -a \
	"${pkg_build_dir}" != "${pkg_deprecated_builddir}" ]; then
	ptxd_bailout "${FUNCNAME}: build dir inconsistency detected!"
    fi
    pkg_build_dir="${pkg_deprecated_install_builddir}"
    pkg_build_dir="${pkg_build_dir:-${pkg_deprecated_builddir}}"


    # env
    if [ -n "${pkg_deprecated_env}" -a \
	\( -n "${pkg_conf_env}" -o -n "${pkg_make_env}" \) ]; then
	ptxd_bailout "${FUNCNAME}: <PKG>_ENV is incompatibel with <PKG>_CONF_ENV or <PKG>_MAKE_ENV"
    fi
    pkg_conf_env="${pkg_deprecated_env}"
    pkg_cmake_env="${pkg_deprecated_env}"
    pkg_install_env="${pkg_deprecated_env}"


    # autoconf
    if [ -n "${pkg_deprecated_autoconf}" -a -n "${pkg_conf_opt}" ]; then
	ptxd_bailout "${FUNCNAME}: <PKG>_AUTOCONF is incompatibel with <PKG>_CONF_OPT"
    fi
    pkg_conf_opt="${pkg_deprecated_autoconf}"


    # cmake
    if [ -n "${pkg_deprecated_cmake}" -a -n "${pkg_cmake_opt}" ]; then
	ptxd_bailout "${FUNCNAME}: <PKG>_CMAKE is incompatibel with <PKG>_CMAKE_OPT"
    fi
    pkg_cmake_opt="${pkg_deprecated_cmake}"


    # compile_env
    if [ -n "${pkg_deprecated_compile_env}" -a -n "${pkg_make_env}" ]; then
	ptxd_bailout "${FUNCNAME}: <PKG>_COMPILE_ENV is incompatibel with <PKG>_MAKE_ENV"
    fi
    pkg_make_env="${pkg_deprecated_compile_env}"


    # makevars
    if [ -n "${pkg_deprecated_makevars}" -a -n "${pkg_make_opt}" ]; then
	ptxd_bailout "${FUNCNAME}: <PKG>_MAKEVARS is incompatibel with <PKG>_MAKE_OPT"
    fi
    pkg_make_opt="${pkg_deprecated_makevars}"


    # install_opt
    pkg_install_opt="${pkg_deprecated_makevars}${pkg_deprecated_makevars:+${pkg_deprecated_install_opt:+ }}${pkg_deprecated_install_opt}"

    # pkg_env
    case "${pkg_type}" in
	target)     pkg_env="${PTXDIST_CROSS_ENV_PKG_CONFIG}" ;;
	host|cross) pkg_env="PKG_CONFIG_LIBDIR='${PTXDIST_SYSROOT_HOST}/lib/pkgconfig'" ;;
    esac
}
export -f ptxd_make_world_init_compat



#
# basic sanity checks in pkg_ deps
#
ptxd_make_world_init_sanity_check() {
    #
    # subdir must be a relative path
    #
    [ "${pkg_subdir:0:1}" = "/" ] && \
	ptxd_bailout "variable 'SUBDIR' contains an absolute path ('${pkg_subdir}')"

    true
}
export -f ptxd_make_world_init_sanity_check



#
# ptxd_make_world_init()
#
# environment in:
#
# environment out:
# $pkg_type
# $pkg_conf_dir
# $pkg_build_dir
# $pkg_build_oot
# $pkg_make_par
#
ptxd_make_world_init() {
    ptxd_make_world_init_sanity_check || return

    #
    # type
    #
    case "${pkg_stamp}" in
	host-*|cross-*) pkg_type="${pkg_stamp%%-*}" ;;
	*)              pkg_type="target" ;;
    esac

    #
    # stage
    #
    pkg_stage="${pkg_stamp#*.}"
    pkg_stage="${pkg_stage%%.*}"
    ptxd_make_world_init_compat || return

    #
    # conf dir
    #
    pkg_conf_dir="${pkg_dir}${pkg_subdir:+/}${pkg_subdir}"
    pkg_conf_dir_abs="${pkg_conf_dir}"

    #
    # build dir
    #
    if [ -z "${pkg_build_dir}" ]; then
	if [ -n "${pkg_cmake_opt}" ]; then
	    # cmake based pkg -> _always_ out of tree
	    pkg_build_dir="${pkg_dir}-build"

	elif [ -n "${pkg_conf_opt}" ]; then
	    # autotoolizied pkg
	    case "${pkg_build_oot}" in
		"YES") pkg_build_dir="${pkg_dir}-build"	;;
		"NO")  pkg_build_dir="${pkg_conf_dir}"	;;
		"")    pkg_build_dir="${pkg_conf_dir}"	;;
		*)     ptxd_bailout "<PKG>_BUILD_OOT: please set to YES or NO" ;;
	    esac
	else
	    # std pkg
	    pkg_build_dir="${pkg_conf_dir}"
	fi
    fi

    #
    # out-of-tree
    #
    unset pkg_build_oot
    if [ "${pkg_build_dir}" = "${pkg_conf_dir}" ]; then
	#
	# some pkgs don't like a full path to their configure
	# if building in tree
	#
	pkg_conf_dir="."
    else
	pkg_build_oot=true
    fi

    #
    # parallelmake
    #
    case "${pkg_make_par}" in
	"YES"|"") pkg_make_par="${PTXDIST_PARALLELMFLAGS_INTERN}" ;;
	"NO")	  pkg_make_par=-j1 ;;
	*)	  ptxd_bailout "<PKG>_MAKE_PAR: please set to YES or NO" ;;
    esac
}
export -f ptxd_make_world_init
