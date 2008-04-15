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
HOST_PACKAGES-$(PTXCONF_HOST_LIBICONV) += host-libiconv

#
# Paths and names
#
HOST_LIBICONV_DIR	= $(HOST_BUILDDIR)/$(LIBICONV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libiconv.get: $(STATEDIR)/libiconv.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libiconv.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBICONV_DIR))
	@$(call extract, LIBICONV, $(HOST_BUILDDIR))
	@$(call patchin, LIBICONV, $(HOST_LIBICONV_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBICONV_PATH	:= PATH=$(HOST_PATH)
HOST_LIBICONV_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBICONV_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libiconv.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBICONV_DIR)/config.cache)
	cd $(HOST_LIBICONV_DIR) && \
		$(HOST_LIBICONV_PATH) $(HOST_LIBICONV_ENV) \
		./configure $(HOST_LIBICONV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libiconv.compile:
	@$(call targetinfo, $@)
	cd $(HOST_LIBICONV_DIR) && $(HOST_LIBICONV_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libiconv.install:
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBICONV,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libiconv_clean:
	rm -rf $(STATEDIR)/host-libiconv.*
	rm -rf $(HOST_LIBICONV_DIR)

# vim: syntax=make
