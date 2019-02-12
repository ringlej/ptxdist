# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_OPENSC) += host-opensc

#
# Paths and names
#
HOST_OPENSC_VERSION	:= 0.19.0
HOST_OPENSC_MD5		:= 40734b2343cf83c62c4c403f8a37475e
HOST_OPENSC		:= opensc-$(HOST_OPENSC_VERSION)
HOST_OPENSC_SUFFIX	:= tar.gz
HOST_OPENSC_URL		:= https://github.com/OpenSC/OpenSC/releases/download/0.19.0/$(HOST_OPENSC).$(HOST_OPENSC_SUFFIX)
HOST_OPENSC_SOURCE	:= $(SRCDIR)/$(HOST_OPENSC).$(HOST_OPENSC_SUFFIX)
HOST_OPENSC_DIR		:= $(HOST_BUILDDIR)/$(HOST_OPENSC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_OPENSC_CONF_TOOL	:= autoconf
HOST_OPENSC_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--sysconfdir=/etc/opensc \
	--disable-zlib \
	--disable-readline \
	--enable-openssl \
	--disable-openpace \
	--disable-openct \
	--disable-pcsc \
	--disable-cryptotokenkit \
	--enable-ctapi \
	--disable-minidriver \
	--enable-sm \
	--disable-man \
	--disable-doc \
	--disable-dnie-ui \
	--disable-notify \
	--enable-tests=no \
	--disable-static

HOST_OPENSC_CPPFLAGS := -Wno-implicit-fallthrough

# vim: syntax=make
