# -*-makefile-*-
#
# Copyright (C) 2011 by George McCollister <george.mccollister@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_OPKG) += host-opkg

#
# Paths and names
#

HOST_OPKG	= $(OPKG)
HOST_OPKG_DIR	= $(HOST_BUILDDIR)/$(HOST_OPKG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_OPKG_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_OPKG_CONF_TOOL	:= autoconf
HOST_OPKG_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-shave \
	--with-opkglockfile=/lock \
	--disable-pathfinder \
	--disable-curl \
	--disable-sha256 \
	--disable-openssl \
	--disable-ssl-curl \
	--disable-gpg

# vim: syntax=make
