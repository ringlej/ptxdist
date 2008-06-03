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
MII_DIAG_VERSION	= 2.09
MII_DIAG		= mii-diag-$(MII_DIAG_VERSION).orig
MII_DIAG_SUFFIX		= tar.gz
MII_DIAG_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/m/mii-diag/mii-diag_$(MII_DIAG_VERSION).orig.$(MII_DIAG_SUFFIX)
MII_DIAG_SOURCE		= $(SRCDIR)/mii-diag_$(MII_DIAG_VERSION).orig.$(MII_DIAG_SUFFIX)
MII_DIAG_DIR		= $(BUILDDIR)/$(MII_DIAG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mii-diag_get: $(STATEDIR)/mii-diag.get

$(STATEDIR)/mii-diag.get: $(mii-diag_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MII_DIAG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MII_DIAG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mii-diag_extract: $(STATEDIR)/mii-diag.extract

$(STATEDIR)/mii-diag.extract: $(mii-diag_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MII_DIAG_DIR))
	@$(call extract, MII_DIAG)
	@$(call patchin, MII_DIAG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mii-diag_prepare: $(STATEDIR)/mii-diag.prepare

MII_DIAG_PATH	=  PATH=$(CROSS_PATH)
MII_DIAG_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/mii-diag.prepare: $(mii-diag_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mii-diag_compile: $(STATEDIR)/mii-diag.compile

$(STATEDIR)/mii-diag.compile: $(mii-diag_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MII_DIAG_DIR) && $(MII_DIAG_ENV) $(MII_DIAG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mii-diag_install: $(STATEDIR)/mii-diag.install

$(STATEDIR)/mii-diag.install: $(mii-diag_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mii-diag_targetinstall: $(STATEDIR)/mii-diag.targetinstall

$(STATEDIR)/mii-diag.targetinstall: $(mii-diag_targetinstall_deps_default)
	@$(call targetinfo, $@)

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

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mii-diag_clean:
	rm -rf $(STATEDIR)/mii-diag.*
	rm -rf $(PKGDIR)/mii-diag_*
	rm -rf $(MII_DIAG_DIR)

# vim: syntax=make
