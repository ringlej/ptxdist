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

    # ask the compiler for the lib
    lib_path="`${CC} -print-file-name=${lib}`"
    if test "${lib_path}" = "${lib}"; then
	echo "install_copy_toolchain_lib: ${lib} not found"
	return -1
    fi
    # let the shell canonicalized the path
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
# The work is done here!
# - look at the filename given us, if it's a link then
#   copy it (do not deref, i.e. preserve the link)
# - feed the target of the link recursive into this function
# - if we encounter a regular file, copy it
#   (if it's not a linker script)
# - look into the linker scripts and copy only the _shared_
#   libs mentioned there
# - one more thing: if we find a tls lib (e.g. in the /lib/tls subdir)
#   we use it
#
ptxd_install_lib() {
    local lib_path lib lib_dir sysroot prefix prefix script_lib tmp tls_lib dir v_full lib_v_major

    lib_path="${1}"

    while true; do
	lib="${lib_path##*/}"			# the pure library filename "libxxx.so"
	lib_dir="${lib_path%/${lib}}"		# abs path to that lib

	# try to identify sysroot part of that path
	for prefix in "/usr/lib/tls" "/usr/lib" "/lib/tls" "/lib"; do
	    tmp="${lib_dir%${prefix}}"
	    if test "${lib_dir}" != "${tmp}"; then
		break
	    fi
	done
	sysroot="${lib_dir%${prefix}}"

	# if the user has given us a $prefix use it
	prefix="${dest:-${prefix}}"

# disabled cause tls is bad for UML
	# is there a tls variant of the lib? (e.g. native build on debian)
#	tls_lib="${lib_dir}/tls/${lib}"
#	if test -e "${tls_lib}"; then
#	    echo "tls - ${tls_lib}"
#	    ptxd_install_lib "${tls_lib}"
#	    return $?	
#	fi

	# remove existing libs
	for dir in \
	    "${ROOTDIR}" \
	    "${ROOTDIR_DEBUG}"; do

	    tmp="${dir}${prefix}/${lib}"
	    test -e "${tmp}" && rm -rf "${tmp}"
	done

	# do sth. with that found lib, action depends on file type (link or regular)
	if test -h "${lib_path}"; then		# link
	    echo "link - ${lib_path}"

	    # now install that link into the root and ipkg dirs
	    for dir in \
		"${ROOTDIR}" \
		"${ROOTDIR_DEBUG}" \
		"${IMAGEDIR}/${packet}/ipkg/"; do

		test -d "${dir}${prefix}" || mkdir -p "${dir}${prefix}"
		cp -d "${lib_path}" "${dir}${prefix}/${lib}"
	    done

	    # now do the same thing for the target of the link
	    lib_path="`readlink \"${lib_path}\"`" || ( echo broken link; exit 1 )

	    # deal with relative and absolute links
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
		# strip all braces and install all shared libs ( *.so*), ignore "GROUP" and static libs
		#
		for script_lib in `sed -n -e "/GROUP/s/[()]//gp" "${lib_path}"`; do
		    # deal with relative and absolute libs
		    case "${script_lib}" in 
			/*.so*)
			    echo "in script - ${script_lib}"
			    ptxd_install_lib "${sysroot}/${script_lib}" || return $?
			    ;;
			*.so*)
			    echo "in script - ${script_lib}"
			    ptxd_install_lib "${lib_dir}/${script_lib}" || return $?
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
		    "${IMAGEDIR}/${packet}/ipkg"; do

		  install -D "${lib_path}" "${dir}${prefix}/${lib}"
		done

		${STRIP} "${ROOTDIR}${prefix}/${lib}"
		${STRIP} "${IMAGEDIR}/${packet}/ipkg${prefix}/${lib}"
		echo "f:${prefix}/${lib}:0:0:755" >> "${STATEDIR}/${packet}.perms"

		# now create some links to that lib
		# e.g. libstdc++.so.6 -> libstdc++.so.6.6.6

		# the fullversion (6.6.6)
		v_full="${lib#*.so.}"
		# library name with major version (libstdc++.so.6)
		lib_v_major="${lib%${v_full}}${v_full%%.*}"

		if test "${v_full}" != "${lib}" -a \
		    "${lib_v_major}" != "${lib}"; then		    
		    echo "extra link - ${prefix}/${lib_v_major}"

		    for dir in \
			"${ROOTDIR}" \
			"${ROOTDIR_DEBUG}" \
			"${IMAGEDIR}/${packet}/ipkg"; do

		      if test \! -e "${dir}${prefix}/${lib_v_major}"; then
			  ln -sf "${lib}" "${dir}${prefix}/${lib_v_major}"
		      fi
		    done
		fi
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
ptxd_install_lib "${lib_path}" || exit $?
