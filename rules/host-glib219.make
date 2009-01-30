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
HOST_PACKAGES-$(PTXCONF_HOST_GLIB219) += host-glib219

#
# Paths and names
#
HOST_GLIB219_DIR	= $(HOST_BUILDDIR)/$(GLIB219)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glib219.get: $(STATEDIR)/glib219.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glib219.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_GLIB219_DIR))
	@$(call extract, GLIB219, $(HOST_BUILDDIR))
	@$(call patchin, GLIB219, $(HOST_GLIB219_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLIB219_PATH	:= PATH=$(HOST_PATH)
HOST_GLIB219_ENV 	:= $(HOST_ENV)

#
# autoconf
#
# libiconv: hardcode to libiconv (gnu), because 'no' does not work
#
HOST_GLIB219_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--with-libiconv=gnu

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glib219_clean:
	rm -rf $(STATEDIR)/host-glib219.*
	rm -rf $(HOST_GLIB219_DIR)

# vim: syntax=make
