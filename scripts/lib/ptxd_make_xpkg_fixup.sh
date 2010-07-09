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
	VERSION)
	    pkg_xpkg_fixup_to="${pkg_xpkg_fixup_to//[-_]/.}"
	    ;;
	DEPENDS|PACKAGE)
	    return
	    ;;
    esac

    echo -n "install_fixup:	@${pkg_xpkg_fixup_from}@ -> ${pkg_xpkg_fixup_to} ... "
    sed -i -e "s,@$pkg_xpkg_fixup_from@,$pkg_xpkg_fixup_to,g" "${pkg_ipkg_control}" || return
    echo "done."
}

export -f ptxd_make_xpkg_fixup
