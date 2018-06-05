# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPAPER) += libpaper

#
# Paths and names
#
# libpaper seems to be maintained only as a Debian package, therefore the
# unusual versioning.
#
LIBPAPER_VERSION	:= 1.1.24+nmu5
LIBPAPER_MD5		:= 38bc55688c0fc5544edaa5a951a45fbd
LIBPAPER		:= libpaper-$(LIBPAPER_VERSION)
LIBPAPER_SUFFIX		:= tar.gz
LIBPAPER_URL		:= http://snapshot.debian.org/archive/debian-debug/20161113T151229Z/pool/main/libp/libpaper/libpaper_$(LIBPAPER_VERSION).$(LIBPAPER_SUFFIX)
LIBPAPER_SOURCE		:= $(SRCDIR)/$(LIBPAPER).$(LIBPAPER_SUFFIX)
LIBPAPER_DIR		:= $(BUILDDIR)/$(LIBPAPER)
LIBPAPER_LICENSE	:= GPL-2.0-only
LIBPAPER_LICENSE_FILES	:= file://COPYING;md5=0278281246c1e59af1ef0ae1784a4948

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPAPER_CONF_ENV	:= \
	$(CROSS_ENV) \
	PAPERSIZE=$(PTXCONF_LIBPAPER_SIZE)
#
# autoconf
#
LIBPAPER_CONF_TOOL := autoconf
#
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpaper.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpaper)
	@$(call install_fixup, libpaper,PRIORITY,optional)
	@$(call install_fixup, libpaper,SECTION,base)
	@$(call install_fixup, libpaper,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, libpaper,DESCRIPTION,missing)

	@$(call install_lib, libpaper, 0, 0, 0644, libpaper)

ifdef PTXCONF_LIBPAPER_PAPERCONFIG
	@$(call install_copy, libpaper, 0, 0, 755, -, /usr/sbin/paperconfig)
endif
ifdef PTXCONF_LIBPAPER_PAPERCONF
	@$(call install_copy, libpaper, 0, 0, 755, -, /usr/bin/paperconf)
endif

	@$(call install_finish, libpaper)

	@$(call touch)

# vim: ft=make ts=8 noet tw=80
