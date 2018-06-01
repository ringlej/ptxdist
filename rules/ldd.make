# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LDD) += ldd

# This is the version from the glibc we have stolen from
LDD_VERSION	:= 2.7
LDD_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ldd)
	@$(call install_fixup, ldd,PRIORITY,optional)
	@$(call install_fixup, ldd,SECTION,base)
	@$(call install_fixup, ldd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ldd,DESCRIPTION,missing)

	@$(call install_alternative, ldd, 0, 0, 0755, /usr/bin/ldd)

	@$(call install_finish, ldd)

	@$(call touch)

# vim: syntax=make
