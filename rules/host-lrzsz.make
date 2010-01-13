# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LRZSZ) += host-lrzsz

#
# Paths and names
#
HOST_LRZSZ_DIR	= $(HOST_BUILDDIR)/$(LRZSZ)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-lrzsz.get: $(STATEDIR)/lrzsz.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-lrzsz.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_LRZSZ_DIR))
	@$(call extract, LRZSZ, $(HOST_BUILDDIR))
	@$(call patchin, LRZSZ, $(HOST_LRZSZ_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LRZSZ_PATH	:= PATH=$(HOST_PATH)
HOST_LRZSZ_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LRZSZ_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-lrzsz.install:
	@$(call targetinfo)
	@$(call install, HOST_LRZSZ,,h)
	@$(call touch)

# vim: syntax=make
