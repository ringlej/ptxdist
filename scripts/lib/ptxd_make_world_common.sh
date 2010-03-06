#!/bin/bash
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# check for deprecated vars and print them
#
ptxd_make_world_init_deprecation_check() {
    local -a dep
    dep=(
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
	-n "${pkg_build_dir}" -a -n "${pkg_deprecated_builddir}" -a \
	"${pkg_build_dir}" != "${pkg_deprecated_builddir}" ]; then
	ptxd_bailout "${FUNCNAME}: build dir inconsistency detected!"
    fi
    pkg_build_dir="${pkg_deprecated_install_builddir}"
    pkg_build_dir="${pkg_build_dir:-${pkg_deprecated_builddir}}"


    # env
    if [ -n "${pkg_deprecated_env}" ]; then
	if [ -n "${pkg_conf_env}" -o -n "${pkg_make_env}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_ENV is incompatibel with <PKG>_CONF_ENV or <PKG>_MAKE_ENV"
	fi
	pkg_conf_env="${pkg_deprecated_env}"
	pkg_install_env="${pkg_deprecated_env}"
    fi


    # autoconf
    if [ -n "${pkg_deprecated_autoconf}" ]; then
	if [ -n "${pkg_conf_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_AUTOCONF is incompatibel with <PKG>_CONF_OPT"
	fi
	pkg_conf_opt="${pkg_deprecated_autoconf}"
	pkg_conf_tool="autoconf"
    fi


    # cmake
    if [ -n "${pkg_deprecated_cmake}" ]; then
	if [ -n "${pkg_conf_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_CMAKE is incompatibel with <PKG>_CONF_OPT"
	fi
	pkg_conf_opt="${pkg_deprecated_cmake}"
	pkg_conf_tool="cmake"
    fi


    # compile_env
    if [ -n "${pkg_deprecated_compile_env}" ]; then
	if [ -n "${pkg_make_env}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_COMPILE_ENV is incompatibel with <PKG>_MAKE_ENV"
	fi
	pkg_make_env="${pkg_deprecated_compile_env}"
    fi


    # makevars
    if [ -n "${pkg_deprecated_makevars}" ]; then
	if [ -n "${pkg_make_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_MAKEVARS is incompatibel with <PKG>_MAKE_OPT"
	fi
	pkg_make_opt="${pkg_deprecated_makevars}"
    fi


    # install_opt
    if [ -z "${pkg_install_opt}" ]; then
	pkg_install_opt="install"

	# deprecared_makevars
	pkg_install_opt="${pkg_install_opt}${pkg_deprecated_makevars:+ }${pkg_deprecated_makevars}"

	# deprecared_install_opt
	pkg_install_opt="${pkg_install_opt}${pkg_deprecated_install_opt:+ }${pkg_deprecated_install_opt}"
    else
	if [ -n "${pkg_deprecated_makevars}" -o -n "${pkg_deprecated_install_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_MAKEVARS is incompatibel with <PKG>_INSTALL_OPT"
	fi
    fi

    # DESTDIR
    pkg_install_opt="DESTDIR=\"${pkg_pkg_dir}\" INSTALL_ROOT=\"${pkg_pkg_dir}\" ${pkg_install_opt}"

    #
    # pkg_binconfig_glob
    #
    # default: "*-config"
    #
    pkg_binconfig_glob="${pkg_binconfig_glob:-*-config}"


    #
    # pkg_tags_opt
    #
    # default: "tags ctags"
    #
    pkg_tags_opt="${pkg_tags_opt:-tags ctags}"


    #
    # pkg_sysroot_dir
    #
    case "${pkg_stamp}" in
	klibc-*)             pkg_sysroot_dir="${PTXDIST_SYSROOT_TARGET}/usr/lib/klibc" ;;
	host-*)              pkg_sysroot_dir="${PTXDIST_SYSROOT_HOST}" ;;
	cross-*)             pkg_sysroot_dir="${PTXDIST_SYSROOT_CROSS}" ;;
	*)                   pkg_sysroot_dir="${PTXDIST_SYSROOT_TARGET}" ;;
    esac
    export pkg_sysroot_dir


    # pkg_env
    case "${pkg_type}" in
	target)     pkg_env="${PTXDIST_CROSS_ENV_PKG_CONFIG} SYSROOT='${pkg_sysroot_dir}'" ;;
	host|cross) pkg_env="PKG_CONFIG_LIBDIR='${PTXDIST_SYSROOT_HOST}/lib/pkgconfig:${PTXDIST_SYSROOT_HOST}/share/pkgconfig'" ;;
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
    # sanitize pkg_pkg_dir
    #
    if [ "${pkg_pkg_dir}" = "${ptx_pkg_dir}/" ]; then
	pkg_pkg_dir=""
    fi

    #
    # type
    #
    case "${pkg_stamp}" in
	host-*|cross-*) pkg_type="${pkg_stamp%%-*}" ;;
	*)              pkg_type="target" ;;
    esac

    #
    # label + stage
    #
    pkg_label="${pkg_stamp%%.*}"
    pkg_stage="${pkg_stamp#*.}"
    pkg_stage="${pkg_stage%%.*}"
    ptxd_make_world_init_compat || return

    #
    # xpkg mapping
    #
    pkg_xpkg_map="${ptx_state_dir}/${pkg_label}.xpkg.map"

    #
    # path
    #
    local path_ptr="ptx_path_${pkg_type}"
    pkg_path="${pkg_path:-${!path_ptr:+PATH=${!path_ptr}}}"
    unset path_ptr

    #
    # conf dir
    #
    pkg_conf_dir="${pkg_dir}${pkg_subdir:+/}${pkg_subdir}"
    pkg_conf_dir_abs="${pkg_conf_dir}"

    #
    # conf tool
    #
    if [ -z "${pkg_conf_tool}" ]; then
	# ${pkg_conf_tool} will be bogus if more than one tool finds a match
	# -> prepare will complain later
	if [ -e "${pkg_conf_dir}/configure" ]; then
	    pkg_conf_tool=${pkg_conf_tool}autoconf
	fi
	if [ -e "${pkg_conf_dir}/CMakeLists.txt" ]; then
	    pkg_conf_tool=${pkg_conf_tool}cmake
	fi
	if [ $(ls "${pkg_conf_dir}/"*.pro 2>/dev/null | wc -l) -eq 1 ]; then
	    pkg_conf_tool=${pkg_conf_tool}qmake
	fi
    fi

    case "${pkg_conf_tool}" in
	autoconf|cmake|qmake)
	    local conf_opt_ptr="ptx_conf_opt_${pkg_conf_tool}_${pkg_type}"
	    local conf_env_ptr="ptx_conf_env_${pkg_type}"

	    pkg_conf_opt="${pkg_conf_opt:-${!conf_opt_ptr}}"
	    pkg_conf_env="${pkg_conf_env:-${!conf_env_ptr}}"

	    unset conf_opt_ptr conf_env_ptr
	    ;;
	*) ;;
    esac

    #
    # build dir
    #
    if [ -z "${pkg_build_dir}" ]; then
	case "${pkg_conf_tool}" in
	    cmake)	# cmake based pkg -> _always_ out of tree
		pkg_build_dir="${pkg_dir}-build"
		;;
	    autoconf)	# autotoolizied pkg
		case "${pkg_build_oot}" in
		    "YES") pkg_build_dir="${pkg_dir}-build" ;;
		    "NO")  pkg_build_dir="${pkg_conf_dir}" ;;
		    "")    pkg_build_dir="${pkg_conf_dir}" ;;
		    *)     ptxd_bailout "<PKG>_BUILD_OOT: please set to YES or NO" ;;
		esac
		;;
	    *)		# qmake or std pkg
		pkg_build_dir="${pkg_conf_dir}"
		;;
	esac
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
	"YES"|"") pkg_make_par="${PTXDIST_PARALLELMFLAGS_INTERN} ${PTXDIST_LOADMFLAGS_INTERN}" ;;
	"NO")	  pkg_make_par=-j1 ;;
	*)	  ptxd_bailout "<PKG>_MAKE_PAR: please set to YES or NO" ;;
    esac
}
export -f ptxd_make_world_init
