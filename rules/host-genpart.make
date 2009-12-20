# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GENPART) += host-genpart

#
# Paths and names
#
HOST_GENPART_VERSION	:= 1.0.2
HOST_GENPART		:= genpart-$(HOST_GENPART_VERSION)
HOST_GENPART_SUFFIX	:= tar.bz2
HOST_GENPART_URL	:= http://www.pengutronix.de/software/genpart/download/$(HOST_GENPART).$(HOST_GENPART_SUFFIX)
HOST_GENPART_SOURCE	:= $(SRCDIR)/$(HOST_GENPART).$(HOST_GENPART_SUFFIX)
HOST_GENPART_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENPART)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-genpart_get: $(STATEDIR)/host-genpart.get

$(STATEDIR)/host-genpart.get: $(host-genpart_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_GENPART_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_GENPART)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-genpart_extract: $(STATEDIR)/host-genpart.extract

$(STATEDIR)/host-genpart.extract: $(host-genpart_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GENPART_DIR))
	@$(call extract, HOST_GENPART, $(HOST_BUILDDIR))
	@$(call patchin, HOST_GENPART, $(HOST_GENPART_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-genpart_prepare: $(STATEDIR)/host-genpart.prepare

HOST_GENPART_PATH	:= PATH=$(HOST_PATH)
HOST_GENPART_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GENPART_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-genpart.prepare: $(host-genpart_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GENPART_DIR)/config.cache)
	cd $(HOST_GENPART_DIR) && \
		$(HOST_GENPART_PATH) $(HOST_GENPART_ENV) \
		./configure $(HOST_GENPART_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-genpart_compile: $(STATEDIR)/host-genpart.compile

$(STATEDIR)/host-genpart.compile: $(host-genpart_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GENPART_DIR) && $(HOST_GENPART_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-genpart_install: $(STATEDIR)/host-genpart.install

$(STATEDIR)/host-genpart.install: $(host-genpart_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GENPART,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-genpart_clean:
	rm -rf $(STATEDIR)/host-genpart.*
	rm -rf $(HOST_GENPART_DIR)

# vim: syntax=make
