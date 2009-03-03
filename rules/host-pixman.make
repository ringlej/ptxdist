# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PIXMAN) += host-pixman

#
# Paths and names
#
HOST_PIXMAN_DIR	= $(HOST_BUILDDIR)/$(PIXMAN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-pixman.get: $(STATEDIR)/pixman.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-pixman.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_PIXMAN_DIR))
	@$(call extract, PIXMAN, $(HOST_BUILDDIR))
	@$(call patchin, PIXMAN, $(HOST_PIXMAN_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PIXMAN_PATH	:= PATH=$(HOST_PATH)
HOST_PIXMAN_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PIXMAN_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-pixman.prepare:
	@$(call targetinfo)
	@$(call clean, $(HOST_PIXMAN_DIR)/config.cache)
	cd $(HOST_PIXMAN_DIR) && \
		$(HOST_PIXMAN_PATH) $(HOST_PIXMAN_ENV) \
		./configure $(HOST_PIXMAN_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-pixman.compile:
	@$(call targetinfo)
	cd $(HOST_PIXMAN_DIR) && $(HOST_PIXMAN_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-pixman.install:
	@$(call targetinfo)
	@$(call install, HOST_PIXMAN,,h)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-pixman_clean:
	rm -rf $(STATEDIR)/host-pixman.*
	rm -rf $(HOST_PIXMAN_DIR)

# vim: syntax=make
