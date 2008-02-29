# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2008 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLADEMM) += glademm

#
# Paths and names
#
GLADEMM_VERSION	:= 2.6.0
GLADEMM		:= glademm-$(GLADEMM_VERSION)
GLADEMM_SUFFIX	:= tar.gz
GLADEMM_URL	:= http://home.wtal.de/petig/Gtk/$(GLADEMM).$(GLADEMM_SUFFIX)
GLADEMM_SOURCE	:= $(SRCDIR)/$(GLADEMM).$(GLADEMM_SUFFIX)
GLADEMM_DIR	:= $(BUILDDIR)/$(GLADEMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glademm_get: $(STATEDIR)/glademm.get

$(STATEDIR)/glademm.get: $(glademm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GLADEMM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GLADEMM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glademm_extract: $(STATEDIR)/glademm.extract

$(STATEDIR)/glademm.extract: $(glademm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLADEMM_DIR))
	@$(call extract, GLADEMM)
	@$(call patchin, GLADEMM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glademm_prepare: $(STATEDIR)/glademm.prepare

GLADEMM_PATH	:= PATH=$(CROSS_PATH)
GLADEMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GLADEMM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/glademm.prepare: $(glademm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLADEMM_DIR)/config.cache)
	cd $(GLADEMM_DIR) && \
		$(GLADEMM_PATH) $(GLADEMM_ENV) \
		./configure $(GLADEMM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glademm_compile: $(STATEDIR)/glademm.compile

$(STATEDIR)/glademm.compile: $(glademm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GLADEMM_DIR) && $(GLADEMM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glademm_install: $(STATEDIR)/glademm.install

$(STATEDIR)/glademm.install: $(glademm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GLADEMM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glademm_targetinstall: $(STATEDIR)/glademm.targetinstall

$(STATEDIR)/glademm.targetinstall: $(glademm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, glademm)
	@$(call install_fixup, glademm,PACKAGE,glademm)
	@$(call install_fixup, glademm,PRIORITY,optional)
	@$(call install_fixup, glademm,VERSION,$(GLADEMM_VERSION))
	@$(call install_fixup, glademm,SECTION,base)
	@$(call install_fixup, glademm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, glademm,DEPENDS,)
	@$(call install_fixup, glademm,DESCRIPTION,missing)

	@$(call install_copy, glademm, 0, 0, 0755, \
		$(GLADEMM_DIR)/src/glade--, \
		/usr/bin/glade--)

	@$(call install_copy, glademm, 0, 0, 0755, \
		$(GLADEMM_DIR)/src/glademm-embed, \
		/usr/bin/glademm-embed)

	@$(call install_finish, glademm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glademm_clean:
	rm -rf $(STATEDIR)/glademm.*
	rm -rf $(IMAGEDIR)/glademm_*
	rm -rf $(GLADEMM_DIR)

# vim: syntax=make
