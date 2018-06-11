# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORGPROTO) += xorgproto

#
# Paths and names
#
XORGPROTO_VERSION	:= 2018.4
XORGPROTO_MD5		:= 81557ca47ee66a4e54590fcdadd28114
XORGPROTO		:= xorgproto-$(XORGPROTO_VERSION)
XORGPROTO_SUFFIX	:= tar.bz2
XORGPROTO_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORGPROTO).$(XORGPROTO_SUFFIX))
XORGPROTO_SOURCE	:= $(SRCDIR)/$(XORGPROTO).$(XORGPROTO_SUFFIX)
XORGPROTO_DIR		:= $(BUILDDIR)/$(XORGPROTO)
XORGPROTO_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORGPROTO_CONF_TOOL	:= autoconf
XORGPROTO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-selective-werror \
	--disable-strict-compilation \
	--enable-specs \
	--disable-legacy \
	--without-xmlto \
	--without-fop \
	--without-xsltproc

# vim: syntax=make
