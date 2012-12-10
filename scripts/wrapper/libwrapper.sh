#!/bin/sh

COMPILING=false
LINKING=true
FORTIFY=true
STDLIB=true
FPIE=true
PIE=true
OPTIMIZE=false
ARG_LIST=""

. ${PTXDIST_PLATFORMCONFIG}

wrapper_exec() {
	if [ "${PTXDIST_VERBOSE}" = 1 -a -n "${PTXDIST_FD_LOGFILE}" ]; then
		echo "wrapper: ${PTXDIST_CCACHE} ${0##*/} ${ARG_LIST} $*" >&${PTXDIST_FD_LOGFILE}
	fi
	exec ${PTXDIST_CCACHE} $0.real ${ARG_LIST} "$@"
}

cc_check_args() {
	for ARG in "$@"; do
		case "${ARG}" in
			-c)
				LINKING=false
				PIE=false
				;;
			-D_FORTIFY_SOURCE | -D_FORTIFY_SOURCE=*)
				FORTIFY=false
				;;
			-nostdlib | -ffreestanding)
				STDLIB=false
				FPIE=false
				PIE=false
				;;
			-fno-PIC | -fno-pic | -fno-PIE | -fno-pie | \
			-nopie | -static | -shared | \
			-D__KERNEL__ | -nostartfiles )
				FPIE=false
				PIE=false
				;;
			-fPIC | -fpic )
				FPIE=false
				;;
			-O0)
				;;
			-O*)
				OPTIMIZE=true
				;;
			-I/usr/include | -L/usr/lib | -L/lib )
				echo "wrapper: Bad search path in:" >&2
				echo "${0##*/} $*" >&2
				exit 1
				;;
			-)
				COMPILING=true
				;;
			-*)
				;;
			*)
				COMPILING=true
				;;
		esac
	done
	# Used e.g. by the kernel to get the compiler version. Adding
	# linker options confuses gcc because there is nothing to link.
	if ! $COMPILING; then
		LINKING=false
	fi
}

add_arg() {
	for arg in "${@}"; do
		ARG_LIST="${ARG_LIST} ${arg}"
	done
}

add_opt_arg() {
	local opt="${1}"
	shift

	for item in ${pkg_wrapper_blacklist}; do
		if [ "${item}" = "${opt}" ]; then
			return
		fi
	done
	opt="PTXCONF_${opt}"
	eval "opt=\$${opt}"
	if [ -z "${opt}" ]; then
		return
	fi
	add_arg "${@}"
}

add_ld_args() {
	add_opt_arg TARGET_HARDEN_RELRO "${1}-z,relro"
	add_opt_arg TARGET_HARDEN_BINDNOW "${1}-z,now"
	add_opt_arg TARGET_LINKER_HASH_GNU "${1}--hash-style=gnu"
	add_opt_arg TARGET_LINKER_HASH_SYSV "${1}--hash-style=sysv"
	add_opt_arg TARGET_LINKER_HASH_BOTH "${1}--hash-style=both"
}

ld_add_ld_args() {
	# ld warns about ignored keywords (-z <keyword>) when only asked for the
	# version
	if [ "$*" != "-v" ]; then
		add_ld_args
	fi
}

cc_add_ld_args() {
	if ${LINKING}; then
		add_ld_args "-Wl,"
		add_arg ${PTXDIST_CROSS_LDFLAGS}
		add_opt_arg TARGET_EXTRA_LDFLAGS ${PTXCONF_TARGET_EXTRA_LDFLAGS}
	fi
}

cc_add_fortify() {
	# fortify only works when optimizing is enabled. The warning
	# generated when combining -D_FORTIFY_SOURCE with -O0 can confuse
	# configure checks
	if ${FORTIFY} && ${OPTIMIZE}; then
		add_opt_arg TARGET_HARDEN_FORTIFY "-D_FORTIFY_SOURCE=2"
	fi
}

cc_add_stack() {
	if ${STDLIB}; then
		add_opt_arg TARGET_HARDEN_STACK "-fstack-protector" "--param=ssp-buffer-size=4"
	fi
}

cc_add_pie() {
	if ${FPIE}; then
		add_opt_arg TARGET_HARDEN_PIE "-fPIE"
	fi
	if ${PIE}; then
		add_opt_arg TARGET_HARDEN_PIE "-pie"
	fi
}

cpp_add_extra() {
	add_arg -frecord-gcc-switches
	add_arg ${PTXDIST_CROSS_CPPFLAGS}
	add_opt_arg TARGET_EXTRA_CPPFLAGS ${PTXCONF_TARGET_EXTRA_CPPFLAGS}
}

cc_add_extra() {
	cpp_add_extra
	add_opt_arg TARGET_EXTRA_CFLAGS ${PTXCONF_TARGET_EXTRA_CFLAGS}
}

cxx_add_extra() {
	cpp_add_extra
	add_opt_arg TARGET_EXTRA_CXXFLAGS ${PTXCONF_TARGET_EXTRA_CXXFLAGS}
}
