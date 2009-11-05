# -*-makefile-*-
#
# Copyright (C) 2006 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ZLIB) += host-zlib

#
# Paths and names
#
HOST_ZLIB_DIR	= $(HOST_BUILDDIR)/$(ZLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-zlib.get: $(STATEDIR)/zlib.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-zlib.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_ZLIB_DIR))
	@$(call extract, ZLIB, $(HOST_BUILDDIR))
	@$(call patchin, ZLIB, $(HOST_ZLIB_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ZLIB_PATH	:= PATH=$(HOST_PATH)
HOST_ZLIB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_ZLIB_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-zlib_clean:
	rm -rf $(STATEDIR)/host-zlib.*
	rm -rf $(HOST_ZLIB_DIR)

# vim: syntax=make
