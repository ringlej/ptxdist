# -*-makefile-*-
# $Id$
#
# Copyright (C) 2008 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBGD) += host-libgd

#
# Paths and names
#
HOST_LIBGD_DIR	= $(HOST_BUILDDIR)/$(LIBGD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libgd.get: $(STATEDIR)/libgd.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libgd.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_LIBGD_DIR))
	@$(call extract, LIBGD, $(HOST_BUILDDIR))
	@$(call patchin, LIBGD, $(HOST_LIBGD_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBGD_PATH	:= PATH=$(HOST_PATH)
HOST_LIBGD_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBGD_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--without-x \
	--without-jpeg \
	--with-png=$(PTXCONF_SYSROOT_HOST) \
	--without-xpm \
	--without-freetype \
	--without-fontconfig

$(STATEDIR)/host-libgd.prepare:
	@$(call targetinfo)
	@$(call clean, $(HOST_LIBGD_DIR)/config.cache)
	cd $(HOST_LIBGD_DIR) && \
		$(HOST_LIBGD_PATH) $(HOST_LIBGD_ENV) \
		./configure $(HOST_LIBGD_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libgd.compile:
	@$(call targetinfo)
	cd $(HOST_LIBGD_DIR) && $(HOST_LIBGD_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libgd.install:
	@$(call targetinfo)
	@$(call install, HOST_LIBGD,,h)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libgd_clean:
	rm -rf $(STATEDIR)/host-libgd.*
	rm -rf $(HOST_LIBGD_DIR)

# vim: syntax=make
