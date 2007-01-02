# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_FONTENC) += host-xorg-lib-fontenc

#
# Paths and names
#
HOST_XORG_LIB_FONTENC_DIR	= $(HOST_BUILDDIR)/$(XORG_LIB_FONTENC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-lib-fontenc_get: $(STATEDIR)/host-xorg-lib-fontenc.get

$(STATEDIR)/host-xorg-lib-fontenc.get: $(STATEDIR)/xorg-lib-fontenc.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-lib-fontenc_extract: $(STATEDIR)/host-xorg-lib-fontenc.extract

$(STATEDIR)/host-xorg-lib-fontenc.extract: $(host-xorg-lib-fontenc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_FONTENC_DIR))
	@$(call extract, XORG_LIB_FONTENC, $(HOST_BUILDDIR))
	@$(call patchin, XORG_LIB_FONTENC, $(HOST_XORG_LIB_FONTENC_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-lib-fontenc_prepare: $(STATEDIR)/host-xorg-lib-fontenc.prepare

HOST_XORG_LIB_FONTENC_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_FONTENC_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_FONTENC_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-lib-fontenc.prepare: $(host-xorg-lib-fontenc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_FONTENC_DIR)/config.cache)
	cd $(HOST_XORG_LIB_FONTENC_DIR) && \
		$(HOST_XORG_LIB_FONTENC_PATH) $(HOST_XORG_LIB_FONTENC_ENV) \
		./configure $(HOST_XORG_LIB_FONTENC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-lib-fontenc_compile: $(STATEDIR)/host-xorg-lib-fontenc.compile

$(STATEDIR)/host-xorg-lib-fontenc.compile: $(host-xorg-lib-fontenc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_LIB_FONTENC_DIR) && $(HOST_XORG_LIB_FONTENC_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-lib-fontenc_install: $(STATEDIR)/host-xorg-lib-fontenc.install

$(STATEDIR)/host-xorg-lib-fontenc.install: $(host-xorg-lib-fontenc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_LIB_FONTENC,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-lib-fontenc_clean:
	rm -rf $(STATEDIR)/host-xorg-lib-fontenc.*
	rm -rf $(HOST_XORG_LIB_FONTENC_DIR)

# vim: syntax=make
