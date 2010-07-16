# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBV) += fbv

#
# Paths and names
#
FBV_VERSION	:= 1.0b-ptx3
FBV		:= fbv-$(FBV_VERSION)
FBV_SUFFIX	:= tar.bz2
FBV_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FBV).$(FBV_SUFFIX)
#FBV_URL	:= http://s-tech.elsat.net.pl/fbv/$(FBV).$(FBV_SUFFIX)
FBV_SOURCE	:= $(SRCDIR)/$(FBV).$(FBV_SUFFIX)
FBV_DIR		:= $(BUILDDIR)/$(FBV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FBV_SOURCE):
	@$(call targetinfo)
	@$(call get, FBV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FBV_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbv)
	@$(call install_fixup, fbv,PRIORITY,optional)
	@$(call install_fixup, fbv,SECTION,base)
	@$(call install_fixup, fbv,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fbv,DESCRIPTION,missing)

	@$(call install_copy, fbv, 0, 0, 0755, -, /usr/bin/fbv)

	@$(call install_finish, fbv)

	@$(call touch)

# vim: syntax=make
