# -*-makefile-*-
# $Id: template,v 1.14 2004/07/01 16:08:08 rsc Exp $
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
PACKAGES-$(PTXCONF_HEXEDIT) += hexedit

#
# Paths and names
#
HEXEDIT_VERSION	= 1.2.10
HEXEDIT		= hexedit-$(HEXEDIT_VERSION)
HEXEDIT_SUFFIX	= src.tgz
HEXEDIT_URL	= http://merd.net/pixel/$(HEXEDIT).$(HEXEDIT_SUFFIX)
HEXEDIT_SOURCE	= $(SRCDIR)/$(HEXEDIT).$(HEXEDIT_SUFFIX)
HEXEDIT_DIR	= $(BUILDDIR)/$(HEXEDIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hexedit_get: $(STATEDIR)/hexedit.get

hexedit_get_deps = $(HEXEDIT_SOURCE)

$(STATEDIR)/hexedit.get: $(hexedit_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HEXEDIT))
	@$(call touch, $@)

$(HEXEDIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HEXEDIT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hexedit_extract: $(STATEDIR)/hexedit.extract

hexedit_extract_deps = $(STATEDIR)/hexedit.get

$(STATEDIR)/hexedit.extract: $(hexedit_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HEXEDIT_DIR))
	@$(call extract, $(HEXEDIT_SOURCE))
	mv $(BUILDDIR)/hexedit $(HEXEDIT_DIR)
	@$(call patchin, $(HEXEDIT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hexedit_prepare: $(STATEDIR)/hexedit.prepare

#
# dependencies
#
hexedit_prepare_deps = \
	$(STATEDIR)/hexedit.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/ncurses.install

HEXEDIT_PATH	=  PATH=$(CROSS_PATH)
HEXEDIT_ENV 	=  $(CROSS_ENV)
HEXEDIT_ENV	+= LDFLAGS='$(strip $(subst $(quote),,$(TARGET_LDFLAGS))) -static'
HEXEDIT_ENV	+= CFLAGS='$(strip $(subst $(quote),,$(TARGET_CFLAGS))) $(strip $(subst $(quote),,$(TARGET_CPPFLAGS)))'

#
# autoconf
#
HEXEDIT_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/hexedit.prepare: $(hexedit_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HEXEDIT_DIR)/config.cache)
	cd $(HEXEDIT_DIR) && \
		$(HEXEDIT_PATH) $(HEXEDIT_ENV) \
		./configure $(HEXEDIT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hexedit_compile: $(STATEDIR)/hexedit.compile

hexedit_compile_deps = $(STATEDIR)/hexedit.prepare

$(STATEDIR)/hexedit.compile: $(hexedit_compile_deps)
	@$(call targetinfo, $@)
	cd $(HEXEDIT_DIR) && $(HEXEDIT_ENV) $(HEXEDIT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hexedit_install: $(STATEDIR)/hexedit.install

$(STATEDIR)/hexedit.install: $(STATEDIR)/hexedit.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hexedit_targetinstall: $(STATEDIR)/hexedit.targetinstall

hexedit_targetinstall_deps = $(STATEDIR)/hexedit.compile

$(STATEDIR)/hexedit.targetinstall: $(hexedit_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,hexedit)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(HEXEDIT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(HEXEDIT_DIR)/hexedit, /usr/bin/hexedit)	

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hexedit_clean:
	rm -rf $(STATEDIR)/hexedit.*
	rm -rf $(IMAGEDIR)/hexedit_*
	rm -rf $(HEXEDIT_DIR)

# vim: syntax=make
