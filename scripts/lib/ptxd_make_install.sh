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
