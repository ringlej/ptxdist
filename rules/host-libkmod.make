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
HOST_PACKAGES-$(PTXCONF_HOST_LIBKMOD) += host-libkmod

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBKMOD_CONF_TOOL	:= autoconf
HOST_LIBKMOD_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--enable-shared \
	--enable-tools \
	--disable-logging \
	--disable-debug \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--without-xz \
	--without-zlib

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libkmod.install:
	@$(call targetinfo)
	@$(call world/install, HOST_LIBKMOD)
	@ln -s ../bin/kmod $(HOST_LIBKMOD_PKGDIR)/sbin/depmod
	@$(call touch)

# vim: syntax=make
