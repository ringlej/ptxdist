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
HEXEDIT_VERSION	:= 1.2.12
HEXEDIT		:= hexedit-$(HEXEDIT_VERSION)
HEXEDIT_SUFFIX	:= src.tgz
HEXEDIT_URL	:= http://rigaux.org/$(HEXEDIT).$(HEXEDIT_SUFFIX)
HEXEDIT_SOURCE	:= $(SRCDIR)/$(HEXEDIT).$(HEXEDIT_SUFFIX)
HEXEDIT_DIR	:= $(BUILDDIR)/$(HEXEDIT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hexedit_get: $(STATEDIR)/hexedit.get

$(STATEDIR)/hexedit.get: $(hexedit_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HEXEDIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HEXEDIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hexedit_extract: $(STATEDIR)/hexedit.extract

$(STATEDIR)/hexedit.extract: $(hexedit_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HEXEDIT_DIR))
	@$(call extract, HEXEDIT)
	mv $(BUILDDIR)/hexedit $(HEXEDIT_DIR)
	@$(call patchin, HEXEDIT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hexedit_prepare: $(STATEDIR)/hexedit.prepare

HEXEDIT_PATH	=  PATH=$(CROSS_PATH)
HEXEDIT_ENV 	=  $(CROSS_ENV)
HEXEDIT_ENV	+= CFLAGS='$(strip $(subst $(quote),,$(TARGET_CFLAGS))) $(strip $(subst $(quote),,$(TARGET_CPPFLAGS)))'

#
# autoconf
#
HEXEDIT_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/hexedit.prepare: $(hexedit_prepare_deps_default)
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

$(STATEDIR)/hexedit.compile: $(hexedit_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HEXEDIT_DIR) && $(HEXEDIT_ENV) $(HEXEDIT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hexedit_install: $(STATEDIR)/hexedit.install

$(STATEDIR)/hexedit.install: $(hexedit_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hexedit_targetinstall: $(STATEDIR)/hexedit.targetinstall

$(STATEDIR)/hexedit.targetinstall: $(hexedit_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, hexedit)
	@$(call install_fixup, hexedit,PACKAGE,hexedit)
	@$(call install_fixup, hexedit,PRIORITY,optional)
	@$(call install_fixup, hexedit,VERSION,$(HEXEDIT_VERSION))
	@$(call install_fixup, hexedit,SECTION,base)
	@$(call install_fixup, hexedit,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, hexedit,DEPENDS,)
	@$(call install_fixup, hexedit,DESCRIPTION,missing)

	@$(call install_copy, hexedit, 0, 0, 0755, $(HEXEDIT_DIR)/hexedit, /usr/bin/hexedit)

	@$(call install_finish, hexedit)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hexedit_clean:
	rm -rf $(STATEDIR)/hexedit.*
	rm -rf $(IMAGEDIR)/hexedit_*
	rm -rf $(HEXEDIT_DIR)

# vim: syntax=make
