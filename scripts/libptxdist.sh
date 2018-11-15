#!/bin/bash

PTX_DEBUG=${PTX_DEBUG:="false"}
PTX_DIALOG="dialog --aspect 60"
PTX_DIALOG_HEIGHT=0
PTX_DIALOG_WIDTH=0


#
# ${1}	variable name in which string is returned
#       derefed serves as starting point for file selector
#       if empty $PWD is used
#
# return: selected file in variable ${1}
#
ptxd_dialog_fselect() {
	local ptr="${1}"
	local _select="${!1:-${PWD}}"

	exec 3>&1
	exec 4>&1
	while [ -d "${_select}" -o \! -e "${_select}" ]; do
		# FIXME take care about real links
		_select="$(readlink -f ${_select})"
		_select="${_select}/$(eval ${PTX_DIALOG} \
			--clear \
			--output-fd 3 \
			--title \"Please choose a ${ptr} file\" \
			--menu \"${_select}\" 0 0 0 \
			-- \
			\".\"  \"\<d\>\" \
			\"..\" \"\<d\>\" \
			$(find "${_select}/" -maxdepth 1 -mindepth 1    -type d -a \! -name ".*" -printf "\"%f\" \"<d>\"\n" | sort) \
			$(find "${_select}/" -maxdepth 1 -mindepth 1 \! -type d -a \! -name ".*" -printf "\"%f\" \"<f>\"\n" | sort) \
			3>&1 1>&4 \
			)" || return
	done
	exec 4>&-
	exec 3>&-

	eval "${ptr}"="${_select}"
}


_ptxd_dialog_box() {
	local dialog="${1}"
	shift

	local old_ifs="${IFS}"
	local IFS=''
	local msg
	msg="${*}"
	IFS="${old_ifs}"

	if [ -n "${PTX_MENU}" ]; then
		${PTX_DIALOG} \
			--no-collapse \
			--${dialog}box "${msg}" ${PTX_DIALOG_HEIGHT} ${PTX_DIALOG_WIDTH}
	else
		echo -e "${msg}\n" >&2
	fi
}

ptxd_dialog_infobox() {
	_ptxd_dialog_box info "${@}"
}

ptxd_dialog_msgbox() {
	_ptxd_dialog_box msg "${@}"
}

ptxd_dialog_yesno() {
	local old_ifs="${IFS}"
	local IFS=''
	local msg
	msg="${*}"
	IFS="${old_ifs}"

	local answer

	if [ -n "${PTX_MENU}" ]; then
		${PTX_DIALOG} \
			--yesno "${msg}" ${PTX_DIALOG_HEIGHT} ${PTX_DIALOG_WIDTH}
	else
		echo -e "${msg}"

		read answer
		if [ "${answer}" != "y" -a "${answer}" != "" ]; then
			echo "interrupting"
			echo
			return 1
		fi
	fi
}



#
# source a kconfig file
#
ptxd_source_kconfig() {
	local ret

	set -a
	source "${1}" 2> /dev/null
	ret=$?
	set +a

	return ${ret}
}
export -f ptxd_source_kconfig


#
# get a symbol from the kconfig file
#
# $1: the config file
# $2: the symbol name
#
# return:
# 1: symbol not found
# 2: symbol invalid
#
ptxd_get_kconfig() {
	local config="${1}"
	unset "${2}" 2>/dev/null || return 2

	if test -f "${config}"; then
		source "${config}" || \
		ptxd_bailout "unable to source '${config}' (maybe git conflict?)" 3
	fi
	if [ -n "${!2}" ]; then
		echo "${!2}"
		return
	fi
	return 1;
}
export -f ptxd_get_kconfig
#
# get a symbol from the ptx or platformconfig
#
# return:
# 1: symbol not found
# 2: symbol invalid
#
ptxd_get_ptxconf() {
	ptxd_get_kconfig "${PTXDIST_PLATFORMCONFIG}" "${1}" ||
	ptxd_get_kconfig "${PTXDIST_PTXCONFIG}" "${1}"
}
export -f ptxd_get_ptxconf


#
# call make,
# source shell libraries wich are used in make
# ("scripts/lib/ptxd_make_"*.sh)
#
ptxd_make() {
	local lib i
	local -a dir
	ptxd_in_path PTXDIST_PATH_SCRIPTS || return
	dir=( "${ptxd_reply[@]}" )
	for ((i=$((${#dir[@]}-1)); i>=0; i--)) do
		ptxd_get_path "${dir[${i}]}/lib/ptxd_make_"*.sh || continue
		for lib in "${ptxd_reply[@]}"; do
			source "${lib}" || ptxd_bailout "failed to source lib: ${lib}"
		done
	done
	${PTX_NICE:+nice -n ${PTX_NICE}} "${PTXCONF_SETUP_HOST_MAKE}" \
	    "${PTX_MAKE_ARGS[@]}" ${PTXDIST_PARALLELMFLAGS_EXTERN} ${PTXDIST_LOADMFLAGS} \
	    -f "${RULESDIR}/other/Toplevel.make" "${@}" || return
}

#
# call make and log it
#
# supress stdout in quiet mode
#
ptxd_make_log() {(
	# stdout only
	exec {PTXDIST_FD_STDOUT}>&1
	# stderr only
	exec {PTXDIST_FD_STDERR}>&2
	# logfile only
	exec 9>> "${PTX_LOGFILE}"
	export PTXDIST_FD_STDOUT
	export PTXDIST_FD_STDERR
	export PTXDIST_FD_LOGFILE=9

	if [ -z "${PTXDIST_QUIET}" ]; then
		# stdout and logfile
		exec {logout}> >(tee -a "${PTX_LOGFILE}")
	else
		# logfile only
		exec {logout}>> "${PTX_LOGFILE}"
	fi
	# stderr and logfile
	exec {logerr}> >(tee -a "${PTX_LOGFILE}" >&2)

	ptxd_make "${@}" 1>&${logout} 2>&${logerr}
)}



#
# replaces @MAGIC@ with MAGIC from environment (if available)
# it will stay @MAGIC@ if MAGIC is unset in the environment
#
# $1		input file
# stdout:	output
#
ptxd_replace_magic() {
	gawk '
$0 ~ /@[A-Za-z0-9_]+@/ {
	line = $0

	while (match(line, "@[A-Za-z0-9_]+@")) {
		var = substr(line, RSTART + 1, RLENGTH - 2);
		line = substr(line, RSTART + RLENGTH);

		if (var in ENVIRON)
			gsub("@" var "@", ENVIRON[var]);
	}
}

{
	print;
}' "${1}"

}
export -f ptxd_replace_magic



#
#
#
ptxd_filter_dir() {
	local srcdir="${1}"
	local dstdir="${2}"
	local src dst

	[ -d "${srcdir}" ] || return
	[ -n "${dstdir}" ] || return

	mkdir -p "${dstdir}" &&

	tar -c -C "${srcdir}" \
		--exclude .svn \
		--exclude .pc \
		--exclude .git \
		--exclude "*.in" \
		--exclude "*.in.*" \
		--exclude "*/*~" \
		. \
		| tar -C "${dstdir}" -x
	check_pipe_status || return

	{
		find "${srcdir}" -name "*.in"
		find "${srcdir}" -name "*.in${PTXDIST_PLATFORMSUFFIX}"
	} | while read src; do
		dst="${src/#${srcdir}/${dstdir}/}"
		dst="${dst%.in}"
		ptxd_replace_magic "${src}" > "${dst}" || return
	done
}
export -f ptxd_filter_dir



#
# returns the concatination of two variables,
# the seperator can be specified, space is default
#
# $1	variable the will hold the concatinated value
# $2	first part
# $3	second part
# $4	separator (optional, space is default)
#
ptxd_var_concat()
{
	eval "${1}"=\"${2//\"/\\\"}${2:+${3:+${4:- }}}${3//\"/\\\"}\" || exit
}
#export -f ptxd_var_concat



#
# dump current callstack
# wait for keypress
#
ptxd_dumpstack() {
	local i=0

	{
		echo '############# stackdump #############'
		while caller $i; do
			let i++
		done
		echo '######## any key to continue ########'
	} >&2

	read
}

#
# ptxd_replace_link - atomically replace a symlink
# $1	source
# $2	target
#
ptxd_replace_link() {
	test -e "${2}" -a ! -L "${2}" && ptxd_bailout "'${2}' is not a link"

	ln -sfT "${1}" "${2}.tmp"
	mv -T "${2}.tmp" "${2}"
}
export -f ptxd_replace_link

ptxd_get_alternative_list() {
    local prefix="${1%/}"
    local file="${2#/}"
    local -a layers
    [ -n "${prefix}" -a -n "${file}" ] || return

    ptxd_in_path PTXDIST_PATH_LAYERS
    layers=( "${ptxd_reply[@]}" )

    ptxd_reply=()
    for layer in "${layers[@]}"; do
	ptxd_reply=( \
	    "${ptxd_reply[@]}" \
	    "${layer}/${prefix}${PTXDIST_PLATFORMSUFFIX}/${file}" \
	    "${layer}/${prefix}/${file}${PTXDIST_PLATFORMSUFFIX}" \
	    "${layer}/${PTXDIST_PLATFORMCONFIG_SUBDIR}/${prefix}/${file}${PTXDIST_PLATFORMSUFFIX}" \
	    "${layer}/${prefix}/${file}" \
	    "${layer}/${PTXDIST_PLATFORMCONFIG_SUBDIR}/${prefix}/${file}" \
	    )
    done
}
export -f ptxd_get_alternative_list

#
# ptxd_get_alternative - look for files in platform, BSP and ptxdist
#
# $1	path prefix (relative to ptxdist etc.)
# $2	filename
#
# return:
# 0 if files/dirs are found
# 1 if no files/dirs are found
#
# array "ptxd_reply" containing the found files
#
ptxd_get_alternative() {
    ptxd_get_alternative_list "${@}" &&
    ptxd_get_path "${ptxd_reply[@]}"
}
export -f ptxd_get_alternative

#
# ptxd_get_path - look for files and/or dirs
#
# return:
# 0 if files/dirs are found
# 1 if no files/dirs are found
#
# array "ptxd_reply" containing the found files/dirs
#
ptxd_get_path() {
    [ -n "${1}" ] || return

    ptxd_reply=( $(eval command ls -f -d "${@}" 2>/dev/null) )

    [ ${#ptxd_reply[@]} -ne 0 ]
}
export -f ptxd_get_path

#
# ptxd_get_path_fitered - look for files and/or dirs
#
# Like ptxd_get_path but skips paths that are symlinks to /dev/null
#
# return:
# 0 if files/dirs are found
# 1 if no files/dirs are found
#
# array "ptxd_reply" containing the found files/dirs
#
ptxd_get_path_filtered() {
    ptxd_get_path "${@}" || return

    set -- "${ptxd_reply[@]}"
    ptxd_reply=()

    while [ $# -gt 0 ]; do
	if [ "$(readlink -f "${1}")" != /dev/null ]; then
	    ptxd_reply[${#ptxd_reply[@]}]="${1}"
	fi
	shift
    done
    [ ${#ptxd_reply[@]} -ne 0 ]
}
export -f ptxd_get_path_filtered

#
# ptxd_in_path - look for files and/or dirs
#
# Note: the make implemenation in ptx/in-path must produce the same result.
#
# $1 variable name with paths separated by ":"
# $2 filename to find within these paths
#
# return:
# 0 if files/dirs are found
# 1 if no files/dirs are found
#
# array "ptxd_reply" containing the found files/dirs
#
ptxd_in_path() {
	local orig_IFS="${IFS}"
	local -a paths tmp
	local path
	local relative
	IFS=:
	tmp=( ${!1} )
	IFS="${orig_IFS}"
	for path in "${tmp[@]}"; do
	    local search
	    case "${path}" in
	    /*)
		paths=( "${paths[@]}" "${path}" )
		;;
	    *)
		if [ -n "${relative}" ]; then
		    ptxd_bailout "More than one relative path found in ${1}"
		fi
		relative=true
		ptxd_in_path PTXDIST_PATH_LAYERS "${path}" || continue
		paths=( "${paths[@]}" "${ptxd_reply[@]}" )
		;;
	    esac
	done
	paths=( "${paths[@]/%/${2:+/}${2}}" )
	ptxd_get_path "${paths[@]}"
}
export -f ptxd_in_path

#
# ptxd_in_platformconfigdir - find paths in platformconfigdir
#
# Note: the make implemenation in ptx/in-platformconfigdir must produce the
# same result.
#
# $1 filename to find
#
# If the filename is absolute then return the filename unchanged.
# Otherwise search in platformconfigdir in all layers for the file and
# return the first hit.
# If no file is found return ${PTXDIST_PLATFORMCONFIGDIR}/${1}
#
# return:
# The result is written to stdout.
#
ptxd_in_platformconfigdir() {
    case "${1}" in
    /*)
	echo "${1}"
	;;
    *)
	if ptxd_in_path PTXDIST_PATH_PLATFORMCONFIGDIR "${1}"; then
	    echo "${ptxd_reply[0]}"
	else
	    echo "${PTXDIST_PLATFORMCONFIGDIR}/${1}"
	fi
	;;
    esac
}
export -f ptxd_in_platformconfigdir

#
# convert a relative or absolute path into an absolute path
#
ptxd_abspath() {
	local fn dn
	if [ $# -ne 1 ]; then
		echo "usage: ptxd_abspath <path>"
		exit 1
	fi
	if [ -d "${1}" ]; then
		fn=""
		dn="${1}"
	else
		fn="/$(basename "${1}")"
		dn="$(dirname "${1}")"
	fi

	[ ! -d "${dn}" ] && ptxd_bailout "directory '${dn}' does not exist"
	echo "$(cd "${dn}" && pwd)${fn}"
}
export -f ptxd_abspath


#
# calculate the relative path from one absolute path to another
#
# $1	from path
# $2	to path
#
ptxd_abs2rel() {
	local from from_parts to to_parts max orig_IFS
	if [ $# -ne 2 ]; then
		ptxd_bailout "usage: ptxd_abs2rel <from> <to>"
	fi

	from="${1}"
	to="${2}"

	orig_IFS="${IFS}"
	IFS="/"
	from_parts=(${from#/})
	to_parts=(${to#/})

	if [ ${#from_parts[@]} -gt ${#to_parts[@]} ]; then
		max=${#from_parts[@]}
	else
		max=${#to_parts[@]}
	fi

	for ((i = 0; i < ${max}; i++)); do
		from="${from_parts[i]}"
		to="${to_parts[i]}"

		if [ "${from}" = "${to}" ]; then
			unset from_parts[$i]
			unset to_parts[$i]
		elif [ -n "${from}" ]; then
			from_parts[$i]=".."
		fi
	done

	echo "${from_parts[*]}${from_parts[*]:+/}${to_parts[*]}"
	IFS="${orig_IFS}"
}
export -f ptxd_abs2rel

#
# Converts a file URL into an absolute path
#
ptxd_file_url_path() {
    local url="${1//file:\/\//}"
    url="${url//lndir:\/\//}"
    if [[ ! "${url}" =~ ^/ ]]; then
	    # relative to absolute path
	    if ptxd_in_path PTXDIST_PATH_LAYERS "${url}"; then
		url="${ptxd_reply}"
	    else
		url="${PTXDIST_WORKSPACE}/${url}"
	    fi
    fi
    echo "${url}"
}
export -f ptxd_file_url_path

#
# prints a path but removes non interesting prefixes
#
ptxd_print_path() {

    if [ $# -ne 1 ]; then
	ptxd_bailout "number of arguments must be 1"
    fi

    local path out
    for path in ${PTXDIST_WORKSPACE} ${PTXDIST_TOPDIR}; do
	path="${path%/*}/"
	out="${1/#${path}}"
	if [ "${out}" != "${1}" ]; then
	    break;
	fi
    done

    echo "${out}"

}
export -f ptxd_print_path


#
# convert a human readable number with [kM] suffix or 0x prefix into a number
#
ptxd_human_to_number() {
	local num
	if [ ${#} -ne 1 ]; then
		echo "usage: ptxd_human_to_number <number>"
		exit 1
	fi

	num=$(sed 's/m$/*1024*1024/I' <<< "${1}")
	num=$(sed 's/k$/*1024/I' <<< "${num}")

	echo $((num))
}

#
# convert a package name into its make_name (i.e. host-foo -> HOST_FOO)
#
ptxd_name_to_NAME() {
	local name
	if [ ${#} -ne 1 ]; then
		echo "usage: ptxd_name_to_NAME <pkg-name>"
		exit 1
	fi
	tr 'a-z-' 'A-Z_' <<< "${1}"
}
export -f ptxd_name_to_NAME

#
# customized exit functions
#
# $1 --> Error Message
# $2 --> Exit Code
#
ptxd_exit(){
	echo "$0: $1"
	exit $2
}

ptxd_exit_silent(){
	ptxd_debug "$0: $1"
	exit $2
}

#
# Debugging Output
#
ptxd_debug(){
	if [ "${PTX_DEBUG}" = "true" ]; then
		echo "$0: ${@}" >&2
	fi
}

ptxd_debug "Debugging is enabled - Turn off with PTX_DEBUG=false"

ptxd_bailout_impl() {
	echo
	while [ $# -gt 0 ]; do
		if [[ $# -eq 1 && "$1" =~ ^[0-9]+$ ]]; then
			break
		fi
		echo -e "${PTXDIST_LOG_PROMPT}error: ${1}"
		shift
	done
	echo
	return ${1:-1}
}
export -f ptxd_bailout_impl

#
# print out error message and exit with status 1
#
# $*: error messages, one line per argument
#
# If the last argument is a number, then it is used as exit value
# (1 is default)
#
# ${PTXDIST_LOG_PROMPT}: to be printed before message
#
ptxd_bailout() {
	if [ -n "${PTXDIST_FD_STDERR}" -a -n "${PTXDIST_QUIET}" ]; then
		ptxd_bailout_impl "${@}"  >&${PTXDIST_FD_STDERR}
	fi
	ptxd_bailout_impl "${@}" >&2
	exit
}
export -f ptxd_bailout


#
# print out error message
# if PTXDIST_PEDANTIC is true exit with status 1
#
# $1: error message
# $2: optional exit value (1 is default)
#
# ${PTXDIST_LOG_PROMPT}: to be printed before message
#
ptxd_pedantic() {
	echo "${PTXDIST_LOG_PROMPT}error: $1" >&2
	if [ "$PTXDIST_PEDANTIC" = "true" ]; then
		exit ${2:-1}
	fi
}
export -f ptxd_pedantic


#
# print out warning message
#
# $1: warning message
# ${PTXDIST_LOG_PROMPT}: to be printed before message
#
ptxd_warning() {
	while [ $# -gt 0 ]; do
		echo -e "${PTXDIST_LOG_PROMPT}warning: $1" >&2
		shift
	done
}
export -f ptxd_warning

#
# print a message if verbose building is enabled
# the message will always be written to the logfile
#
ptxd_verbose() {
	if [ "${PTXDIST_VERBOSE}" == "1" ]; then
		echo "${PTXDIST_LOG_PROMPT}""${@}"
	elif [ -n "${PTXDIST_FD_LOGFILE}" ]; then
		echo "${PTXDIST_LOG_PROMPT}""${@}" >&9
	fi
}
export -f ptxd_verbose

#
# execute the arguments with eval
#
ptxd_eval() {
	ptxd_verbose "executing:" "${@}
"
	eval "${@}"
}
export -f ptxd_eval

#
# check if a previously executed pipe returned an error
#
check_pipe_status() {
	for _pipe_status in "${PIPESTATUS[@]}"; do
		if [ ${_pipe_status} -ne 0 ]; then
			return ${_pipe_status}
		fi
	done
}
export -f check_pipe_status


#
# $1: lib_path	# cannolocilized path to lib or link
#
ptxd_lib_sysroot() {
	local lib_path lib lib_dir prefix tmp

	lib_path="${1}"
	lib="$(basename "${lib_path}")"
	lib_dir="$(dirname "${lib_path}")"

	# try to identify sysroot part of that path
	for prefix in {/usr,}/lib{64,32,}{/tls,/gconv,} ""; do
		tmp="${lib_dir%${prefix}}"
		if test "${lib_dir}" != "${tmp}"; then
			echo "${tmp}"
			return
		fi
	done

	return 1
}
export -f ptxd_lib_sysroot

#
# split ipkg filename into it's parts
#
# input format:
#
# "name_1.2.3-4_arm.ipk", packet revision (-4) is optional
#
# output format:
#
# - "name arm 1.2.3 4" if packet revision exists
# - "name arm 1.2.3"   if packet revision doesn't exist
#
ptxd_ipkg_split() {
	local name=`echo $1 | sed -e "s/\(.*\)_\(.*\)_\(.*\).ipk/\1/"`
	local rev=`echo $1 | sed -e "s/\(.*\)_\(.*\)_\(.*\).ipk/\2/"`
	local arch=`echo $1 | sed -e "s/\(.*\)_\(.*\)_\(.*\).ipk/\3/"`
	local rev_upstream=`echo $rev | sed -e "s/\(.*\)-\(.*\)/\1/"`
	local rev_packet=""
	[ `echo $rev | grep -e "-"` ] && rev_packet=`echo $rev | sed -e "s/\(.*\)-\(.*\)/\2/"`
	if [ "$rev_upstream" = "" ] && [ "$rev_packet" = "" ]; then
		rev_upstream=$rev
	fi
	echo "$name $arch $rev_upstream $rev_packet"
}

#
# get name part of already split ipkg filename
#
ptxd_ipkg_name() {
	echo $1
}

#
# get upstream revision part of already split ipkg filename
#
ptxd_ipkg_rev_upstream() {
	echo $3
}

#
# get packet revision part of already split ipkg filename
#
ptxd_ipkg_rev_package() {
	echo $4
}

#
# get architecture part of already split ipkg filename
#
ptxd_ipkg_arch() {
	echo $2
}

#
#
ptxd_ipkg_rev_decimal_convert() {
	local ver=$*
	while echo $ver | grep -q '[^0-9.~]'
	do
		local char="$(sed 's/.*\([^0-9.~]\).*/\1/' <<< $ver)"
		local char_dec="$(echo $(od -b -N1 -An <<< $char))"
		ver="${ver//$char/.$char_dec}"
	done

	ver="$(sed -r "s/\.?~/.-1./g" <<< $ver)"
	ver="${ver//../.0}"
	ver="${ver#.}"

	echo "$ver"
}

#
#
ptxd_ipkg_do_version_check() {
	local ver1=$1
	local ver2=$2

	[ "$ver1" == "$ver2" ] && return 10

	local ver1front=`echo $ver1 | cut -d . -f 1`
	local ver1back=`echo $ver1 | cut -d . -f 2-`
	local ver2front=`echo $ver2 | cut -d . -f 1`
	local ver2back=`echo $ver2 | cut -d . -f 2-`

	if [ "$ver1front" != "$ver1" -o "$ver2front" != "$ver2" ]
	then
		[ "$ver1front" -lt "$ver2front" ] && return 9
		[ "$ver1front" -gt "$ver2front" ] && return 11

		[ "$ver1front" == "$ver1" ] || [ -z "$ver1back" ] && ver1back=0
		[ "$ver2front" == "$ver2" ] || [ -z "$ver2back" ] && ver2back=0
		ptxd_ipkg_do_version_check "$ver1back" "$ver2back"
		return $?
	else
		[ "$ver1" -lt "$ver2" ] && return 9 || return 11
	fi
}

#
#
ptxd_ipkg_rev_smaller() {

	local first=`ptxd_ipkg_split $1`
	local first_rev_upstream=`ptxd_ipkg_rev_upstream $first`
	local first_rev_packet=`ptxd_ipkg_rev_package $first`
	local second=`ptxd_ipkg_split $2`
	local second_rev_upstream=`ptxd_ipkg_rev_upstream $second`
	local second_rev_packet=`ptxd_ipkg_rev_package $second`

	if [ "$first_rev_upstream" != "$second_rev_upstream" ]
	then
		local first_rev_upstream_decimal=`ptxd_ipkg_rev_decimal_convert $first_rev_upstream`
		local second_rev_upstream_decimal=`ptxd_ipkg_rev_decimal_convert $second_rev_upstream`
		ptxd_ipkg_do_version_check "$first_rev_upstream_decimal" "$second_rev_upstream_decimal"
		case "$?" in
			9)
				return 0;
				;;
			10)
				;;
			11)
				return 1;
				;;
			*)
				ptxd_error "issue while checking upstream revisions"
		esac
	fi

	[ $first_rev_packet -lt $second_rev_packet ] && return 0
	[ $first_rev_packet -gt $second_rev_packet ] && return 1

	ptxd_error "packets $1 and $2 have the same revision"
}
