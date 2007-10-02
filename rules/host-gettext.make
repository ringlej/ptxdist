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
HOST_PACKAGES-$(PTXCONF_HOST_GETTEXT) += host-gettext

#
# Paths and names
#
HOST_GETTEXT_DIR	= $(HOST_BUILDDIR)/$(GETTEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-gettext_get: $(STATEDIR)/host-gettext.get

$(STATEDIR)/host-gettext.get: $(STATEDIR)/gettext.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-gettext_extract: $(STATEDIR)/host-gettext.extract

$(STATEDIR)/host-gettext.extract: $(host-gettext_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GETTEXT_DIR))
	@$(call extract, GETTEXT, $(HOST_BUILDDIR))
	@$(call patchin, GETTEXT, $(HOST_GETTEXT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-gettext_prepare: $(STATEDIR)/host-gettext.prepare

HOST_GETTEXT_PATH	:= PATH=$(HOST_PATH)
HOST_GETTEXT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GETTEXT_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-java \
	--disable-native-java \
	--disable-csharp

$(STATEDIR)/host-gettext.prepare: $(host-gettext_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GETTEXT_DIR)/config.cache)
	cd $(HOST_GETTEXT_DIR) && \
		$(HOST_GETTEXT_PATH) $(HOST_GETTEXT_ENV) \
		./configure $(HOST_GETTEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-gettext_compile: $(STATEDIR)/host-gettext.compile

$(STATEDIR)/host-gettext.compile: $(host-gettext_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GETTEXT_DIR) && $(HOST_GETTEXT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-gettext_install: $(STATEDIR)/host-gettext.install

$(STATEDIR)/host-gettext.install: $(host-gettext_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GETTEXT,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gettext_clean:
	rm -rf $(STATEDIR)/host-gettext.*
	rm -rf $(HOST_GETTEXT_DIR)

# vim: syntax=make
