# -*-makefile-*-
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
HOST_PACKAGES-$(PTXCONF_HOST_USPLASH) += host-usplash

#
# Paths and names
#
HOST_USPLASH_DIR	= $(HOST_BUILDDIR)/$(USPLASH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-usplash.get: $(STATEDIR)/usplash.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-usplash.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_USPLASH_DIR))
	@$(call extract, USPLASH, $(HOST_BUILDDIR))
	mv $(HOST_BUILDDIR)/usplash $(HOST_USPLASH_DIR)
	@$(call patchin, USPLASH, $(HOST_USPLASH_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_USPLASH_PATH	:= PATH=$(HOST_PATH)
HOST_USPLASH_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_USPLASH_AUTOCONF	:= $(HOST_AUTOCONF) \
	--disable-svga-backend \
	--enable-convert-tools

$(STATEDIR)/host-usplash.prepare:
	@$(call targetinfo)
	@$(call clean, $(HOST_USPLASH_DIR)/config.cache)
	cd $(HOST_USPLASH_DIR) && \
		$(HOST_USPLASH_PATH) $(HOST_USPLASH_ENV) \
		sh ./configure $(HOST_USPLASH_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-usplash.compile:
	@$(call targetinfo)
	cd $(HOST_USPLASH_DIR)/bogl && $(HOST_USPLASH_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-usplash.install:
	@$(call targetinfo)
	@$(call install, HOST_USPLASH,,h)
	@$(call touch)

# vim: syntax=make
