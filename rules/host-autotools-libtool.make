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
LAZY_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_LIBTOOL) += host-autotools-libtool

#
# Paths and names
#
HOST_AUTOTOOLS_LIBTOOL_VERSION	:= 2.2.6
HOST_AUTOTOOLS_LIBTOOL		:= libtool-$(HOST_AUTOTOOLS_LIBTOOL_VERSION)
HOST_AUTOTOOLS_LIBTOOL_SUFFIX	:= tar.gz
HOST_AUTOTOOLS_LIBTOOL_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/libtool/$(HOST_AUTOTOOLS_LIBTOOL)a.$(HOST_AUTOTOOLS_LIBTOOL_SUFFIX)
HOST_AUTOTOOLS_LIBTOOL_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_LIBTOOL)a.$(HOST_AUTOTOOLS_LIBTOOL_SUFFIX)
HOST_AUTOTOOLS_LIBTOOL_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_LIBTOOL)
HOST_AUTOTOOLS_LIBTOOL_DEVPKG	:= NO

$(STATEDIR)/autogen-tools: $(STATEDIR)/host-autotools-libtool.install.post

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_AUTOTOOLS_LIBTOOL_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_AUTOTOOLS_LIBTOOL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_AUTOTOOLS_LIBTOOL_CONFTOOL	:= autoconf

# vim: syntax=make
