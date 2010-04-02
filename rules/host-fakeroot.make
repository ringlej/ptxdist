# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FAKEROOT) += host-fakeroot

#
# Paths and names
#
HOST_FAKEROOT_VERSION	:= 1.14.4
HOST_FAKEROOT_SUFFIX	:= tar.bz2
HOST_FAKEROOT		:= fakeroot-$(HOST_FAKEROOT_VERSION)
HOST_FAKEROOT_TARBALL	:= fakeroot_$(HOST_FAKEROOT_VERSION).orig.$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/f/fakeroot/$(HOST_FAKEROOT_TARBALL)
HOST_FAKEROOT_SOURCE	:= $(SRCDIR)/$(HOST_FAKEROOT_TARBALL)
HOST_FAKEROOT_DIR	:= $(HOST_BUILDDIR)/$(HOST_FAKEROOT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_FAKEROOT_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_FAKEROOT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FAKEROOT_CONF_TOOL := autoconf

# vim: syntax=make
