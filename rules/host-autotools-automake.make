# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_AUTOMAKE) += host-autotools-automake

#
# Paths and names
#
HOST_AUTOTOOLS_AUTOMAKE_VERSION	:= 1.11
HOST_AUTOTOOLS_AUTOMAKE		:= automake-$(HOST_AUTOTOOLS_AUTOMAKE_VERSION)
HOST_AUTOTOOLS_AUTOMAKE_SUFFIX	:= tar.bz2
HOST_AUTOTOOLS_AUTOMAKE_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/automake/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX)
HOST_AUTOTOOLS_AUTOMAKE_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX)
HOST_AUTOTOOLS_AUTOMAKE_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_AUTOMAKE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_AUTOTOOLS_AUTOMAKE_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_AUTOTOOLS_AUTOMAKE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_AUTOTOOLS_AUTOMAKE_PATH	:= PATH=$(HOST_PATH)
HOST_AUTOTOOLS_AUTOMAKE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_AUTOTOOLS_AUTOMAKE_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-autotools-automake_clean:
	rm -rf $(STATEDIR)/host-autotools-automake.*
	rm -rf $(HOST_AUTOTOOLS_AUTOMAKE_DIR)

# vim: syntax=make
