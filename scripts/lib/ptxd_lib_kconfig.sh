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
export -f ptxd_kconfig_migrate


#
# nomalize the path to a config file
#
# $file_dotconfig the absolute path to the config file
#
# return:
# $relative_file_dotconfig	the config file relative to its layer
# $file_dotconfig		the nomalized absolute path:
#   ${PTXDIST_LAYERS[X]}/${relative_file_dotconfig}
#
ptxd_normalize_config() {
    local nomalized old
    nomalized="$(readlink -f "${file_dotconfig}")"
    old="${nomalized}"
    for layer in "${PTXDIST_LAYERS[@]}"; do
	nomalized="${nomalized/#$(readlink -f ${layer})\//${layer}/}"
    done
    if [ "$(readlink -f "${nomalized}")" != "${old}" ]; then
	ptxd_bailout "Failed to normalize filename:" \
	    "${file_dotconfig}" \
	    "and" \
	    "${nomalized}" \
	    "should be the same file!"
    fi
    if [ "${nomalized}" = "${old}" -a "${nomalized}" = "${nomalized#${PTXDIST_LAYERS[0]}}" ]; then
	ptxd_bailout "Failed to normalize filename:" \
	    "${file_dotconfig}" \
	    "must be located inside the BSP!"
    fi
    for layer in "${PTXDIST_LAYERS[@]}"; do
	local relative="${nomalized#${layer}/}"
	if [ "${relative}" != "${nomalized}" ]; then
	    relative_file_dotconfig="${relative}"
	fi
    done
    file_dotconfig="${nomalized}"

}
export -f ptxd_normalize_config


ptxd_kconfig_save_config() {
    local src="${1}"
    local dst="${2}"

    if cmp -s "${src}" "${dst}" &>/dev/null; then
	return
    fi

    echo "Saving '$(ptxd_print_path "${dst}")'."

    mkdir -p "$(dirname "${dst}")" &&
    if [ -e "${src}.old" ]; then
	cp -- "${src}.old" "$(readlink -f "${dst}").old"
    elif [ -e "${dst}" ]; then
	cp -- "${dst}" "$(readlink -f "${dst}").old"
    fi &&
    cp -- "${src}" "${dst}"
}
export -f ptxd_kconfig_save_config


ptxd_kconfig_create_config_merge() {
    local base="${1}"
    local target="${2}"
    local diff="${3}"
    local orig_IFS="${IFS}"
    local file_md5 saved_md5
    local diff_fd a b c prefix option arg
    local -a args cmd

    set -- $(md5sum "${target}")
    file_md5="${1}"

    ptxd_get_alternative scripts config || return
    cmd=( "${ptxd_reply}" "--file" "${target}" "-k" )

    IFS="="
    exec {diff_fd}< "${diff}"
    while read a b line <&${diff_fd}; do
	if [[ -z "${b}" && "${a}" =~ ^'# '[A-Z0-9_]*' is not set'$ ]]; then
	    a="${a% is not set}"
	    a="${a#\# }"
	    b="n"
	elif [ -z "${saved_md5}" -a -z "${b}" ]; then
	    saved_md5="${a}"
	    continue
	fi
	arg=
	case "${b}" in
	y)
	    option="-e"
	    ;;
	m)
	    option="-m"
	    ;;
	n)
	    option="-d"
	    ;;
	*)
	    option="--set-val"
	    arg="${b}"
	    ;;
	esac
	if [ -z "${prefix}" ]; then
	    prefix="${a%%_*}_"
	fi
	args[${#args[@]}]="${option}"
	args[${#args[@]}]="${a#${prefix}}"
	if [ -n "${arg}" ]; then
	    args[${#args[@]}]="${arg}"
	fi
	if [ ${#args[@]} -gt 50 ]; then
	    IFS="${orig_IFS}" CONFIG_="${prefix}" \
		"${cmd[@]}" "${args[@]}" || break
	    args=()
	fi
    done &&
    IFS="${orig_IFS}"
    CONFIG_="${prefix}" "${cmd[@]}" "${args[@]}" &&
    if [ "${file_md5}" != "${saved_md5}" ]; then
	echo -e "\nOutdated diff, forcing config update...\n"
	# this will be dropped, but forces kconfig to write the config
	echo "# ${prefix}OPTION_DOES_NOT_EXIST is not set" >> "${target}"
    fi
    touch -r "${target}" "${target}.stamp" &&
    if [ "$?" -ne 0 ]; then
	ptxd_bailout "Failed to apply" \
	    "$(ptxd_print_path "${diff}")" \
	    "to" \
	    "$(ptxd_print_path "${base}")"
    fi
}
export -f ptxd_kconfig_create_config_merge


ptxd_kconfig_create_config() {
    local target="${1}"
    local config="${2}"
    local diff="${config}.diff"
    local base="${3}"

    # base + diff == config
    # Be clever if files are missing:
    # if 'diff' is missing, use 'config' to create it
    # if 'diff' and 'config' are missing (= no changes) use 'base'
    # do nothing if all files are missing (needed for --force)
    if [ -n "${base}" -a \( -e "${diff}" -o ! -e "${config}" \) ]; then
	cp -- "${base}" "${target}" &&
	if [ -e "${diff}" ]; then
	    ptxd_kconfig_create_config_merge "${base}" "${target}" "${diff}"
	fi
    else
	if [ -e "${config}" ]; then
	    cp -- "${config}" "${target}"
	fi
    fi
}
export -f ptxd_kconfig_create_config


ptxd_kconfig_validate_config() {
    local relative_config="${1}"
    local file_md5 saved_md5
    local last next
    local -a layers

    if [ "${mode}" = update ]; then
	layers=( "${PTXDIST_LAYERS[@]:1}" )
    else
	layers=( "${PTXDIST_LAYERS[@]}" )
    fi

    for layer in "${layers[@]}"; do
	next="${layer}/${relative_config}"
	# no config in this layer
	if [ ! -e "${next}" -a ! -e "${next}.diff" ]; then
	    continue
	fi
	# explicitly skip this layer
	if [ "$(readlink -f "${next}")" = /dev/null ]; then
	    continue
	fi
	if [ -z "${last}" ]; then
	    last="${next}"
	    continue
	fi
	if [ ! -e "${last}" ]; then
	    ptxd_bailout "'$(ptxd_print_path "${last}")' is missing, run oldconfig!"
	fi
	if [ ! -e "${last}.diff" ]; then
	    ptxd_bailout "'$(ptxd_print_path "${last}.diff")' is missing, run oldconfig!"
	fi
	set -- $(md5sum "${next}")
	file_md5="${1}"
	saved_md5="$(echo $(head -n1 "${last}.diff"))"
	if [ "${file_md5}" != "${saved_md5}" ]; then
	    ptxd_bailout "'$(ptxd_print_path "${last}.diff")' is not up to date, run oldconfig!"
	fi
	last="${next}"
    done
    if [ -e "${last}.diff" ]; then
	ptxd_bailout  "'$(ptxd_print_path "${last}.diff")' exists without a base layer!"
    fi
}
export -f ptxd_kconfig_validate_config


#
# find the config files to use
#
# return:
# $last_config config file for the current layer
# $base_config first existing config file to use
#
ptxd_kconfig_find_config() {
    local mode="${1}"
    local relative_config="${2}"
    local relative_ref_config="${3}"
    local -a layers

    if [ "${mode}" = run -o "${mode}" = "update" ]; then
	ptxd_kconfig_validate_config "${relative_config}" || return
    fi

    last_config="${PTXDIST_LAYERS[0]}/${relative_config}"
    if [ "$(readlink -f "${last_config}")" = /dev/null ]; then
	return 42
    fi

    if [ "${mode}" = update ]; then
	layers=( "${PTXDIST_LAYERS[@]:1}" )
    else
	base_config="${last_config}"
	layers=( "${PTXDIST_LAYERS[@]}" )
    fi

    for layer in "${layers[@]}"; do
	local tmp
	tmp="${layer}/${relative_config}"
	if [ "$(readlink -f "${tmp}")" = /dev/null ]; then
	    continue
	fi
	if [ -e "${tmp}" ]; then
	    base_config="${tmp}"
	    break
	fi
    done
    if [ "${mode}" = update -a -n "${relative_ref_config}" -a -z "${base_config}" ]; then
	ptxd_kconfig_find_config check "${relative_ref_config}" &&
	last_config="${PTXDIST_LAYERS[0]}/${relative_config}"
    fi
}
export -f ptxd_kconfig_find_config


ptxd_kconfig_setup_config() {
    local mode="${1}"
    local target_config="${2}"
    local relative_config="${3}"
    local absolute_config="${4}"
    local relative_ref_config="${5}"
    local last_config base_config

    ptxd_kconfig_find_config "${mode}" "${relative_config}" "${relative_ref_config}"
    case $? in
    42)
	echo "Skipping '$(ptxd_print_path "${last_config}")'..."
	return 42
	;;
    0) ;;
    *) return $?
    esac

    if [ "${config}" = oldconfig ]; then
	echo "Updating '$(ptxd_print_path "${last_config}")'..."
    fi &&
    if [ "${mode}" = update ]; then
	ptxd_kconfig_create_config "${target_config}" \
	    "${last_config}" "${base_config}"
    elif [ "${mode}" = single ]; then
	ptxd_kconfig_create_config "${target_config}" \
	    "${absolute_config}"
    else
	ptxd_kconfig_create_config "${target_config}" "${base_config}" &&
	if [ "${mode}" = run ]; then
	    if [ "${absolute_config}" != "${base_config}" ]; then
		ptxd_bailout "The selected config file:" \
		    "$(ptxd_print_path "${absolute_config}")" \
		    "is overwritten by:" \
		    "$(ptxd_print_path "${base_config}")" \
		    "The config file in the outer layer must be used!"
	    fi
	    echo -e "Using config file: '$(ptxd_print_path "${absolute_config}")'\n"
	fi
    fi || ptxd_bailout "Unexpected failure during config file setup!"
}
export -f ptxd_kconfig_setup_config


ptxd_kconfig_update_config() {
    local target_config="${1}"
    local config="${2}"
    local base_config="${3}"

    if [ "${target_config}" -ot "${target_config}.stamp" ]; then
	rm  -f "${target_config}.stamp"
	return
    fi
    rm  -f "${target_config}.stamp"

    if [ "${base_config}" = "${config}" -o -z "${base_config}" ]; then
	ptxd_kconfig_save_config "${target_config}" "${config}" &&
	echo
    else
	local tmp="$(mktemp "${PTXDIST_TEMPDIR}/config.XXXXXX")"
	set -- $(md5sum "${base_config}")
	echo "${1}" > "${tmp}" &&
	sort "${base_config}" > "${tmp}.base" &&
	sort "${target_config}" > "${tmp}.new" &&
	# take any new lines and sort by option name
	diff "${tmp}.base" "${tmp}.new" | \
	    sed -n 's/^> \(\(# \)\?[A-Z]*_\)/\1/p' | \
	    sed 's/^# \(.*\) is not set$/\1=n/' | sort | \
	    sed 's/^\([^=]*\)=n$/# \1 is not set/' >> "${tmp}" &&
	if [ $(wc -l < "${tmp}") -gt 1 ]; then
	    ptxd_kconfig_save_config "${target_config}" "${config}" &&
	    ptxd_kconfig_save_config "${tmp}" "${config}.diff" &&
	    echo
	else
	    # remove config and diff if the diff is empty
	    rm -f "${config}" "${config}.diff"
	fi
    fi
}
export -f ptxd_kconfig_update_config

ptxd_kconfig_sync_config() {
    local mode="${1}"
    local target_config="${2}"
    local relative_config="${3}"
    local relative_ref_config="${4}"
    local last_config base_config

    ptxd_kconfig_find_config "${mode}" "${relative_config}" "${relative_ref_config}" &&

    case "${mode}" in
    run)
	return
	;;
    check)
	if ! cmp -s "${target_config}" "${base_config}"; then
	    ptxd_bailout "Inconsistent config for '$(ptxd_print_path "${PTXDIST_LAYERS[0]}")'"
	fi
	return
	;;
    update)
	ptxd_kconfig_update_config "${target_config}" \
	    "${last_config}" "${base_config}"
	;;
    esac
}
export -f ptxd_kconfig_sync_config


ptxd_kconfig_update() {
    local mode
    if [ "${PTXDIST_LAYERS[0]}" = "${PTXDIST_TOPDIR}" ]; then
	# nothing to do for PTXdist itself
	return
    fi
    if [ "${config}" != dep ]; then
	(
	# call ptxd_kconfig_update() recursively after removing the last layer
	PTXDIST_LAYERS=( "${PTXDIST_LAYERS[@]:1}" )
	PTX_KGEN_DIR="${PTX_KGEN_DIR}.base"
	confdir="${confdir}.base"
	ptxd_init_ptxdist_path &&
	ptxd_kconfig_update
	ret=$?
	if [ "${ret}" -ne 42 ]; then
	    exit "${ret}"
	fi
	) || return
    fi

    case "${config}" in
    oldconfig)
	mode=update
	;;
    dep)
	mode=run
	;;
    *)
	# for recursive calls run 'update' for the last layer and 'check'
	# for all other layers
	if [ "${PTXDIST_LAYERS[0]}" = "${PTXDIST_WORKSPACE}" ]; then
	    mode=update
	else
	    mode=check
	fi
	;;
    esac
    if [ "${part}" = user ]; then
	mode=single
    fi

    ptxd_kgen "${part}" || ptxd_bailout "error in kgen"

    if [ ! -d "${confdir}" ]; then
	mkdir -p "${confdir}" || ptxd_bailout "unable to create tmpdir"
	cd "${confdir}"

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
	cd "${confdir}"
    fi &&

    ptxd_kconfig_setup_config "${mode}" .config \
	"${relative_file_dotconfig}" "${file_dotconfig}" &&

    if [ "${mode}" = check ]; then
	if ! "${conf}" --silentoldconfig "${file_kconfig}" < /dev/null; then
	    ptxd_bailout "Inconsistent config for '$(ptxd_print_path "${PTXDIST_LAYERS[0]}")'"
	fi
    else
	case "${config}" in
	menuconfig)
	    "${mconf}" "${file_kconfig}"
	    ;;
	nconfig)
	    "${nconf}" "${file_kconfig}"
	    ;;
	oldconfig)
	    ptxd_kconfig_migrate "${part}" &&
	    # migrate touches the config, so update the timestamp
	    touch -r ".config" ".config.stamp" &&
	    "${conf}" "${oldconfig}" "${file_kconfig}"
	    ;;
	all*config|randconfig)
	    "${conf}" --${config} "${file_kconfig}"
	    ;;
	dep)
	    KCONFIG_ALLCONFIG=".config" "${conf}" \
		--writedepend --alldefconfig "${file_kconfig}" &&
	    mv -- ".config" "${PTXDIST_DGEN_DIR}/${part}config"
	    return
	    ;;
	*)
	    ptxd_bailout "invalid use of '${FUNCNAME} ${@}'"
	    ;;
	esac
    fi &&

    ptxd_kconfig_sync_config "${mode}" .config \
	"${relative_file_dotconfig}"
}
export -f ptxd_kconfig_update


#
# $1	what kind of config ("oldconfig", "menuconfig", "dep")
# $2	part identifier ("ptx", "platform", "collection", "board", "user")
# $...	optional parameters
#
ptxd_kconfig() {
    local config="${1}"
    local part="${2}"

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
	ptxd_bailout "invalid use of '${FUNCNAME} ${@}'"
	;;
    esac

    local conf="${PTXDIST_TOPDIR}/scripts/kconfig/conf"
    local mconf="${PTXDIST_TOPDIR}/scripts/kconfig/mconf"
    local nconf="${PTXDIST_TOPDIR}/scripts/kconfig/nconf"

    export \
	KCONFIG_NOTIMESTAMP="1" \
	PROJECT="ptxdist" \
	FULLVERSION="${PTXDIST_VERSION_FULL}"

    local confdir="${PTXDIST_TEMPDIR}/kconfig"

    #
    # In silent mode, we cannot redirect input. So use
    # oldconfig instead of silentoldconfig if somebody
    # tries to automate us.
    #
    if tty -s; then
	local oldconfig="--silentoldconfig"
    else
	local oldconfig="--oldconfig"
    fi

    (
	if [ "${part}" != user ]; then
	    ptxd_normalize_config
	fi &&
	ptxd_kconfig_update
    ) || return

    unset \
	KCONFIG_NOTIMESTAMP \
	PROJECT \
	FULLVERSION
}
export -f ptxd_kconfig
