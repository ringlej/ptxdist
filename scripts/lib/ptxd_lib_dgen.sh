#!/bin/bash
#
# Copyright (C) 2006, 2007 by the PTXdist project
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

export PTXDIST_DGEN_DIR="${PTXDIST_TEMPDIR}/dgen"

ptxd_kconfig_dep_all() {
    while [ ${#} -gt 0 ]; do
	ptxd_kconfig dep "${1}" || {
	    ptxd_dialog_msgbox \
		"error: error during generation of dependencies\n" \
		"	(maybe amd64 executable on x86)"
	    return 1
	}
	shift
    done
}

#
# generates:
#
# PTX_MAP_[BR]_DEP_<PACKAGE>=<DEP>:<DEP>
#
ptxd_dgen_configdeps() {
    local i
    local config[0]=ptx

    if [ -e "${PTXDIST_PLATFORMCONFIG}" ]; then
	config[1]=platform
    fi

    {
	PTXDIST_DEP_TARGET="build" ptxd_kconfig_dep_all "${config[@]}" \
	    | sed -ne "s~DEP:\([^:]*\):\(.*\)~PTX_MAP_B_DEP_\1=\2~p"
	PTXDIST_DEP_TARGET="run" ptxd_kconfig_dep_all "${config[@]}" \
	    | sed -ne "s~DEP:\([^:]*\):\(.*\)~PTX_MAP_R_DEP_\1=\2~p"
    } > "${PTX_MAP_DEPS}.tmp"
    check_pipe_status || return
}

#
# get package *.make files without duplicates
#
ptxd_dgen_rulesfiles() {
    {
	local rulesdir
	ptxd_in_path PTXDIST_PATH_RULES || return
	for rulesdir in "${ptxd_reply[@]}"; do
	    find "${rulesdir}" -mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*"
	done
    } | gawk '{
	    n=gensub(".*/", "", "g");
	    if (!(n in names))
		print "include", $0;
	    names[n]=1;
	}' > "${PTX_DGEN_RULESFILES_MAKE}.tmp"
    check_pipe_status
}



#
# generates
#
# PTX_MAP_TO_FILENAME_<PACKAGE>="<filename.make>"
# PTX_MAP_TO_package_<PACKAGE>="<package>"
# PTX_MAP_TO_PACKAGE_<package>="<PACKAGE>"
#
ptxd_dgen_map_all() {
    local dgen_ptxconfig="${PTXDIST_DGEN_DIR}/ptxconfig"
    local dgen_platformconfig="${PTXDIST_DGEN_DIR}/platformconfig"

    {
	echo "${PTX_DGEN_RULESFILES_MAKE}.tmp"
	echo "${PTX_MAP_DEPS}.tmp"
	echo "${dgen_ptxconfig}"
	if [ -e "${dgen_platformconfig}" ]; then
	    echo "${dgen_platformconfig}"
	fi
    } | {
	export \
	    PTX_MAP_ALL \
	    PTX_MAP_ALL_MAKE \
	    PTX_MAP_DEPS \
	    PTX_DGEN_DEPS_PRE \
	    PTX_DGEN_DEPS_POST \
	    PTX_DGEN_RULESFILES_MAKE
	xargs gawk -f "${PTXDIST_LIB_DIR}/ptxd_lib_dgen.awk"
    }
    check_pipe_status
}



ptxd_dgen() {
    mkdir -p -- \
	"${STATEDIR}" \
	"${PTXDIST_DGEN_DIR}" || return

    ptxd_dgen_configdeps &&
    ptxd_dgen_rulesfiles &&
    ptxd_dgen_map_all
}
