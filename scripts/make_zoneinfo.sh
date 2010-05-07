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
	echo "  -n name		zoneinfoe name"
        echo "  -p prefix       prefix dir"
	exit 1
}

add_zoneinfo() {
	local PREF ZONEINFO_NAME SYSROOT_USR
	while getopts "n:p:s:" opt; do
		case "${opt}" in
		    n)
		        ZONEINFO_NAME="${OPTARG}"
                        ;;
                    p)
                        PREF="${OPTARG}"
                        ;;
                    s)
                        SYSROOT_USR="${OPTARG}"
                        ;;
		    *)
			usage
			;;
		esac
	done

	[ -z ${SYSROOT_USR} ] && SYSROOT_USR=`ptxd_get_sysroot_usr`
	[ ! -d ${SYSROOT_USR} ] && { echo "Toolchain sysroot dir (${SYSROOT_USR}) not found"; exit 1; }
	[ ! -d ${SYSROOT_USR}/share/zoneinfo ] && { echo "Zoneinfo dir (${SYSROOT_USR}) not found"; exit 1; }

	if [ ! -d ${PREF}/zoneinfo ]; then
		mkdir -p ${PREF}/zoneinfo
		[ $? -ne 0 ] && { echo "Could not create temporary zoneinfo directory ${PREF}/usr/share/zoneinfo"; exit 1; }
	fi

	if [ -d ${SYSROOT_USR}/share/zoneinfo/${ZONEINFO_NAME} ]; then
		mkdir -p ${PREF}/zoneinfo/${ZONEINFO_NAME}
		[ $? -ne 0 ] && { echo "Could not create temporary zoneinfo directory ${PREF}/zoneinfo/${ZONEINFO_NAME}"; exit 1; }
		cp -R ${SYSROOT_USR}/share/zoneinfo/${ZONEINFO_NAME}/* ${PREF}/zoneinfo/${ZONEINFO_NAME}
		[ $? -ne 0 ] && { echo "Could not create temporary zoneinfo files ${PREF}/zoneinfo${ZONEINFO_NAME}"; exit 1; }
	else
		cp ${SYSROOT_USR}/share/zoneinfo/${ZONEINFO_NAME} ${PREF}/zoneinfo/${ZONEINFO_NAME}
		[ $? -ne 0 ] && { echo "Could not create temporary zoneinfo file ${PREF}/zoneinfo/${ZONEINFO_NAME}"; exit 1; }
	fi
}

add_zoneinfo "${@}"
exit 0
