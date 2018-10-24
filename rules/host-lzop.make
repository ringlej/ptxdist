# -*-makefile-*-
#
# Copyright (C) 2010, 2011 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_LZOP_VERSION	:= 1.04
HOST_LZOP_MD5		:= 271eb10fde77a0a96b9cbf745e719ddf
HOST_LZOP		:= lzop-$(HOST_LZOP_VERSION)
HOST_LZOP_SUFFIX	:= tar.gz
HOST_LZOP_URL		:= http://www.lzop.org/download/$(HOST_LZOP).$(HOST_LZOP_SUFFIX)
HOST_LZOP_SOURCE	:= $(SRCDIR)/$(HOST_LZOP).$(HOST_LZOP_SUFFIX)
HOST_LZOP_DIR		:= $(HOST_BUILDDIR)/$(HOST_LZOP)
HOST_LZOP_LICENSE	:= GPL-2.0-or-later
HOST_LZOP_LICENSE_FILES	:= file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LZOP_CONF_TOOL	:= autoconf
HOST_LZOP_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-asm \
	--disable-ansi

# vim: syntax=make
