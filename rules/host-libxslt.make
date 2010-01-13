# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBXSLT) += host-libxslt

#
# Paths and names
#
HOST_LIBXSLT_DIR	= $(HOST_BUILDDIR)/$(LIBXSLT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libxslt.get: $(STATEDIR)/libxslt.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBXSLT_PATH	:= PATH=$(HOST_PATH)
HOST_LIBXSLT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBXSLT_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--without-crypto

# vim: syntax=make
