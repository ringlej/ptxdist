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
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libxslt.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_LIBXSLT_DIR))
	@$(call extract, LIBXSLT, $(HOST_BUILDDIR))
	@$(call patchin, LIBXSLT, $(HOST_LIBXSLT_DIR))
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

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libxslt_clean:
	rm -rf $(STATEDIR)/host-libxslt.*
	rm -rf $(HOST_LIBXSLT_DIR)

# vim: syntax=make
