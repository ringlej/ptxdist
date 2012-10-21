#!/bin/bash

LINKING=1
FORTIFY=1
STDLIB=1
declare -a ARG_LIST

cc_check_args() {
	for ARG in "$@"; do
		if [[ "${ARG}" = "-c" ]]; then
			LINKING=0
		fi
		if [[ "${ARG}" =~ -D_FORTIFY_SOURCE(=|$) ]]; then
			FORTIFY=0
		fi
		if [[ "${ARG}" = "-nostdlib" ||
		      "${ARG}" = "-ffreestanding" ]]; then
			STDLIB=0
		fi
	done
}

add_arg() {
	for arg in "${@}"; do
		ARG_LIST[${#ARG_LIST[@]}]="${arg}"
	done
}

add_opt_arg() {
	local blacklist="${pkg_wrapper_blacklist}"
	local opt="${1}"
	shift

	if grep -q "\<${opt}\>" <<< "${blacklist}"; then
		return
	fi
	opt="PTXCONF_${opt}"
	if [ -z "${!opt}" ]; then
		return
	fi
	add_arg "${@}"
}

add_ld_args() {
	add_opt_arg TARGET_HARDEN_RELRO "${1}-z,relro"
	add_opt_arg TARGET_HARDEN_BINDNOW "${1}-z,now"
	add_opt_arg TARGET_LINKER_GNUHASH "${1}--hash-style=gnu"
}

cc_add_ld_args() {
	if [[ "${LINKING}" = 1 ]]; then
		add_ld_args "-Wl,"
		add_arg ${PTXDIST_CROSS_LDFLAGS}
		add_opt_arg TARGET_EXTRA_LDFLAGS ${PTXCONF_TARGET_EXTRA_LDFLAGS}
	fi
}

cc_add_fortify() {
	if [[ "${FORTIFY}" = 1 ]]; then
		add_opt_arg TARGET_HARDEN_FORTIFY "-D_FORTIFY_SOURCE=2"
	fi
}

cc_add_stack() {
	if [[ "${STDLIB}" = 1 ]]; then
		add_opt_arg TARGET_HARDEN_STACK "-fstack-protector" "--param=ssp-buffer-size=4"
	fi
}

cc_add_extra() {
	add_arg ${PTXDIST_CROSS_CPPFLAGS}
	add_opt_arg TARGET_EXTRA_CPPFLAGS ${PTXCONF_TARGET_EXTRA_CPPFLAGS}
	add_opt_arg TARGET_EXTRA_CFLAGS ${PTXCONF_TARGET_EXTRA_CFLAGS}
}

cxx_add_extra() {
	add_arg ${PTXDIST_CROSS_CPPFLAGS}
	add_opt_arg TARGET_EXTRA_CPPFLAGS ${PTXCONF_TARGET_EXTRA_CPPFLAGS}
	add_opt_arg TARGET_EXTRA_CXXFLAGS ${PTXCONF_TARGET_EXTRA_CXXFLAGS}
}
