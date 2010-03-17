#!/bin/bash
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# -p PACKET
#
ptxd_make_install_init() {
    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return

    ptxd_make_xpkg_init || return

    local opt
    while getopts "p:t:" opt; do
	case "${opt}" in
	    p)
		local packet="${OPTARG}"
		;;
	    t)
		local target="${OPTARG##*/}"
		target="${target%%.targetinstall*}"
		;;
	    *)
		return 1
		;;
	esac
    done

    if [ -z "${packet}" ]; then
    	echo
	echo "Error: empty parameter to 'install_init()'"
	echo
	return 1
    fi

    echo "install_init:	preparing for image creation..."

    rm -fr   -- \
	"${pkg_xpkg_tmp}" \
	"${pkg_xpkg_cmds}" \
	"${pkg_xpkg_perms}" &&
    mkdir -p -- "${pkg_ipkg_control_dir}" &&
    touch "${pkg_xpkg_cmds}" || return

    local replace_from="ARCH"
    local replace_to="${PTXDIST_IPKG_ARCH_STRING}"

    echo -n "install_init:	@${replace_from}@ -> ${replace_to} ... "
    sed -e "s,@${replace_from}@,${replace_to},g" "${RULESDIR}/default.ipkg" > \
	"${pkg_ipkg_control}" || return
    echo "done"

    local script rd found
    for script in \
	preinst postinst prerm postrm; do

	echo -n "install_init:	${script} "
	unset found

	for rd in \
	    "${PROJECTRULESDIR}" "${RULESDIR}"; do

	    local abs_script="${rd}/${packet}.${script}"

	    if [ -f "${abs_script}" ]; then
		install -m 0755 \
		    -D "${abs_script}" \
		    "${pkg_ipkg_control_dir}/${script}" || return

		echo "packaging: '${abs_script}'"

		if [ "${script}" = "preinst" ]; then
		    echo "install_init:	executing '${abs_script}'"
		    DESTDIR="${ROOTDIR}" /bin/sh "${abs_script}" || return
		fi

		found=true
		break
	    fi
	done

	if [ -z "${found}" ]; then
	    echo "not available"
	fi
    done
}

export -f ptxd_make_install_init


#
#
#
ptxd_make_install_fixup() {
    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return

    ptxd_make_xpkg_init || return

    local opt
    while getopts "p:f:t:s:" opt; do
	case "${opt}" in
	    p)
		local packet="${OPTARG}"
		;;
	    f)
		local replace_from="${OPTARG}"
		;;
	    t)
		local replace_to="${OPTARG}"
		;;
	    s)
		local target="${OPTARG##*/}"
		target="${target%%.targetinstall*}"
		;;
	    *)
		return 1
		;;
	esac
    done

    if [ -z "${packet}" ]; then
    	echo
	echo "Error: empty parameter to 'install_fixup()'"
	echo
	return 1
    fi

    case "${replace_from}" in
	AUTHOR)
	    replace_to="`echo ${replace_to} | sed -e 's/\([^\\]\)@/\1\\\@/g'`"
	    ;;
	PACKAGE)
	    replace_to="`echo ${replace_to} | sed -e 's/_/-/g'`"

	    #
	    # track "pkg name" to "xpkg filename"
	    #
	    if [ -e "${pkg_xpkg_map}" ]; then
		sed -i -e "/^${replace_to}$/d" "${pkg_xpkg_map}" &&

		if [ -s "${pkg_xpkg_map}" ]; then
		    cat >&2 <<EOF

${PREFIX}warning: more than one ipkg per PTXdist package detected:

pkg:	'${target}'
ipkg:	'${replace_to}' and '$(cat "${pkg_xpkg_map}")'


EOF
		fi
	    fi &&
	    echo "${replace_to}" >> "${pkg_xpkg_map}" || return


	    ;;
	VERSION)
	    replace_to="${replace_to//[-_]/.}${PTXCONF_PROJECT_BUILD//[-_]/.}"
	    ;;
	DEPENDS)
	    return
	    ;;
    esac

    echo -n "install_fixup:	@${replace_from}@ -> ${replace_to} ... "
    sed -i -e "s,@$replace_from@,$replace_to,g" "${pkg_ipkg_control}" || return
    echo "done."
}

export -f ptxd_make_install_fixup
