#!/bin/sh

set -e

COMPILING=false
FORTIFY=true
FPIE=true
HOST=false
LINKING=true
OPTIMIZE=false
PIE=true
STDLIB=true
BUILDID=true

ARG_LIST=""
LATE_ARG_LIST=""

if [ -z "${PTXDIST_PLATFORMCONFIG}" ]; then
	. "$(dirname "$0")/env" || exit
fi

. ${PTXDIST_PLATFORMCONFIG}

wrapper_exec() {
	PATH="$(echo "${PATH}" | sed "s;${PTXDIST_PATH_SYSROOT_HOST}/lib/wrapper:;;")"
	if [ "${PTXDIST_VERBOSE}" = 1 -a -n "${PTXDIST_FD_LOGFILE}" ]; then
		echo "wrapper: ${PTXDIST_ICECC}${PTXDIST_CCACHE} ${0##*/} ${ARG_LIST} $* ${LATE_ARG_LIST}" >&${PTXDIST_FD_LOGFILE}
	fi
	if [ -n "${FAKEROOTKEY}" ]; then
		unset PTXDIST_ICECC
	fi
	exec ${PTXDIST_ICECC}${PTXDIST_CCACHE} "${0%/*}/real/${0##*/}" ${ARG_LIST} "$@" ${LATE_ARG_LIST}
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
			-r | -Wl,--build-id | -Wl,--build-id=*)
				BUILDID=false
				;;
			-nostdlib | -ffreestanding)
				STDLIB=false
				FPIE=false
				PIE=false
				;;
			-fno-PIC | -fno-pic | -fno-PIE | -fno-pie | \
			-nopie | -static | -shared | \
			-D__KERNEL__ | -nostartfiles)
				FPIE=false
				PIE=false
				;;
			-fPIC | -fpic)
				FPIE=false
				;;
			-O0)
				;;
			-O*)
				OPTIMIZE=true
				;;
			-I/usr/include | -L/usr/lib | -L/lib)
				if ! ${HOST}; then
					echo "wrapper: Bad search path in:" >&2
					echo "${0##*/} $*" >&2
					exit 1
				fi
				;;
			-Wl,-rpath,/*build-target*)
				if ! ${HOST}; then
					add_late_arg "-Wl,-rpath-link${ARG#-Wl,-rpath}"
				fi
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
	ARG_LIST="${ARG_LIST} ${*}"
}

add_late_arg() {
	LATE_ARG_LIST="${LATE_ARG_LIST} ${*}"
}

test_opt() {
	local opt="${1}"

	for item in ${pkg_wrapper_blacklist}; do
		if [ "${item}" = "${opt}" ]; then
			return 1
		fi
	done
	opt="PTXCONF_${opt}"
	eval "opt=\$${opt}"
	if [ -z "${opt}" ]; then
		return 1
	fi
	return 0
}

add_opt_arg() {
	test_opt "${1}" || return 0
	shift
	add_arg "${@}"
}

add_late_opt_arg() {
	test_opt "${1}" || return 0
	shift
	add_late_arg "${@}"
}

add_host_arg() {
	case "${pkg_stamp}" in
		host-*|cross-*) add_arg "${@}";;
	esac
}

add_ld_args() {
	add_opt_arg TARGET_HARDEN_RELRO "${1}-z${2}relro"
	add_opt_arg TARGET_HARDEN_BINDNOW "${1}-z${2}now"
	add_opt_arg TARGET_LINKER_HASH_GNU "${1}--hash-style=gnu"
	add_opt_arg TARGET_LINKER_HASH_SYSV "${1}--hash-style=sysv"
	add_opt_arg TARGET_LINKER_HASH_BOTH "${1}--hash-style=both"
	add_opt_arg TARGET_LINKER_AS_NEEDED "${1}--as-needed"
	if ${BUILDID}; then
		add_opt_arg TARGET_BUILD_ID "${1}--build-id=sha1"
	fi
}

ld_add_ld_args() {
	# ld warns about ignored keywords (-z <keyword>) when only asked for the
	# version
	if [ "$*" != "-v" ]; then
		add_ld_args
	fi
}

cc_add_target_ld_args() {
	if ${LINKING}; then
		cc_check_args ${pkg_ldflags}
		add_ld_args "-Wl," ","
		add_late_arg ${PTXDIST_CROSS_LDFLAGS}
		add_arg ${pkg_ldflags}
		add_opt_arg TARGET_EXTRA_LDFLAGS ${PTXCONF_TARGET_EXTRA_LDFLAGS}
	fi
}

cc_add_host_ld_args() {
	if ${LINKING}; then
		cc_check_args ${pkg_ldflags}
		add_host_arg ${pkg_ldflags}
		add_late_arg ${PTXDIST_HOST_LDFLAGS}
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
		add_opt_arg TARGET_HARDEN_STACK_STRONG "-fstack-protector-strong"
		add_opt_arg TARGET_HARDEN_STACK_ALL "-fstack-protector-all"
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

cc_add_debug() {
	# TARGET_DEBUG is no real option but used to blacklist all debug options
	PTXCONF_TARGET_DEBUG=y test_opt TARGET_DEBUG || return 0
	add_late_opt_arg TARGET_DEBUG_OFF "-g0"
	add_late_opt_arg TARGET_DEBUG_ENABLE "-g"
	add_late_opt_arg TARGET_DEBUG_FULL "-ggdb3"
}

cc_add_arch() {
	add_opt_arg ARCH_ARM_NEON "-mfpu=neon"
}

cpp_add_target_extra() {
	cc_check_args ${pkg_cppflags}
	add_opt_arg TARGET_COMPILER_RECORD_SWITCHES "-frecord-gcc-switches"
	add_late_arg ${PTXDIST_CROSS_CPPFLAGS}
	add_arg ${pkg_cppflags}
	add_opt_arg TARGET_EXTRA_CPPFLAGS ${PTXCONF_TARGET_EXTRA_CPPFLAGS}
}

cc_add_target_extra() {
	cc_check_args ${pkg_cflags}
	cpp_add_target_extra
	cc_add_debug
	cc_add_arch
	add_arg ${pkg_cflags}
	add_opt_arg TARGET_EXTRA_CFLAGS ${PTXCONF_TARGET_EXTRA_CFLAGS}
}

cxx_add_target_extra() {
	cc_check_args ${pkg_cxxflags}
	cpp_add_target_extra
	cc_add_debug
	cc_add_arch
	add_arg ${pkg_cxxflags}
	add_opt_arg TARGET_EXTRA_CXXFLAGS ${PTXCONF_TARGET_EXTRA_CXXFLAGS}
}

cpp_add_host_extra() {
	cc_check_args ${pkg_cppflags}
	add_arg ${PTXDIST_HOST_CPPFLAGS}
	add_host_arg ${pkg_cppflags}
}

cc_add_host_extra() {
	cc_check_args ${pkg_cflags}
	cpp_add_host_extra
	add_host_arg ${pkg_cflags}
}

cxx_add_host_extra() {
	cc_check_args ${pkg_cxxflags}
	cpp_add_host_extra
	add_host_arg ${pkg_cxxflags}
}


add_icecc_args() {
	if [ -n "${PTXDIST_ICECC}" ]; then
		add_late_arg "-fno-diagnostics-show-caret"
	fi
}

cc_add_target_icecc() {
	add_icecc_args
	export ICECC_VERSION="${ICECC_VERSION_TARGET}"
	export ICECC_CC="${0%/*}/real/${0##*/}"
}

cxx_add_target_icecc() {
	add_icecc_args
	export ICECC_VERSION="${ICECC_VERSION_TARGET}"
	export ICECC_CXX="${0%/*}/real/${0##*/}"
}

cc_add_host_icecc() {
	add_icecc_args
	export ICECC_VERSION="${ICECC_VERSION_HOST}"
	export ICECC_CC="${0%/*}/real/${0##*/}"
}

cxx_add_host_icecc() {
	add_icecc_args
	export ICECC_VERSION="${ICECC_VERSION_HOST}"
	export ICECC_CXX="${0%/*}/real/${0##*/}"
}
