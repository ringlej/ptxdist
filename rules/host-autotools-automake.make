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
LAZY_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_AUTOMAKE) += host-autotools-automake

#
# Paths and names
#
HOST_AUTOTOOLS_AUTOMAKE_VERSION	:= 1.11.1
HOST_AUTOTOOLS_AUTOMAKE_MD5	:= c2972c4d9b3e29c03d5f2af86249876f
HOST_AUTOTOOLS_AUTOMAKE		:= automake-$(HOST_AUTOTOOLS_AUTOMAKE_VERSION)
HOST_AUTOTOOLS_AUTOMAKE_SUFFIX	:= tar.bz2
HOST_AUTOTOOLS_AUTOMAKE_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/automake/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX)
HOST_AUTOTOOLS_AUTOMAKE_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX)
HOST_AUTOTOOLS_AUTOMAKE_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_AUTOMAKE)
HOST_AUTOTOOLS_AUTOMAKE_DEVPKG	:= NO

$(STATEDIR)/autogen-tools: $(STATEDIR)/host-autotools-automake.install.post

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_AUTOTOOLS_AUTOMAKE_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_AUTOTOOLS_AUTOMAKE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_AUTOTOOLS_AUTOMAKE_CONF_TOOL	:= autoconf

# vim: syntax=make
