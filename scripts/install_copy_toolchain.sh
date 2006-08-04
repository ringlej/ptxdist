#!/bin/bash

. ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh
. ${SCRIPTSDIR}/libptxdist.sh

#
# $1: lib
#
# out: $lib_path
#
get_lib_path() {
    local lib lib_dir

    lib="${1}"

    lib_path="`${CC} -print-file-name=${lib}`"
    lib_dir="`cd ${lib_path%/${lib}} && echo $PWD`"

    if test \! -d "${lib_dir}"; then
	echo "install_copy_toolchain_lib: ${lib_dir} not found"
	return -1
    fi

    lib_path="${lib_dir}/${lib}"
}


#
# $1: lib_path: canonicalized path to lib
#
ptxd_install_lib() {
    local lib_path lib lib_dir sysroot prefix script_lib tmp tls_lib dir

    lib_path="${1}"

    while true; do
	lib="${lib_path##*/}"
	lib_dir="${lib_path%/${lib}}"

	for prefix in "/usr/lib/tls" "/usr/lib" "/lib/tls" "/lib"; do
	    tmp="${lib_dir%${prefix}}"
	    if test "${lib_dir}" != "${tmp}"; then
		break
	    fi
	done
	sysroot="${lib_dir%${prefix}}"

	# is there a tls variant of the lib? (e.g. native build on debian)
	tls_lib="${lib_dir}/tls/${lib}"
	if test -e "${tls_lib}"; then
	    echo "tls - ${tls_lib}"
	    ptxd_install_lib "${tls_lib}"
	
	elif test -h "${lib_path}"; then	# link
	    echo "link - ${lib_path}"

	    # now install that link into the root and ipkg dir
	    for dir in \
		"${ROOTDIR}" \
		"${ROOTDIR_DEBUG}" \
		"${IMAGEDIR}/${packet}/ipkg/"; do

		test -d "${dir}${prefix}" || mkdir -p "${dir}${prefix}"
		cp -d "${lib_path}" "${dir}${prefix}/${lib}"
	    done

	    lib_path="`readlink \"${lib_path}\"`" || ( echo broken link; exit -1 )

	    case "${lib_path}" in
		/*)
		    # nix
		    ;;
		*)
		    lib_path="${lib_dir}/${lib_path}"
		    ;;
	    esac
	    lib_path="`ptxd_abspath \"${lib_path}\"`"
	    continue
	elif test -f "${lib_path}"; then	# regular file
	    # is this a linker script?
	    if grep "GNU ld script" "${lib_path}" 1>/dev/null 2>&1; then
		echo "script - ${lib_path}"
		# 
		# the libs are in the GROUP line
		# strip all braces and install all shared libs ( *.so*)
		#
		for script_lib in `sed -n -e "/GROUP/s/[()]//gp" "${lib_path}"`; do
		    case "${script_lib}" in
			*.so*)
			    echo "in script - ${script_lib}"
			    ptxd_install_lib "${sysroot}/${script_lib}"
			    ;;
			*)
			    ;;
		    esac
		done
	    else
		# ordinary shared lib, just copy it
		echo "lib - ${lib_path}"
		
		for dir in \
		    "${ROOTDIR}" \
		    "${ROOTDIR_DEBUG}" \
		    "${IMAGEDIR}/${packet}/ipkg/"; do

		  install -D "${lib_path}" "${dir}${prefix}/${lib}"
		done
	    fi
	else
	    echo "error: found ${lib_path}, but neither file nor link"
	    return -1
	fi

	return 0
    done
}


#
# main()
#
while getopts "p:l:d:s::" opt; do
    case "${opt}" in
	p)
	    packet="${OPTARG}"
	    ;;
	l)
	    lib="${OPTARG}"
	    ;;
	d)
	    dest="${OPTARG}"
	    ;;
	s)
	    strip="${OPTARG}"
	    ;;
    esac
done

get_lib_path "${lib}" || exit $?
ptxd_install_lib "${lib_path}"
