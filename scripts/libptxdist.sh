#!/bin/bash

PTX_DEBUG=${PTX_DEBUG:="false"}

#
# awk script for permission fixing
#
DOPERMISSIONS='{ if ($1 == "f") printf("chmod %s .%s; chown %s.%s .%s;\n", $5, $2, $3, $4, $2); if ($1 == "n") printf("mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $5, $2, $6, $7, $8, $3, $4, $2);}'


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
	local config config_source

	config="${1}"
	config_source="${PTXDIST_TEMPDIR}/${config##*/}"

	if test \! -e "${config}"; then
		return 1
	fi

	sed -e "s/^\([^#]*=.*\)/export \1/" "${config}" > "${config_source}"
	. "${config_source}" || return
}


#
# get a symbol from the ptx or platformconfig
#
# return:
# 1: symbol not found
# 2: symbol invalid
# 3: config file broken
#
ptxd_get_ptxconf() {
	unset "${1}" 2>/dev/null || return 2

	if test -f "${PTXDIST_PLATFORMCONFIG}"; then
		source "${PTXDIST_PLATFORMCONFIG}" || \
		ptxd_bailout "unable to source '${PTXDIST_PLATFORMCONFIG}' (maybe git conflict?)" 3
	fi
	if [ -n "${!1}" ]; then
		echo "${!1}"
		return
	fi

	if test -f "${PTXDIST_PTXCONFIG}"; then
		source "${PTXDIST_PTXCONFIG}"  || \
		ptxd_bailout "unable to source '${PTXDIST_PTXCONFIG}' (maybe git conflict?)" 3
	fi
	if [ -n "${!1}" ]; then
		echo "${!1}"
		return
	fi

	return 1;
}
export -f ptxd_get_ptxconf



#
# migrate a config file
# look in PTX_MIGRATEDIR for a migration handler and call it
#
# $1	part identifier ("ptx", "platform", "collection", "board", "user")
#
ptxd_kconfig_migrate() {
	local part="${1}"
	local assistent="${PTX_MIGRATEDIR}/migrate_${part}"

	if [ \! -x "${assistent}" ]; then
		return 0
	fi

	cp -- ".config" ".config.old" || return
	"${assistent}" ".config.old" > ".config"
	retval=$?

	if [ $retval -ne 0 ]; then
		ptxd_dialog_msgbox "error: error occured during migration"
		return ${retval}
	fi

	if ! diff -u ".config.old" ".config" >/dev/null; then
		ptxd_dialog_msgbox "info: successfully migrated '${file_dotconfig}'"
	fi

	return ${retval}
}

ptxd_kconfig_local_prepare() {
	local part="${1}"
	local assistent="${PTXDIST_WORKSPACE}/prepare_${part}"

	if [ \! -x "${assistent}" ]; then
		return 0
	fi

	. "${assistent}"
	retval=$?

	if [ ${retval} -ne 0 ]; then
		ptxd_dialog_msgbox "error: error occured in prepare_${part}"
	fi

	return ${retval}
}

#
# $1	what kind of config ("oldconfig", "menuconfig", "dep")
# $2	part identifier ("ptx", "platform", "collection", "board", "user")
# $...	optional parameters
#
ptxd_kconfig() {
	local config="${1}"
	local part="${2}"
	local copy_back="true"

	ptxd_kgen "${part}" || ptxd_bailout "error in kgen"

	local file_kconfig file_dotconfig

	case "${part}" in
	ptx)
		if [ -e "${PTXDIST_WORKSPACE}/Kconfig" ]; then
			file_kconfig="${PTXDIST_WORKSPACE}/Kconfig"
		else
			file_kconfig="config/Kconfig"
		fi
		file_dotconfig="${PTXDIST_PTXCONFIG}"
		;;
	platform)
		if [ -e "${PTXDIST_WORKSPACE}/platforms/Kconfig" ]; then
			file_kconfig="${PTXDIST_WORKSPACE}/platforms/Kconfig"
		else
			file_kconfig="${PTXDIST_TOPDIR}/platforms/Kconfig"
		fi
		file_dotconfig="${PTXDIST_PLATFORMCONFIG}"
		;;
	collection)
		ptxd_dgen || ptxd_bailout "error in dgen"

		#
		# "PTXDIST_COLLECTIONCONFIG" would overwrite
		# certain "m" packages with "y".
		#
		# but "menuconfig collection" works only on the
		# "m" packages, so unset PTXDIST_COLLECTIONCONFIG
		# here.
		#
		PTXDIST_COLLECTIONCONFIG="" ptxd_colgen || ptxd_bailout "error in colgen"

		file_kconfig="${PTXDIST_TOPDIR}/config/collection/Kconfig"
		file_dotconfig="${3}"
		;;
	board)
		if [ -e "${PTXDIST_WORKSPACE}/boardsetup/Kconfig" ]; then
			file_kconfig="${PTXDIST_WORKSPACE}/boardsetup/Kconfig"
		else
			file_kconfig="${PTXDIST_TOPDIR}/config/boardsetup/Kconfig"
		fi
		file_dotconfig="${PTXDIST_BOARDSETUP}"
		;;
	user)
		file_kconfig="${PTXDIST_TOPDIR}/config/setup/Kconfig"
		file_dotconfig="${PTXDIST_PTXRC}"
		;;
	*)
		echo
		echo "${PROMPT}error: invalid use of '${FUNCNAME} ${@}'"
		echo
		exit 1
		;;
	esac

	local tmpdir
	tmpdir="$(mktemp -d "${PTXDIST_TEMPDIR}/kconfig.XXXXXX")" || ptxd_bailout "unable to create tmpdir"
	pushd "${tmpdir}" > /dev/null

	ln -sf "${PTXDIST_TOPDIR}/rules" &&
	ln -sf "${PTXDIST_TOPDIR}/config" &&
	ln -sf "${PTXDIST_TOPDIR}/platforms" &&
	ln -sf "${PTXDIST_WORKSPACE}" workspace &&
	ln -sf "${PTX_KGEN_DIR}/${part}" generated || return

	if [ -e "${file_dotconfig}" ]; then
		cp -- "${file_dotconfig}" ".config" || return
	fi

	local conf="${PTXDIST_TOPDIR}/scripts/kconfig/conf"
	local mconf="${PTXDIST_TOPDIR}/scripts/kconfig/mconf"

	export \
	    KCONFIG_NOTIMESTAMP="1" \
	    PROJECT="ptxdist" \
	    FULLVERSION="${PTXDIST_VERSION_FULL}"

	ptxd_kconfig_local_prepare ${part} || ptxd_bailout "error in local_prepare"

	case "${config}" in
	menuconfig)
		"${mconf}" "${file_kconfig}"
		;;
	oldconfig)
		#
		# In silent mode, we cannot redirect input. So use
		# oldconfig instead of silentoldconfig if somebody
		# tries to automate us.
		#
		ptxd_kconfig_migrate "${part}" &&
		if tty -s; then
			"${conf}" -s "${file_kconfig}"
		else
			"${conf}" -o "${file_kconfig}"
		fi
		;;
	allmodconfig)
		"${conf}" -m "${file_kconfig}"
		;;
	allyesconfig)
		"${conf}" -y "${file_kconfig}"
		;;
	allnoconfig)
		"${conf}" -n "${file_kconfig}"
		;;
	dep)
		copy_back="false"
		yes "" | "${conf}" -O "${file_kconfig}" &&
		cp -- ".config" "${PTXDIST_DGEN_DIR}/${part}config"
		;;
	*)
		echo
		echo "${PROMPT}error: invalid use of '${FUNCNAME} ${@}'"
		echo
		exit 1
		;;
	esac

	local retval=${?}
	unset \
	    KCONFIG_NOTIMESTAMP \
	    PROJECT \
	    FULLVERSION

	if [ ${retval} -eq 0 -a "${copy_back}" = "true" ]; then
		cp -- .config "${file_dotconfig}" || return
		if [ -f .config.old ]; then
			cp -- .config.old "$(readlink -f "${file_dotconfig}").old" || return
		fi
	fi

	popd > /dev/null
	rm -fr "${tmpdir}"

	return $retval
}


#
# call make,
# source shell libraries wich are used in make
# ("scripts/lib/ptxd_make_"*.sh)
#
ptxd_make() {
	for lib in "${SCRIPTSDIR}/lib/ptxd_make_"*.sh; do
		source "${lib}" || ptxd_bailout "failed to source lib: ${lib}"
	done
	"${PTXCONF_SETUP_HOST_MAKE}" \
	    "${PTX_MAKE_ARGS[@]}" "${PTXDIST_PARALLELMFLAGS_EXTERN}" \
	    -f "${RULESDIR}/other/Toplevel.make" "${@}" || return
}

#
# call make and log it
#
# supress stdout in quiet mode
#
ptxd_make_log() {
	if [ -z "${PTXDIST_QUIET}" ]; then
		{
			{
				ptxd_make "${@}" 3>&- |
				tee -a "${PTX_LOGFILE}" 2>&3 3>&-
				check_pipe_status || return
			} 2>&1 >&4 4>&- |
			tee -a "${PTX_LOGFILE}" >&2 3>&- 4>&-
			check_pipe_status || return
		} 3>&2 4>&1
	else
		exec 3>> "${PTX_LOGFILE}"
		ptxd_make "${@}" 2>&1- 1>&3 | tee -a "${PTX_LOGFILE}" 3>&-
		check_pipe_status || return
		exec 3>&-
	fi
}



#
# replaces @MAGIC@ with MAGIC from environment
#
# $1		input file
# stdout:	output
#
ptxd_replace_magic() {
	gawk '
$0 ~ /@[A-Z0-9_]+@/ {
	while (match($0, "@[A-Z0-9_]+@")) {
		var = substr($0, RSTART+1, RLENGTH-2);
		gsub("@" var "@", ENVIRON[var]);
	}
}

{
	print;
}' "${1}"

}
export -f ptxd_replace_magic



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
# convert a relative or absolute path into an absolute path
#
ptxd_abspath() {
	if [ $# -ne 1 ]; then
		echo "usage: ptxd_abspath <path>"
		exit 1
	fi

	local dn="$(dirname "${1}")"
	[ ! -d "${dn}" ] && ptxd_bailout "directory '${dn}' does not exist"
	echo "$(cd "${dn}" && pwd)/$(basename "${1}")"
}
export -f ptxd_abspath



#
# convert a human readable number with [kM] suffix or 0x prefix into a number
#
ptxd_human_to_number() {
	local num
	if [ ${#} -ne 1 ]; then
		echo "usage: ptxd_human_to_number <number>"
		exit 1
	fi

	num=$(echo "$1" | sed 's/m$/*1024*1024/I')
	num=$(echo "$num" | sed 's/k$/*1024/I')

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
	name="$(echo "${1}" | tr 'a-z-' 'A-Z_')"
	echo "${name}"
}

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

#
# print out error message and exit with status 1
#
# $1: error message
# $2: optional exit value (1 is default)
#
# ${PREFIX}: to be printed before message
#
ptxd_bailout() {
	echo "${PREFIX}error: $1" >&2
	exit ${2:-1}
}
export -f ptxd_bailout


#
# print out warning message
#
# $1: warning message
# ${PREFIX}: to be printed before message
#
ptxd_warning() {
	echo "${PREFIX}warning: $1" >&2
}
export -f ptxd_warning


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
ptxd_ipkg_rev_smaller() {

	local first=`ptxd_ipkg_split $1`
	local first_rev_upstream=`ptxd_ipkg_rev_upstream $first`
	local first_rev_packet=`ptxd_ipkg_rev_package $first`
	local second=`ptxd_ipkg_split $2`
	local second_rev_upstream=`ptxd_ipkg_rev_upstream $second`
	local second_rev_packet=`ptxd_ipkg_rev_package $second`
	local first_major=`echo $first_rev_upstream | awk -F. '{print $1}'`
	local first_minor=`echo $first_rev_upstream | awk -F. '{print $2}'`
	local first_micro=`echo $first_rev_upstream | awk -F. '{print $3}'`
	local second_major=`echo $second_rev_upstream | awk -F. '{print $1}'`
	local second_minor=`echo $second_rev_upstream | awk -F. '{print $2}'`
	local second_micro=`echo $second_rev_upstream | awk -F. '{print $3}'`

	[ $first_major -lt $second_major ] && return 0
	[ $first_major -gt $second_major ] && return 1
	[ $first_minor -lt $second_minor ] && return 0
	[ $first_minor -gt $second_minor ] && return 1
	[ $first_micro -lt $second_micro ] && return 0
	[ $first_micro -gt $second_micro ] && return 1
	[ $first_rev_packet -lt $second_rev_packet ] && return 0
	[ $first_rev_packet -gt $second_rev_packet ] && return 1

	ptxd_error "packets $1 and $2 have the same revision"
}



#
# create generic option parser
# <stdin> --> Option List:
# SYMBOL NAME HELPTEXT
#
# proof of concept / test implementation
# FIXME: This should be read and written
#        without tmpfiles and it is nasty anyway ;-)
#
# Use at your own risk

ptxd_generic_option_parser(){
TMPDIR=`mktemp -d /tmp/ptxdist.XXXXXX` || exit 1
INFILE=$TMPDIR/infile
OUTFILE=$TMPDIR/outfile
while read line ; do
	echo $line >> $INFILE
done
cat << EOF > $OUTFILE

check_argument(){
case "\$1" in
	--*|"")
	ptxd_debug "missing argument"
	return 1
	;;
	[[:alnum:]/]*)
	return 0
	;;
esac
}

usage() {
	echo
	[ -n "\$1" ] && echo -e "\${PREFIX} error: \$1\n"
	echo "$PROGRAM_DESCRIPTION"
	echo
	echo "usage: \`basename \$0\` <args>"
	echo
	echo " Arguments:"
	echo
EOF
while read SYMBOL OPTION DESCRIPTION ; do
cat << EOF >> $OUTFILE
	echo -e "  --$OPTION\\t $DESCRIPTION"
EOF
done < $INFILE
cat << EOF >> $OUTFILE
	echo
	echo " \`basename \$0\` returns with an exit status != 0 if something failed."
	echo
	exit 0
}

#
# Option parser
#
# FIXME: rsc wants to reimplement this with getopt
#
invoke_parser(){
while [ \$# -gt 0 ]; do
	case "\$1" in

		--help) usage ;;
EOF
while read SYMBOL OPTION DESCRIPTION ; do
cat << EOF >> $OUTFILE
		--$OPTION)
			check_argument \$2
			if [ "\$?" = "0" ] ; then
				$SYMBOL="\$2";
				shift 2 ;
			else
				ptxd_debug "skipping option \$1";
				shift 1 ;
			fi
			;;
EOF
done < $INFILE
cat << EOF >> $OUTFILE
		*)
			usage "unknown option \$1"
			;;
	esac
done
}
# cleanup
rm -f $INFILE $OUTFILE || exit 1
rmdir $TMPDIR || exit 1
EOF
echo "$OUTFILE"
}
