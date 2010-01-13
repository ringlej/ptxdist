# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
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
PACKAGES-$(PTXCONF_HDPARM) += hdparm

#
# Paths and names
#
HDPARM_VERSION	:= 9.10
HDPARM		:= hdparm-$(HDPARM_VERSION)
HDPARM_SUFFIX	:= tar.gz
HDPARM_URL	:= $(PTXCONF_SETUP_SFMIRROR)/hdparm/$(HDPARM).$(HDPARM_SUFFIX)
HDPARM_SOURCE	:= $(SRCDIR)/$(HDPARM).$(HDPARM_SUFFIX)
HDPARM_DIR	:= $(BUILDDIR)/$(HDPARM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HDPARM_SOURCE):
	@$(call targetinfo)
	@$(call get, HDPARM)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HDPARM_PATH	:= PATH=$(CROSS_PATH)
HDPARM_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hdparm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hdparm)
	@$(call install_fixup, hdparm,PACKAGE,hdparm)
	@$(call install_fixup, hdparm,PRIORITY,optional)
	@$(call install_fixup, hdparm,VERSION,$(HDPARM_VERSION))
	@$(call install_fixup, hdparm,SECTION,base)
	@$(call install_fixup, hdparm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, hdparm,DEPENDS,)
	@$(call install_fixup, hdparm,DESCRIPTION,missing)

	@$(call install_copy, hdparm, 0, 0, 0755, -, /sbin/hdparm)

	@$(call install_finish, hdparm)

	@$(call touch)

# vim: syntax=make
