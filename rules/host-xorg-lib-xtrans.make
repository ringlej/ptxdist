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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XTRANS) += host-xorg-lib-xtrans

#
# Paths and names
#
HOST_XORG_LIB_XTRANS_DIR	= $(HOST_BUILDDIR)/$(XORG_LIB_XTRANS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-lib-xtrans_get: $(STATEDIR)/host-xorg-lib-xtrans.get

$(STATEDIR)/host-xorg-lib-xtrans.get: $(STATEDIR)/xorg-lib-xtrans.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-lib-xtrans_extract: $(STATEDIR)/host-xorg-lib-xtrans.extract

$(STATEDIR)/host-xorg-lib-xtrans.extract: $(host-xorg-lib-xtrans_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XTRANS_DIR))
	@$(call extract, XORG_LIB_XTRANS, $(HOST_BUILDDIR))
	@$(call patchin, XORG_LIB_XTRANS, $(HOST_XORG_LIB_XTRANS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-lib-xtrans_prepare: $(STATEDIR)/host-xorg-lib-xtrans.prepare

HOST_XORG_LIB_XTRANS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XTRANS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XTRANS_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-lib-xtrans.prepare: $(host-xorg-lib-xtrans_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XTRANS_DIR)/config.cache)
	cd $(HOST_XORG_LIB_XTRANS_DIR) && \
		$(HOST_XORG_LIB_XTRANS_PATH) $(HOST_XORG_LIB_XTRANS_ENV) \
		./configure $(HOST_XORG_LIB_XTRANS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-lib-xtrans_compile: $(STATEDIR)/host-xorg-lib-xtrans.compile

$(STATEDIR)/host-xorg-lib-xtrans.compile: $(host-xorg-lib-xtrans_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_LIB_XTRANS_DIR) && $(HOST_XORG_LIB_XTRANS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-lib-xtrans_install: $(STATEDIR)/host-xorg-lib-xtrans.install

$(STATEDIR)/host-xorg-lib-xtrans.install: $(host-xorg-lib-xtrans_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_LIB_XTRANS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-lib-xtrans_clean:
	rm -rf $(STATEDIR)/host-xorg-lib-xtrans.*
	rm -rf $(HOST_XORG_LIB_XTRANS_DIR)

# vim: syntax=make
