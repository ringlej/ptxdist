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
HOST_PACKAGES-$(PTXCONF_HOST_CDRKIT) += host-cdrkit

#
# Paths and names
#
HOST_CDRKIT_VERSION	:= 1.1.10
HOST_CDRKIT		:= cdrkit-$(HOST_CDRKIT_VERSION)
HOST_CDRKIT_SUFFIX	:= tar.gz
HOST_CDRKIT_URL		:= http://cdrkit.org/releases/$(HOST_CDRKIT).$(HOST_CDRKIT_SUFFIX)
HOST_CDRKIT_SOURCE	:= $(SRCDIR)/$(HOST_CDRKIT).$(HOST_CDRKIT_SUFFIX)
HOST_CDRKIT_DIR		:= $(HOST_BUILDDIR)/$(HOST_CDRKIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_CDRKIT_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_CDRKIT)

# vim: syntax=make
