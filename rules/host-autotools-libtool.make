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
HOST_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_LIBTOOL) += host-autotools-libtool

#
# Paths and names
#
HOST_AUTOTOOLS_LIBTOOL_VERSION	:= 2.2.6
HOST_AUTOTOOLS_LIBTOOL		:= libtool-$(HOST_AUTOTOOLS_LIBTOOL_VERSION)
HOST_AUTOTOOLS_LIBTOOL_SUFFIX	:= tar.gz
HOST_AUTOTOOLS_LIBTOOL_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/libtool/$(HOST_AUTOTOOLS_LIBTOOL)a.$(HOST_AUTOTOOLS_LIBTOOL_SUFFIX)
HOST_AUTOTOOLS_LIBTOOL_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_LIBTOOL)a.$(HOST_AUTOTOOLS_LIBTOOL_SUFFIX)
HOST_AUTOTOOLS_LIBTOOL_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_LIBTOOL)

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

HOST_AUTOTOOLS_LIBTOOL_PATH	:= PATH=$(HOST_PATH)
HOST_AUTOTOOLS_LIBTOOL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_AUTOTOOLS_LIBTOOL_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-autotools-libtool_clean:
	rm -rf $(STATEDIR)/host-autotools-libtool.*
	rm -rf $(HOST_AUTOTOOLS_LIBTOOL_DIR)

# vim: syntax=make
