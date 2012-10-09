# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBGCRYPT) += host-libgcrypt

#
# this is just a dummy package to provide libgcrypt.m4
#

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBGCRYPT_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libgcrypt.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libgcrypt.install:
	@$(call targetinfo)
	install -D -m 644 $(HOST_LIBGCRYPT_DIR)/src/libgcrypt.m4 \
		$(HOST_LIBGCRYPT_PKGDIR)/share/aclocal/libgcrypt.m4
	@$(call touch)

# vim: syntax=make
