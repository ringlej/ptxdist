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
HOST_FAKEROOT_VERSION	:= 1.21
HOST_FAKEROOT_MD5	:= be5c9a0e516869fca4a6758105968e5a
HOST_FAKEROOT_SUFFIX	:= tar.gz
HOST_FAKEROOT		:= fakeroot-$(HOST_FAKEROOT_VERSION)
HOST_FAKEROOT_TARBALL	:= fakeroot_$(HOST_FAKEROOT_VERSION).orig.$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_URL	:= $(call ptx/mirror, DEB, pool/main/f/fakeroot/$(HOST_FAKEROOT_TARBALL))
HOST_FAKEROOT_SOURCE	:= $(SRCDIR)/$(HOST_FAKEROOT_TARBALL)
HOST_FAKEROOT_DIR	:= $(HOST_BUILDDIR)/$(HOST_FAKEROOT)
HOST_FAKEROOT_LICENSE	:= GPL-3.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FAKEROOT_CONF_ENV	:= \
	$(HOST_ENV) \
	CONFIG_SHELL=/bin/bash

HOST_FAKEROOT_CONF_TOOL := autoconf
HOST_FAKEROOT_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--libdir=/lib/fakeroot

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-fakeroot.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_FAKEROOT)
	@sed -i -e 's,FAKEROOT_SYSROOT,$(PTXCONF_SYSROOT_HOST),' \
		$(PTXCONF_SYSROOT_HOST)/bin/fakeroot
	@$(call touch)

# vim: syntax=make
