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
HOST_LZOP_VERSION	:= 1.03
HOST_LZOP_MD5		:= 006c5e27fb78cdd14a628fdfa5aa1905
HOST_LZOP		:= lzop-$(HOST_LZOP_VERSION)
HOST_LZOP_SUFFIX	:= tar.gz
HOST_LZOP_URL		:= http://www.lzop.org/download/$(HOST_LZOP).$(HOST_LZOP_SUFFIX)
HOST_LZOP_SOURCE	:= $(SRCDIR)/$(HOST_LZOP).$(HOST_LZOP_SUFFIX)
HOST_LZOP_DIR		:= $(HOST_BUILDDIR)/$(HOST_LZOP)
HOST_LZOP_LICENSE	:= GPL-2.0-or-later
HOST_LZOP_LICENSE_FILES	:= file://COPYING;md5=dfeaf3dc4beef4f5a7bdbc35b197f39e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LZOP_CONF_TOOL	:= autoconf

# This is needed to pass configure check with host-gcc 6.1
# Otherwise, we get "error: ACC conformance test failed"
HOST_LZOP_CFLAGS	:= -std=c90 -fPIC

# vim: syntax=make
