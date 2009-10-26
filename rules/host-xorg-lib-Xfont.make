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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XFONT) += host-xorg-lib-xfont

#
# Paths and names
#
HOST_XORG_LIB_XFONT_DIR		= $(HOST_BUILDDIR)/$(XORG_LIB_XFONT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-lib-xfont_get: $(STATEDIR)/host-xorg-lib-xfont.get

$(STATEDIR)/host-xorg-lib-xfont.get: $(STATEDIR)/xorg-lib-xfont.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-lib-xfont_extract: $(STATEDIR)/host-xorg-lib-xfont.extract

$(STATEDIR)/host-xorg-lib-xfont.extract: $(host-xorg-lib-xfont_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XFONT_DIR))
	@$(call extract, XORG_LIB_XFONT, $(HOST_BUILDDIR))
	@$(call patchin, XORG_LIB_XFONT, $(HOST_XORG_LIB_XFONT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-lib-xfont_prepare: $(STATEDIR)/host-xorg-lib-xfont.prepare

HOST_XORG_LIB_XFONT_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XFONT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XFONT_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-freetype

$(STATEDIR)/host-xorg-lib-xfont.prepare: $(host-xorg-lib-xfont_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XFONT_DIR)/config.cache)
	cd $(HOST_XORG_LIB_XFONT_DIR) && \
		$(HOST_XORG_LIB_XFONT_PATH) $(HOST_XORG_LIB_XFONT_ENV) \
		./configure $(HOST_XORG_LIB_XFONT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-lib-xfont_compile: $(STATEDIR)/host-xorg-lib-xfont.compile

$(STATEDIR)/host-xorg-lib-xfont.compile: $(host-xorg-lib-xfont_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_LIB_XFONT_DIR) && $(HOST_XORG_LIB_XFONT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-lib-xfont_install: $(STATEDIR)/host-xorg-lib-xfont.install

$(STATEDIR)/host-xorg-lib-xfont.install: $(host-xorg-lib-xfont_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_LIB_XFONT,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-lib-xfont_clean:
	rm -rf $(STATEDIR)/host-xorg-lib-xfont.*
	rm -rf $(HOST_XORG_LIB_XFONT_DIR)

# vim: syntax=make
