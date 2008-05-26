# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GLIB) += host-glib

#
# Paths and names
#
HOST_GLIB_DIR	= $(HOST_BUILDDIR)/$(GLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glib.get: $(STATEDIR)/glib.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glib.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_GLIB_DIR))
	@$(call extract, GLIB, $(HOST_BUILDDIR))
	@$(call patchin, GLIB, $(HOST_GLIB_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLIB_PATH	:= PATH=$(HOST_PATH)
HOST_GLIB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
# libiconv: hardcode to libiconv (gnu), because 'no' does not work
#
HOST_GLIB_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--with-libiconv=gnu

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glib_clean:
	rm -rf $(STATEDIR)/host-glib.*
	rm -rf $(HOST_GLIB_DIR)

# vim: syntax=make
