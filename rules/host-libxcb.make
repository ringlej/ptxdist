# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBXCB) += host-libxcb

#
# Paths and names
#
HOST_LIBXCB_DIR	= $(HOST_BUILDDIR)/$(LIBXCB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libxcb_get: $(STATEDIR)/host-libxcb.get

$(STATEDIR)/host-libxcb.get: $(STATEDIR)/libxcb.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libxcb_extract: $(STATEDIR)/host-libxcb.extract

$(STATEDIR)/host-libxcb.extract: $(host-libxcb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBXCB_DIR))
	@$(call extract, LIBXCB, $(HOST_BUILDDIR))
	@$(call patchin, LIBXCB, $(HOST_LIBXCB_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libxcb_prepare: $(STATEDIR)/host-libxcb.prepare

HOST_LIBXCB_PATH	:= PATH=$(HOST_PATH)
HOST_LIBXCB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBXCB_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--disable-build-docs

$(STATEDIR)/host-libxcb.prepare: $(host-libxcb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBXCB_DIR)/config.cache)
	cd $(HOST_LIBXCB_DIR) && \
		$(HOST_LIBXCB_PATH) $(HOST_LIBXCB_ENV) \
		./configure $(HOST_LIBXCB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libxcb_compile: $(STATEDIR)/host-libxcb.compile

$(STATEDIR)/host-libxcb.compile: $(host-libxcb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBXCB_DIR) && $(HOST_LIBXCB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libxcb_install: $(STATEDIR)/host-libxcb.install

$(STATEDIR)/host-libxcb.install: $(host-libxcb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBXCB,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libxcb_clean:
	rm -rf $(STATEDIR)/host-libxcb.*
	rm -rf $(HOST_LIBXCB_DIR)

# vim: syntax=make
