#!/bin/bash

# 
# awk script for permission fixing
#
DOPERMISSIONS='{ if ($1 == "f") printf("chmod %s .%s; chown %s.%s .%s;\n", $5, $2, $3, $4, $2); if ($1 == "n") printf("mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $5, $2, $6, $7, $8, $3, $4, $2);}'


#
# convert a relative or absolute path into an absolute path
#
ptxd_abspath() {
	if [ "$#" != "1" ]; then
		echo "usage: abspath <path>"
		exit 1
	fi
	DN=`dirname $1`
	echo `cd $DN && pwd`/`basename $1`
}


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

