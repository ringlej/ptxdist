# -*-makefile-*-
# $Id: template 3079 2005-09-02 18:09:51Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
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
HDPARM_VERSION	= 9.10
HDPARM		= hdparm-$(HDPARM_VERSION)
HDPARM_SUFFIX	= tar.gz
HDPARM_URL	= $(PTXCONF_SETUP_SFMIRROR)/hdparm/$(HDPARM).$(HDPARM_SUFFIX)
HDPARM_SOURCE	= $(SRCDIR)/$(HDPARM).$(HDPARM_SUFFIX)
HDPARM_DIR	= $(BUILDDIR)/$(HDPARM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hdparm_get: $(STATEDIR)/hdparm.get

$(STATEDIR)/hdparm.get: $(hdparm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HDPARM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HDPARM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hdparm_extract: $(STATEDIR)/hdparm.extract

$(STATEDIR)/hdparm.extract: $(hdparm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HDPARM_DIR))
	@$(call extract, HDPARM)
	@$(call patchin, HDPARM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hdparm_prepare: $(STATEDIR)/hdparm.prepare

HDPARM_PATH	=  PATH=$(CROSS_PATH)
HDPARM_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
HDPARM_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/hdparm.prepare: $(hdparm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HDPARM_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hdparm_compile: $(STATEDIR)/hdparm.compile

$(STATEDIR)/hdparm.compile: $(hdparm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HDPARM_DIR) && $(HDPARM_ENV) $(HDPARM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hdparm_install: $(STATEDIR)/hdparm.install

$(STATEDIR)/hdparm.install: $(hdparm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hdparm_targetinstall: $(STATEDIR)/hdparm.targetinstall

$(STATEDIR)/hdparm.targetinstall: $(hdparm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, hdparm)
	@$(call install_fixup, hdparm,PACKAGE,hdparm)
	@$(call install_fixup, hdparm,PRIORITY,optional)
	@$(call install_fixup, hdparm,VERSION,$(HDPARM_VERSION))
	@$(call install_fixup, hdparm,SECTION,base)
	@$(call install_fixup, hdparm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, hdparm,DEPENDS,)
	@$(call install_fixup, hdparm,DESCRIPTION,missing)

	@$(call install_copy, hdparm, 0, 0, 0755, $(HDPARM_DIR)/hdparm, /usr/bin/hdparm)

	@$(call install_finish, hdparm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hdparm_clean:
	rm -rf $(STATEDIR)/hdparm.*
	rm -rf $(PKGDIR)/hdparm_*
	rm -rf $(HDPARM_DIR)

# vim: syntax=make
