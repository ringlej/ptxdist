# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMEDIT) += memedit

#
# Paths and names
#
MEMEDIT_VERSION		= 0.7
MEMEDIT			= memedit-$(MEMEDIT_VERSION)
MEMEDIT_SUFFIX		= tar.gz
MEMEDIT_URL		= http://www.pengutronix.de/software/memedit/downloads/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_SOURCE		= $(SRCDIR)/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_DIR		= $(BUILDDIR)/$(MEMEDIT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

memedit_get: $(STATEDIR)/memedit.get

$(STATEDIR)/memedit.get: $(memedit_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MEMEDIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MEMEDIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

memedit_extract: $(STATEDIR)/memedit.extract

$(STATEDIR)/memedit.extract: $(memedit_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMEDIT_DIR))
	@$(call extract, MEMEDIT)
	@$(call patchin, MEMEDIT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

memedit_prepare: $(STATEDIR)/memedit.prepare

MEMEDIT_PATH	=  PATH=$(CROSS_PATH)
MEMEDIT_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MEMEDIT_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/memedit.prepare: $(memedit_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMEDIT_DIR)/config.cache)
	cd $(MEMEDIT_DIR) && \
		$(MEMEDIT_PATH) $(MEMEDIT_ENV) \
		./configure $(MEMEDIT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

memedit_compile: $(STATEDIR)/memedit.compile

$(STATEDIR)/memedit.compile: $(memedit_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MEMEDIT_DIR) && $(MEMEDIT_ENV) $(MEMEDIT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

memedit_install: $(STATEDIR)/memedit.install

$(STATEDIR)/memedit.install: $(memedit_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, MEMEDIT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

memedit_targetinstall: $(STATEDIR)/memedit.targetinstall

$(STATEDIR)/memedit.targetinstall: $(memedit_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, memedit)
	@$(call install_fixup, memedit,PACKAGE,memedit)
	@$(call install_fixup, memedit,PRIORITY,optional)
	@$(call install_fixup, memedit,VERSION,$(MEMEDIT_VERSION))
	@$(call install_fixup, memedit,SECTION,base)
	@$(call install_fixup, memedit,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, memedit,DEPENDS,)
	@$(call install_fixup, memedit,DESCRIPTION,missing)

	@$(call install_copy, memedit, 0, 0, 0755, $(MEMEDIT_DIR)/memedit, /usr/bin/memedit)

	@$(call install_finish, memedit)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

memedit_clean:
	rm -rf $(STATEDIR)/memedit.*
	rm -rf $(PKGDIR)/memedit_*
	rm -rf $(MEMEDIT_DIR)

# vim: syntax=make
