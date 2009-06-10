#!/bin/bash

export PTX_DGEN_DIR="${PTXDIST_TEMPDIR}/dgen"

#
# generates:
#
# PTX_MAP_DEP_<PACKAGE>=<DEP>:<DEP>
#
ptxd_dgen_configdeps() {
    local i
    local config[0]=ptx

    
    if [ -e "${PTXDIST_PLATFORMCONFIG}" ]; then
	config[1]=platform
    fi

    {
	for ((i = 0; i < ${#config[@]}; i++)); do
	    ptxd_kconfig dep "${config[i]}" || {
		ptxd_dialog_msgbox \
		    "error: error during generation of dependencies\n" \
		    "	(maybe amd64 executable on x86)"
		return 1
	    }
	done
    } | sed -ne "s~DEP:\([^:]*\):\(.*\)~PTX_MAP_DEP_\1=\2~p" > "${PTX_MAP_DEPS}.tmp"
    check_pipe_status || return
}

#
# FIXME: gawk it
#
ptxd_dgen_rulesfiles() {
   {
	if test -d "${PROJECTRULESDIR}"; then
	    find "${PROJECTRULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*"
	    find "${RULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*" \
		`find "${PROJECTRULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*" \
		-printf "! -name %f "`
	else
	    find "${RULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*"
	fi
    } > "${PTX_DGEN_RULESFILES}"

    sed -e "s/\(.*\)/include \1/" "${PTX_DGEN_RULESFILES}" > "${PTX_DGEN_RULESFILES_MAKE}"
}



#
# generates
#
# PTX_MAP_TO_FILENAME_<PACKAGE>="<filename.make>"
# PTX_MAP_TO_package_<PACKAGE>="<package>"
# PTX_MAP_TO_PACKAGE_<package>="<PACKAGE>"
#
ptxd_dgen_map_all() {
    local dgen_ptxconfig="${PTX_DGEN_DIR}/ptxconfig"
    local dgen_platformconfig="${PTX_DGEN_DIR}/platformconfig"

    {
	cat "${PTX_DGEN_RULESFILES}"
	cat <<EOF
	"${PTX_MAP_DEPS}.tmp"
	"${dgen_ptxconfig}"
EOF
	if [ -e "${dgen_platformconfig}" ]; then
	    echo "${dgen_platformconfig}"
	fi
    } | {
	xargs cat
    } | {
	export \
	    PTX_MAP_ALL \
	    PTX_MAP_ALL_MAKE \
	    PTX_MAP_DEPS \
	    PTX_DGEN_DEPS_POST
	"${PTX_LIBDIR}/ptxd_lib_dgen.awk"
    }
    check_pipe_status
}



ptxd_dgen() {
    mkdir -p -- \
	"${STATEDIR}" \
	"${PTX_DGEN_DIR}" || return

    ptxd_dgen_configdeps &&
    ptxd_dgen_rulesfiles &&
    ptxd_dgen_map_all
}
