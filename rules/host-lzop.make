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
HOST_PACKAGES-$(PTXCONF_HOST_LZOP) += host-lzop

#
# Paths and names
#
HOST_LZOP_VERSION	:= 1.02rc1
HOST_LZOP		:= lzop-$(HOST_LZOP_VERSION)
HOST_LZOP_SUFFIX	:= tar.gz
HOST_LZOP_URL		:= http://www.lzop.org/download/$(HOST_LZOP).$(HOST_LZOP_SUFFIX)
HOST_LZOP_SOURCE	:= $(SRCDIR)/$(HOST_LZOP).$(HOST_LZOP_SUFFIX)
HOST_LZOP_DIR		:= $(HOST_BUILDDIR)/$(HOST_LZOP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_LZOP_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_LZOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LZOP_CONF_TOOL	:= autoconf

# vim: syntax=make
