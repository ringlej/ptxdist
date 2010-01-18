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

HOST_FONTCONFIG_PATH	:= PATH=$(HOST_PATH)
HOST_FONTCONFIG_ENV 	:= \
	$(HOST_ENV) \
	ac_cv_prog_HASDOCBOOK=no

#
# autoconf
#
HOST_FONTCONFIG_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-docs \
	--with-cache-dir=$(PTXCONF_SYSROOT_HOST)/var/cache/fontconfig \
	--with-default-fonts=$(XORG_FONTDIR) \
	--with-arch=$(PTXCONF_ARCH_STRING)

HOST_FONTCONFIG_MAKE_PAR := NO

# vim: syntax=make
