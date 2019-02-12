# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_FONTCONFIG) += host-fontconfig

#
# Paths and names
#
HOST_FONTCONFIG_DIR	= $(HOST_BUILDDIR)/$(FONTCONFIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FONTCONFIG_CONF_ENV	:= \
	$(HOST_ENV) \
	ac_cv_prog_HASDOCBOOK=no

#
# autoconf
#
HOST_FONTCONFIG_CONF_TOOL := autoconf
HOST_FONTCONFIG_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--disable-nls \
	--disable-rpath \
	--disable-iconv \
	--disable-libxml2 \
	--disable-docs \
	--with-arch=$(PTXCONF_ARCH_STRING) \
	--with-default-fonts=$(XORG_FONTDIR) \
	--with-cache-dir=$(PTXCONF_SYSROOT_HOST)/var/cache/fontconfig

HOST_FONTCONFIG_MAKE_PAR := NO

# vim: syntax=make
