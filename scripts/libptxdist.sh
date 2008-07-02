#!/bin/bash

PTX_DEBUG=${PTX_DEBUG:="false"}

#
# awk script for permission fixing
#
DOPERMISSIONS='{ if ($1 == "f") printf("chmod %s .%s; chown %s.%s .%s;\n", $5, $2, $3, $4, $2); if ($1 == "n") printf("mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $5, $2, $6, $7, $8, $3, $4, $2);}'


PTX_DIALOG="dialog --aspect 60"
PTX_DIALOG_HEIGHT=0
PTX_DIALOG_WIDTH=0


ptxd_dialog_fselect_old() {
	local ptr="${1}"
	local _select="${!1:-${PWD}}"		# deref ptr or use $PWD as default

	exec 3>&1
	while [ -d "${_select}" -o \! -e "${_select}" ]; do
		_select="$(dialog \
			--output-fd 2 \
			--title "Please choose a ${ptr} file" \
			--fselect "${_select}/" 14 ${PTX_DIALOG_WIDTH} 2>&1 1>&3)" \
			|| return
	done
	exec 3>&-

	eval "${ptr}"="${_select}"
}



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
		_select="$(readlink -e ${_select})"
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
	local msg="${*}"
	IFS="${old_ifs}"

	if [ -n "${PTX_MENU}" ]; then
		${PTX_DIALOG} \
			--no-collapse \
			--${dialog}box "${msg}" ${PTX_DIALOG_HEIGHT} ${PTX_DIALOG_WIDTH}
	else
		echo -e "${msg}\n"
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
	local msg="${*}"
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
		return false
	fi

	sed -e "s/^\([^#]*=.*\)/export \1/" "${config}" > "${config_source}"
	. "${config_source}"
}


ptxd_get_ptxconf() {
	if test -f "${PTXDIST_PTXCONFIG}"; then
		source "${PTXDIST_PTXCONFIG}"
	fi
	if test -f "${PTXDIST_PLATFORMCONFIG}"; then
		source "${PTXDIST_PLATFORMCONFIG}"
	fi
	echo "${!1}"
}


#
# $1   config file (or a link to it)
# $2   function that is called
# $3   copy_back; "true" copies the .config file back
#
ptxd_kconfig() {
	local dotconfig="${1}"
	local fun="${2}"
	local copy_back="${3}"

	local tmpdir="$(mktemp -d "${PTXDIST_TEMPDIR}/kconfig.XXXXXX")"
	pushd "${tmpdir}" > /dev/null

	# search for kconfig
	if [ -e "${PTXDIST_WORKSPACE}/Kconfig" ]; then
		kconfig="${PTXDIST_WORKSPACE}/Kconfig"
	else
		kconfig="config/Kconfig"
	fi

	# search for platformconfig
	if [ -e "${PTXDIST_WORKSPACE}/platforms/Kconfig" ]; then
		kconfig_platform="${PTXDIST_WORKSPACE}/platforms/Kconfig"
	else
		kconfig_platform="${PTXDIST_TOPDIR}/platforms/Kconfig"
	fi

	ln -sf "${PTXDIST_TOPDIR}/rules"
	ln -sf "${PTXDIST_TOPDIR}/config"
	ln -sf "${PTXDIST_TOPDIR}/platforms"
	ln -sf "${PTXDIST_WORKSPACE}" workspace

	if [ -e "${dotconfig}" ]; then
		cp "${dotconfig}" .config
	fi

	export KCONFIG_NOTIMESTAMP="1"

	"${fun}"
	local retval=$?
	if [ ${retval} -eq 0 -a "${copy_back}" = "true" ]; then
		cp .config "${dotconfig}"
	fi

	unset KCONFIG_NOTIMESTAMP

	popd > /dev/null
	rm -fr $tmpdir

	return $retval
}


#
#
#
ptxd_make() {
	make ${PTX_MAKE_DBG} ${PTXDIST_PARALLELMFLAGS_EXTERN} -f "${RULESDIR}/other/Toplevel.make" "${@}"
}

ptxd_make_log() {
	if [ -z "${PTXDIST_QUIET}" ]; then
		ptxd_make "${@}" 2>&1 | tee -a "${PTX_LOGFILE}"
	else
		ptxd_make "${@}" > "${PTX_LOGFILE}"
	fi
	check_pipe_status
}



#
# convert a relative or absolute path into an absolute path
#
ptxd_abspath() {
	local dn
	if [ $# -ne 1 ]; then
		echo "usage: ptxd_abspath <path>"
		exit 1
	fi

	dn=`dirname $1`
	echo `cd $dn && pwd`/`basename $1`
}

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
# ${PREFIX}: to be printed before message
#
ptxd_bailout() {
	echo "${PREFIX}error: $1" >&2
	exit 1
}


#
# print out warning message
#
# $1: warning message
# ${PREFIX}: to be printed before message
#
ptxd_warning() {
	echo "${PREFIX}warning: $1" >&2
}


#
# check if a previously executed pipe returned an error
#
check_pipe_status() {
	for i in  "${PIPESTATUS[@]}"; do
		if [ ${i} -ne 0 ]; then
			echo
			echo "error: a command in the pipe returned ${i}, bailing out"
			echo
			exit $i
		fi
	done
}


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
	name=`echo $1 | sed -e "s/\(.*\)_\(.*\)_\(.*\).ipk/\1/"`
	rev=`echo $1 | sed -e "s/\(.*\)_\(.*\)_\(.*\).ipk/\2/"`
	arch=`echo $1 | sed -e "s/\(.*\)_\(.*\)_\(.*\).ipk/\3/"`
	rev_upstream=`echo $rev | sed -e "s/\(.*\)-\(.*\)/\1/"`
	rev_packet=""
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
ptxd_ipkg_rev_packet() {
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

	first=`ptxd_ipkg_split $1`
	first_rev_upstream=`ptxd_ipkg_rev_upstream $first`
	first_rev_packet=`ptxd_ipkg_rev_packet $first`
	second=`ptxd_ipkg_split $2`
	second_rev_upstream=`ptxd_ipkg_rev_upstream $second`
	second_rev_packet=`ptxd_ipkg_rev_packet $second`
	first_major=`echo $first_rev_upstream | awk -F. '{print $1}'`
	first_minor=`echo $first_rev_upstream | awk -F. '{print $2}'`
	first_micro=`echo $first_rev_upstream | awk -F. '{print $3}'`
	second_major=`echo $second_rev_upstream | awk -F. '{print $1}'`
	second_minor=`echo $second_rev_upstream | awk -F. '{print $2}'`
	second_micro=`echo $second_rev_upstream | awk -F. '{print $3}'`

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
# ptxd_compile_test: test-compile a configuration
#

ptxd_compile_test() {

	# Option parser
	while [ $# -gt 0 ]; do
		case "$1" in
		--path)
			PATH=$2;
			shift 2;
			;;
		--config-name)
			CONFIG_NAME=$2;
			shift 2;
			;;
		--ptxdist)
			PTXDIST_TOPDIR=$2;
			shift 2;
			;;
		*)
			echo "error: unknown argument: $1" >&2
			exit 1
		esac
	done

	# sanity checks
	if [ -z "$PTXDIST_TOPDIR" ]; then
		echo "error: PTXDIST_TOPDIR must be set with --ptxdist" >&2
		echo "error: commandline is $*" >&2
		exit 1
	fi

	LOGFILE=logfile
	OLD_DIR=`pwd`
	cd ${PTXDIST_WORKSPACE}

	echo config...: $CONFIG_NAME
	echo date.....: `date`
	echo user.....: $USER@$HOSTNAME

	make ${CONFIG_NAME}_config >> ${LOGFILE}

	if [ $? != "0" ]; then
		echo "result...: no config file '$CONFIG_NAME'"
		echo >> $LOGFILE
		exit 1
	fi

	make silentoldconfig >> $LOGFILE

	# Now start the compilation

	PTX_STARTTIME=`date +"%s"`
	(make world; echo PTX_RESULT=$?) > $LOGFILE 2>&1
	PTX_STOPTIME=`date +"%s"`
	PTX_RESULT=`grep PTX_RESULT logfile | awk -F"=" -- '{print $2}'`
	let "PTX_TIME=$PTX_STOPTIME-$PTX_STARTTIME"

	PTX_BUILDTIME_H=$(($PTX_TIME/3600))
	PTX_TIME=$(($PTX_TIME-$PTX_BUILDTIME_H*3600))
	PTX_BUILDTIME_M=$(($PTX_TIME/60))
	PTX_TIME=$(($PTX_TIME-$PTX_BUILDTIME_M*60))
	PTX_BUILDTIME_S=$PTX_TIME

	echo buildtime: ${PTX_BUILDTIME_H}h${PTX_BUILDTIME_M}m${PTX_BUILDTIME_S}s
	echo result...: $PTX_RESULT
	echo

	# save logfile
	mv logfile ${PTXDIST_WORKSPACE}/logs/${CONFIG_NAME}.log

	make distclean

	cd ${OLD_DIR}
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
