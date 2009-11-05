# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_E2FSPROGS) += host-e2fsprogs

#
# Paths and names
#
HOST_E2FSPROGS		= $(E2FSPROGS)
HOST_E2FSPROGS_DIR	= $(HOST_BUILDDIR)/$(HOST_E2FSPROGS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-e2fsprogs.get:	$(STATEDIR)/e2fsprogs.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-e2fsprogs.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_E2FSPROGS_DIR))
	@$(call extract, E2FSPROGS, $(HOST_BUILDDIR))
	@$(call patchin, E2FSPROGS, $(HOST_E2FSPROGS_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_E2FSPROGS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_E2FSPROGS_AUTOCONF := $(HOST_AUTOCONF)
HOST_E2FSPROGS_INSTALL_OPT := install install-libs

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-e2fsprogs_clean:
	rm -rf $(STATEDIR)/host-e2fsprogs.*
	rm -rf $(HOST_E2FSPROGS_DIR)

# vim: syntax=make

