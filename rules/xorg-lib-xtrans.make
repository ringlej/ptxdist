# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
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
PACKAGES-$(PTXCONF_XORG_LIB_XTRANS) += xorg-lib-xtrans

#
# Paths and names
#
XORG_LIB_XTRANS_VERSION	:= 1.3.5
XORG_LIB_XTRANS_MD5	:= c5ba432dd1514d858053ffe9f4737dd8
XORG_LIB_XTRANS		:= xtrans-$(XORG_LIB_XTRANS_VERSION)
XORG_LIB_XTRANS_SUFFIX	:= tar.bz2
XORG_LIB_XTRANS_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XTRANS).$(XORG_LIB_XTRANS_SUFFIX))
XORG_LIB_XTRANS_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTRANS).$(XORG_LIB_XTRANS_SUFFIX)
XORG_LIB_XTRANS_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTRANS)
XORG_LIB_XTRANS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XTRANS_CONF_TOOL	:= autoconf
XORG_LIB_XTRANS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make
