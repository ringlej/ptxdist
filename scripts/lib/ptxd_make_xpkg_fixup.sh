#!/bin/bash
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
#
#
ptxd_make_xpkg_fixup() {
    ptxd_make_xpkg_init || return

    case "${pkg_xpkg_fixup_from}" in
	AUTHOR)
	    pkg_xpkg_fixup_to="`echo ${pkg_xpkg_fixup_to} | sed -e 's/\([^\\]\)@/\1\\\@/g'`"
	    ;;
	PACKAGE)
	    pkg_xpkg_fixup_to="`echo ${pkg_xpkg_fixup_to} | sed -e 's/_/-/g'`"

	    #
	    # track "pkg name" to "xpkg filename"
	    #
	    if [ -e "${pkg_xpkg_map}" ]; then
		sed -i -e "/^${pkg_xpkg_fixup_to}$/d" "${pkg_xpkg_map}" &&

		if [ -s "${pkg_xpkg_map}" ]; then
		    cat >&2 <<EOF

${PREFIX}warning: more than one ipkg per PTXdist package detected:

pkg:	'${pkg_pkg}'
ipkg:	'${pkg_xpkg_fixup_to}' and '$(cat "${pkg_xpkg_map}")'


EOF
		fi
	    fi &&
	    echo "${pkg_xpkg_fixup_to}" >> "${pkg_xpkg_map}" || return


	    ;;
	VERSION)
	    pkg_xpkg_fixup_to="${pkg_xpkg_fixup_to//[-_]/.}"
	    ;;
	DEPENDS)
	    return
	    ;;
    esac

    echo -n "install_fixup:	@${pkg_xpkg_fixup_from}@ -> ${pkg_xpkg_fixup_to} ... "
    sed -i -e "s,@$pkg_xpkg_fixup_from@,$pkg_xpkg_fixup_to,g" "${pkg_ipkg_control}" || return
    echo "done."
}

export -f ptxd_make_xpkg_fixup
