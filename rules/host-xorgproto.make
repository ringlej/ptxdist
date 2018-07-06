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
HOST_PACKAGES-$(PTXCONF_HOST_XORGPROTO) += host-xorgproto

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORGPROTO_CONF_TOOL	:= autoconf
HOST_XORGPROTO_CONF_OPT		:= \
	$(HOST_AUTOCONF) \
	--disable-selective-werror \
	--disable-strict-compilation \
	--enable-specs \
	--disable-legacy \
	--without-xmlto \
	--without-fop \
	--without-xsltproc

# vim: syntax=make
