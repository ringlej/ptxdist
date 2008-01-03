#!/bin/bash

FULLARGS="$@"
DEBUG=${DEBUG:="false"}

# 
# awk script for permission fixing
#
DOPERMISSIONS='{ if ($1 == "f") printf("chmod %s .%s; chown %s.%s .%s;\n", $5, $2, $3, $4, $2); if ($1 == "n") printf("mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $5, $2, $6, $7, $8, $3, $4, $2);}'


#
# We are really BAD :-)
#
# This makes it possible to use $(shell <shell code>) in ptxconfig
# files; if interpreted by make, it simply works, if interpreted by the
# shell it is replaced by the <shell code>
#
shell() {
	$*
}


ptxd_get_ptxconf() {
	if test -z "${_ptxd_get_ptxconf_sourced}"; then
	    if test -f "${PTXCONFIG}"; then
		source "${PTXCONFIG}"
		_ptxd_get_ptxconf_sourced=true
	    else
		return
	    fi
	fi

	echo "${!1}"
}

#
# $1	copy_back; "true" copies the .config file back to ptxdist
# $2	function that is called
# $#	all other parameters are given to $2
#
ptxd_kconfig() {
	local tmpdir fun copy_back ptxcnf

	copy_back="${1}"
	fun="${2}"
	tmpdir=`mktemp -d /tmp/ptxdist.XXXXXX`

	# search for kconfig
	if [ -z "${PTXDIST_KCONFIG}" ]; then
		if [ -e "${PTXDIST_WORKSPACE}/Kconfig" ]; then
			PTXDIST_KCONFIG="${PTXDIST_WORKSPACE}/Kconfig"
		else
			PTXDIST_KCONFIG="config/Kconfig"
		fi
	fi

	pushd $tmpdir > /dev/null
	ln -sf "${PTXDIST_TOPDIR}/rules"
	ln -sf "${PTXDIST_TOPDIR}/config"
	ln -sf "${PTXDIST_WORKSPACE}" workspace
	ptxcnf=`readlink -f "${PTXDIST_WORKSPACE}/ptxconfig"`
	cp "$ptxcnf" .config

	shift 2 # call ${fun} with the remaining arguments

	if ${fun} $* && [ "${copy_back}" = "true" ]; then
		cp .config "$ptxcnf"
	fi

	popd > /dev/null
	rm -fr $tmpdir
}


#
#
#
ptxd_make() {
	make $PTXDIST_MAKE_DBG -f "${PTXDIST_TOPDIR}/rules/other/Toplevel.make" PTXDIST_TOPDIR="${PTXDIST_TOPDIR}" $*
}



#
# convert a relative or absolute path into an absolute path
#
ptxd_abspath() {
	local DN
	if [ "$#" != "1" ]; then
		echo "usage: ptxd_abspath <path>"
		exit 1
	fi
	DN=`dirname $1`
	echo `cd $DN && pwd`/`basename $1`
}

#
# convert a human readable number with [kM] suffix or 0x prefix into a number
#
ptxd_human_to_number() {
	local num
	if [ "$#" != 1 ]; then
		echo "usage: ptxd_human_to_number <number>"
		exit 1
	fi

	num=$(echo "$1" | sed 's/m$/*1024*1024/I')
	num=$(echo "$num" | sed 's/k$/*1024/I')

	echo $((num))
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
	[ "$DEBUG" = "true" ] && echo "$0: $1" >&2
}	
ptxd_debug "Debugging is enabled - Turn off with DEBUG=false"

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
	for i in  "${PIPESTATUS[@]}"; do [ $i -gt 0 ] && {
		echo
		echo "error: a command in the pipe returned $i, bailing out"
		echo
		exit $i
	}
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

foobar() {
	echo "foobar $1"
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
