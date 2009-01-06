# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
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
MII_DIAG_SUFFIX		:= tar.gz
MII_DIAG		:= mii-diag-$(MII_DIAG_VERSION).orig
MII_DIAG_TARBALL	:= mii-diag_$(MII_DIAG_VERSION).orig.$(MII_DIAG_SUFFIX)
MII_DIAG_URL		:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/m/mii-diag/$(MII_DIAG_TARBALL)
MII_DIAG_SOURCE		:= $(SRCDIR)/$(MII_DIAG_TARBALL)
MII_DIAG_DIR		:= $(BUILDDIR)/$(MII_DIAG)
MII_DIAG_PKGDIR		:= $(PKGDIR)/$(MII_DIAG)

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

MII_DIAG_MAKEVARS := $(CROSS_ENV_CC) mii-diag

$(STATEDIR)/mii-diag.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mii-diag.install:
	@$(call targetinfo)
	cd $(MII_DIAG_DIR) && $(MAKE) DESTDIR=$(SYSROOT) install-mii-diag
	cd $(MII_DIAG_DIR) && $(MAKE) DESTDIR=$(MII_DIAG_PKGDIR) install-mii-diag
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mii-diag.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mii-diag)
	@$(call install_fixup, mii-diag,PACKAGE,mii-diag)
	@$(call install_fixup, mii-diag,PRIORITY,optional)
	@$(call install_fixup, mii-diag,VERSION,$(MII_DIAG_VERSION))
	@$(call install_fixup, mii-diag,SECTION,base)
	@$(call install_fixup, mii-diag,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mii-diag,DEPENDS,)
	@$(call install_fixup, mii-diag,DESCRIPTION,missing)

	@$(call install_copy, mii-diag, 0, 0, 0755, $(MII_DIAG_DIR)/mii-diag, /usr/sbin/mii-diag)

	@$(call install_finish, mii-diag)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mii-diag_clean:
	rm -rf $(STATEDIR)/mii-diag.*
	rm -rf $(PKGDIR)/mii-diag_*
	rm -rf $(MII_DIAG_DIR)

# vim: syntax=make
