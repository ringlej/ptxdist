#!/bin/bash

if test -z "${PTXDIST_TOPDIR}"; then
	echo PTXDIST_TOPDIR is unset
	exit
fi

. ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh
. ${SCRIPTSDIR}/libptxdist.sh
. ${SCRIPTSDIR}/install_copy_toolchain.sh

usage() {
	echo
	echo "usage: $0 <args>"
	echo
	echo " Arguments:"
	echo
	echo "  -f charmap	character map file"
	echo "  -i definition	locale definitionfile"
	echo "  -p prefix	prefix dir"
	echo "  -n name		locale name"
	exit 1
}

add_locale() {
	local CHARMAP LOCALE_DEF PREF SYSROOT_USR LOCALE_NAME

	while getopts "f:i:p:n::" opt; do
		case "${opt}" in
		    f)
			CHARMAP="${OPTARG}"
			;;
		    i)
			LOCALE_DEF="${OPTARG}"
			;;
		    p)
			PREF="${OPTARG}"
			;;
		    n)
		    	LOCALE_NAME="${OPTARG}"
			;;
		    *)
			usage
			;;
		esac
	done

	SYSROOT_USR=`ptxd_get_sysroot_usr`
	[ ! -d ${SYSROOT_USR} ] && { echo "Toolchain sysroot dir not found"; exit 1; }

	if [ ! -d ${PREF}/usr/lib/locale ]; then
		mkdir -p ${PREF}/usr/lib/locale 
		[ $? -ne 0 ] && { echo "Could not create temporary locales directory ${PREF}/usr/lib/locale"; exit 1; }
	fi

	I18NPATH=${SYSROOT_USR}/share/i18n \
	localedef -i $LOCALE_DEF -f $CHARMAP $LOCALE_NAME --prefix=${PREF} 

	[ $? -ne 0 ] && { echo "calling localedef binary failed"; exit 1; }

	[ ! -n ${PREF}/usr/lib/locale/locale-archive ] && { echo "locale archive generation failed"; exit 1; }
}

add_locale "${@}"
exit 0
