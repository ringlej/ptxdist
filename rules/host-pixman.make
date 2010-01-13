# -*-makefile-*-
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
# Prepare
# ----------------------------------------------------------------------------

HOST_PIXMAN_PATH	:= PATH=$(HOST_PATH)
HOST_PIXMAN_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PIXMAN_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
