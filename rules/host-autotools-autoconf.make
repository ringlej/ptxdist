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
HOST_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_AUTOCONF) += host-autotools-autoconf

#
# Paths and names
#
HOST_AUTOTOOLS_AUTOCONF_VERSION	:= 2.64
HOST_AUTOTOOLS_AUTOCONF		:= autoconf-$(HOST_AUTOTOOLS_AUTOCONF_VERSION)
HOST_AUTOTOOLS_AUTOCONF_SUFFIX	:= tar.bz2
HOST_AUTOTOOLS_AUTOCONF_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/autoconf/$(HOST_AUTOTOOLS_AUTOCONF).$(HOST_AUTOTOOLS_AUTOCONF_SUFFIX)
HOST_AUTOTOOLS_AUTOCONF_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_AUTOCONF).$(HOST_AUTOTOOLS_AUTOCONF_SUFFIX)
HOST_AUTOTOOLS_AUTOCONF_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_AUTOCONF)

$(STATEDIR)/autogen-tools: $(STATEDIR)/host-autotools-autoconf.install.post

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_AUTOTOOLS_AUTOCONF_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_AUTOTOOLS_AUTOCONF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_AUTOTOOLS_AUTOCONF_PATH	:= PATH=$(HOST_PATH)
HOST_AUTOTOOLS_AUTOCONF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_AUTOTOOLS_AUTOCONF_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
