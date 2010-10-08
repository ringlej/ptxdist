# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CHRPATH) += host-chrpath

#
# Paths and names
#
HOST_CHRPATH_VERSION	:= 0.13
HOST_CHRPATH_MD5	:= b73072a8fbba277558c50364b65bb407
HOST_CHRPATH		:= chrpath-$(HOST_CHRPATH_VERSION)
HOST_CHRPATH_SUFFIX	:= tar.gz
HOST_CHRPATH_URL	:= \
	ftp://ftp.hungry.com/pub/hungry/chrpath/$(HOST_CHRPATH).$(HOST_CHRPATH_SUFFIX) \
	http://ftp.tux.org/pub/X-Windows/ftp.hungry.com/chrpath/$(HOST_CHRPATH).$(HOST_CHRPATH_SUFFIX)
HOST_CHRPATH_SOURCE	:= $(SRCDIR)/$(HOST_CHRPATH).$(HOST_CHRPATH_SUFFIX)
HOST_CHRPATH_DIR	:= $(HOST_BUILDDIR)/$(HOST_CHRPATH)
HOST_CHRPATH_DEVPKG	:= NO

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_CHRPATH_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_CHRPATH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CHRPATH_CONF_TOOL	:= autoconf

# vim: syntax=make
