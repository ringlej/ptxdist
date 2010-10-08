# -*-makefile-*-
#
# Copyright (C) 2004 by Benedikt Spranger
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MII_DIAG) += mii-diag

#
# Paths and names
#
MII_DIAG_VERSION	:= 2.11
MII_DIAG_MD5		:= 2c0cc0cd29c80f86921e6f300709bf81
MII_DIAG_SUFFIX		:= tar.gz
MII_DIAG		:= mii-diag-$(MII_DIAG_VERSION).orig
MII_DIAG_TARBALL	:= mii-diag_$(MII_DIAG_VERSION).orig.$(MII_DIAG_SUFFIX)
MII_DIAG_URL		:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/m/mii-diag/$(MII_DIAG_TARBALL)
MII_DIAG_SOURCE		:= $(SRCDIR)/$(MII_DIAG_TARBALL)
MII_DIAG_DIR		:= $(BUILDDIR)/$(MII_DIAG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MII_DIAG_SOURCE):
	@$(call targetinfo)
	@$(call get, MII_DIAG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MII_DIAG_PATH	:= PATH=$(CROSS_PATH)
MII_DIAG_ENV 	:= $(CROSS_ENV)

MII_DIAG_MAKE_OPT := $(CROSS_ENV_CC) mii-diag
MII_DIAG_INSTALL_OPT := install-mii-diag

$(STATEDIR)/mii-diag.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mii-diag.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mii-diag)
	@$(call install_fixup, mii-diag,PRIORITY,optional)
	@$(call install_fixup, mii-diag,SECTION,base)
	@$(call install_fixup, mii-diag,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mii-diag,DESCRIPTION,missing)

	@$(call install_copy, mii-diag, 0, 0, 0755, -, /usr/sbin/mii-diag)

	@$(call install_finish, mii-diag)

	@$(call touch)

# vim: syntax=make
