# -*-makefile-*-
# $Id$
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
HOST_PACKAGES-$(PTXCONF_HOST_GTK_ENGINE_EXPERIENCE) += host-gtk-engine-experience

#
# Paths and names
#
HOST_GTK_ENGINE_EXPERIENCE_DIR	= $(HOST_BUILDDIR)/$(GTK_ENGINE_EXPERIENCE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-gtk-engine-experience_get: $(STATEDIR)/host-gtk-engine-experience.get

$(STATEDIR)/host-gtk-engine-experience.get: $(STATEDIR)/gtk-engine-experience.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-gtk-engine-experience_extract: $(STATEDIR)/host-gtk-engine-experience.extract

$(STATEDIR)/host-gtk-engine-experience.extract: $(host-gtk-engine-experience_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GTK_ENGINE_EXPERIENCE_DIR))
	@$(call extract, GTK_ENGINE_EXPERIENCE, $(HOST_BUILDDIR))
	@$(call patchin, GTK_ENGINE_EXPERIENCE, $(HOST_GTK_ENGINE_EXPERIENCE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-gtk-engine-experience_prepare: $(STATEDIR)/host-gtk-engine-experience.prepare

HOST_GTK_ENGINE_EXPERIENCE_PATH	:= PATH=$(HOST_PATH)
HOST_GTK_ENGINE_EXPERIENCE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GTK_ENGINE_EXPERIENCE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-gtk-engine-experience.prepare: $(host-gtk-engine-experience_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GTK_ENGINE_EXPERIENCE_DIR)/config.cache)
	cd $(HOST_GTK_ENGINE_EXPERIENCE_DIR) && \
		$(HOST_GTK_ENGINE_EXPERIENCE_PATH) $(HOST_GTK_ENGINE_EXPERIENCE_ENV) \
		./configure $(HOST_GTK_ENGINE_EXPERIENCE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-gtk-engine-experience_compile: $(STATEDIR)/host-gtk-engine-experience.compile

$(STATEDIR)/host-gtk-engine-experience.compile: $(host-gtk-engine-experience_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GTK_ENGINE_EXPERIENCE_DIR) && $(HOST_GTK_ENGINE_EXPERIENCE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-gtk-engine-experience_install: $(STATEDIR)/host-gtk-engine-experience.install

$(STATEDIR)/host-gtk-engine-experience.install: $(host-gtk-engine-experience_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GTK_ENGINE_EXPERIENCE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gtk-engine-experience_clean:
	rm -rf $(STATEDIR)/host-gtk-engine-experience.*
	rm -rf $(HOST_GTK_ENGINE_EXPERIENCE_DIR)

# vim: syntax=make
