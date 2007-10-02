# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK_ENGINE_EXPERIENCE) += gtk-engine-experience

#
# Paths and names
#
GTK_ENGINE_EXPERIENCE_VERSION	:= 0.10.5
GTK_ENGINE_EXPERIENCE		:= gtk-engine-experience-$(GTK_ENGINE_EXPERIENCE_VERSION)
GTK_ENGINE_EXPERIENCE_SUFFIX	:= tar.bz2
GTK_ENGINE_EXPERIENCE_URL	:= http://benjamin.sipsolutions.net/experience/$(GTK_ENGINE_EXPERIENCE).$(GTK_ENGINE_EXPERIENCE_SUFFIX)
GTK_ENGINE_EXPERIENCE_SOURCE	:= $(SRCDIR)/$(GTK_ENGINE_EXPERIENCE).$(GTK_ENGINE_EXPERIENCE_SUFFIX)
GTK_ENGINE_EXPERIENCE_DIR	:= $(BUILDDIR)/$(GTK_ENGINE_EXPERIENCE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk-engine-experience_get: $(STATEDIR)/gtk-engine-experience.get

$(STATEDIR)/gtk-engine-experience.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GTK_ENGINE_EXPERIENCE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GTK_ENGINE_EXPERIENCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk-engine-experience_extract: $(STATEDIR)/gtk-engine-experience.extract

$(STATEDIR)/gtk-engine-experience.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(GTK_ENGINE_EXPERIENCE_DIR))
	@$(call extract, GTK_ENGINE_EXPERIENCE)
	@$(call patchin, GTK_ENGINE_EXPERIENCE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk-engine-experience_prepare: $(STATEDIR)/gtk-engine-experience.prepare

GTK_ENGINE_EXPERIENCE_PATH	:= PATH=$(CROSS_PATH)
GTK_ENGINE_EXPERIENCE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GTK_ENGINE_EXPERIENCE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

$(STATEDIR)/gtk-engine-experience.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(GTK_ENGINE_EXPERIENCE_DIR)/config.cache)
	cd $(GTK_ENGINE_EXPERIENCE_DIR) && \
		$(GTK_ENGINE_EXPERIENCE_PATH) $(GTK_ENGINE_EXPERIENCE_ENV) \
		./configure $(GTK_ENGINE_EXPERIENCE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk-engine-experience_compile: $(STATEDIR)/gtk-engine-experience.compile

$(STATEDIR)/gtk-engine-experience.compile:
	@$(call targetinfo, $@)
	cd $(GTK_ENGINE_EXPERIENCE_DIR) && \
		$(GTK_ENGINE_EXPERIENCE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk-engine-experience_install: $(STATEDIR)/gtk-engine-experience.install

$(STATEDIR)/gtk-engine-experience.install:
	@$(call targetinfo, $@)
	@$(call install, GTK_ENGINE_EXPERIENCE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk-engine-experience_targetinstall: $(STATEDIR)/gtk-engine-experience.targetinstall

$(STATEDIR)/gtk-engine-experience.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, gtk-engine-experience)
	@$(call install_fixup, gtk-engine-experience,PACKAGE,gtk-engine-experience)
	@$(call install_fixup, gtk-engine-experience,PRIORITY,optional)
	@$(call install_fixup, gtk-engine-experience,VERSION,$(GTK_ENGINE_EXPERIENCE_VERSION))
	@$(call install_fixup, gtk-engine-experience,SECTION,base)
	@$(call install_fixup, gtk-engine-experience,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gtk-engine-experience,DEPENDS,)
	@$(call install_fixup, gtk-engine-experience,DESCRIPTION,missing)

	@$(call install_copy, gtk-engine-experience, 0, 0, 0755, \
		$(GTK_ENGINE_EXPERIENCE_DIR)/src/.libs/libexperience.so, \
		/usr/lib/gtk-2.0/engines/libexperience.so)

	@$(call install_finish, gtk-engine-experience)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk-engine-experience_clean:
	rm -rf $(STATEDIR)/gtk-engine-experience.*
	rm -rf $(IMAGEDIR)/gtk-engine-experience_*
	rm -rf $(GTK_ENGINE_EXPERIENCE_DIR)

# vim: syntax=make
