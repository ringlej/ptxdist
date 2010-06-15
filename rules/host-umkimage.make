# -*-makefile-*-
#
# Copyright (C) 2003-2006 by Pengutronix e.K., Hildesheim, Germany
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UMKIMAGE) += host-umkimage


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_UMKIMAGE_CONF_TOOL	:= NO
HOST_UMKIMAGE_MAKE_OPT := \
	$(HOST_ENV_CPPFLAGS) \
	$(HOST_ENV_LDFLAGS) \
	$(HOST_ENV_CC)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-umkimage.install:
	@$(call targetinfo)
	install $(HOST_UMKIMAGE_DIR)/mkimage $(PTXCONF_SYSROOT_HOST)/bin/mkimage
	@$(call touch)

# vim: syntax=make
