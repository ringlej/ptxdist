# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XZ) += host-xz

#
# Paths and names
#
HOST_XZ_VERSION	:= 4.999.9beta
HOST_XZ		:= xz-$(HOST_XZ_VERSION)
HOST_XZ_SUFFIX	:= tar.bz2
HOST_XZ_URL	:= http://tukaani.org/xz/$(HOST_XZ).$(HOST_XZ_SUFFIX)
HOST_XZ_SOURCE	:= $(SRCDIR)/$(HOST_XZ).$(HOST_XZ_SUFFIX)
HOST_XZ_DIR	:= $(HOST_BUILDDIR)/$(HOST_XZ)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_XZ_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_XZ)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XZ_PATH	:= PATH=$(HOST_PATH)
HOST_XZ_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XZ_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
