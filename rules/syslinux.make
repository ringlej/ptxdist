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
PACKAGES-$(PTXCONF_SYSLINUX) += syslinux

#
# Paths and names
#
SYSLINUX_VERSION	:= 3.84
SYSLINUX		:= syslinux-$(SYSLINUX_VERSION)
SYSLINUX_SUFFIX		:= tar.bz2
SYSLINUX_URL		:= http://www.kernel.org/pub/linux/utils/boot/syslinux/$(SYSLINUX).$(SYSLINUX_SUFFIX)
SYSLINUX_SOURCE		:= $(SRCDIR)/$(SYSLINUX).$(SYSLINUX_SUFFIX)
SYSLINUX_DIR		:= $(BUILDDIR)/$(SYSLINUX)
SYSLINUX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SYSLINUX_SOURCE):
	@$(call targetinfo)
	@$(call get, SYSLINUX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSLINUX_MAKE_OPT := $(CROSS_ENV_PROGS)
SYSLINUX_INSTALL_OPT := install INSTALLROOT=$(SYSLINUX_PKGDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/syslinux.targetinstall:
	@$(call targetinfo)
# no ipkg
	@$(call touch)

# vim: syntax=make
