# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MTOOLS) += host-mtools

#
# Paths and names
#
HOST_MTOOLS_VERSION	:= 4.0.16
HOST_MTOOLS_MD5		:= e9b07f35272210f407012abaf5d1b9b5
HOST_MTOOLS		:= mtools-$(HOST_MTOOLS_VERSION)
HOST_MTOOLS_SUFFIX	:= tar.bz2
HOST_MTOOLS_URL		:= $(call ptx/mirror, GNU, mtools/$(HOST_MTOOLS).$(HOST_MTOOLS_SUFFIX))
HOST_MTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_MTOOLS).$(HOST_MTOOLS_SUFFIX)
HOST_MTOOLS_DIR		:= $(HOST_BUILDDIR)/$(HOST_MTOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# disable iconv because breaks with host-libiconv
HOST_MTOOLS_CONF_ENV	:= \
	$(HOST_ENV) \
	ac_cv_header_iconv_h=no

#
# autoconf
#
HOST_MTOOLS_CONF_TOOL	:= autoconf

HOST_MTOOLS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-xdf \
	--disable-vold \
	--disable-new-vold \
	--disable-debug \
	--disable-floppyd \
	--without-x \
	--enable-raw-term

# vim: syntax=make
