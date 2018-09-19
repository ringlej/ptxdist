#!/bin/bash
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# migrate a config file
# look in PTX_MIGRATEDIR for a migration handler and call it
#
# $1	part identifier ("ptx", "platform", "collection", "board", "user")
#
ptxd_kconfig_migrate() {
    local part="${1}"
    local assistent="${PTX_MIGRATEDIR}/migrate_${part}"

    if [ \! -f "${assistent}" ]; then
	return 0
    fi

    cp -- ".config" ".config.old" || return
    sed -f "${assistent}" ".config.old" > ".config"
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
	echo "${PTXDIST_LOG_PROMPT}error: invalid use of '${FUNCNAME} ${@}'"
	echo
	exit 1
	;;
    esac

    local confdir="${PTXDIST_TEMPDIR}/kconfig"
    if [ ! -d "${confdir}" ]; then
	mkdir -p "${confdir}" || ptxd_bailout "unable to create tmpdir"
	pushd "${confdir}" > /dev/null

	ln -sf "${PTXDIST_TOPDIR}/rules" &&
	mkdir config &&
	ptxd_in_path PTXDIST_PATH config &&
	for dir in "${ptxd_reply[@]}"; do
	    local tmp
	    for tmp in $( ( cd "${dir}" && ls ) 2>/dev/null); do
		if [ ! -e "config/${tmp}" ]; then
		    ln -sfT "${dir}/${tmp}" "config/${tmp}" || break
		fi
	    done
	done &&
	ln -sf "${PTXDIST_TOPDIR}/platforms" &&
	ln -sf "${PTXDIST_WORKSPACE}" workspace &&
	ln -sf "${PTX_KGEN_DIR}/generated"
    else
	pushd "${confdir}" > /dev/null
    fi &&

    if [ -e "${file_dotconfig}" ]; then
	cp -- "${file_dotconfig}" ".config" || return
    fi

    local conf="${PTXDIST_TOPDIR}/scripts/kconfig/conf"
    local mconf="${PTXDIST_TOPDIR}/scripts/kconfig/mconf"
    local nconf="${PTXDIST_TOPDIR}/scripts/kconfig/nconf"

    export \
	KCONFIG_NOTIMESTAMP="1" \
	PROJECT="ptxdist" \
	FULLVERSION="${PTXDIST_VERSION_FULL}"

    case "${config}" in
    menuconfig)
	"${mconf}" "${file_kconfig}"
	;;
    nconfig)
	"${nconf}" "${file_kconfig}"
	;;
    oldconfig)
	#
	# In silent mode, we cannot redirect input. So use
	# oldconfig instead of silentoldconfig if somebody
	# tries to automate us.
	#
	ptxd_kconfig_migrate "${part}" &&
	if tty -s; then
	    "${conf}" --silentoldconfig "${file_kconfig}"
	else
	    "${conf}" --oldconfig "${file_kconfig}"
	fi
	;;
    all*config|randconfig)
	"${conf}" --${config} "${file_kconfig}"
	;;
    dep)
	copy_back="false"
	KCONFIG_ALLCONFIG=".config" "${conf}" \
	    --writedepend --alldefconfig "${file_kconfig}" &&
	mv -- ".config" "${PTXDIST_DGEN_DIR}/${part}config"
	;;
    *)
	echo
	echo "${PTXDIST_LOG_PROMPT}error: invalid use of '${FUNCNAME} ${@}'"
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

    return $retval
}
export -f ptxd_kconfig
