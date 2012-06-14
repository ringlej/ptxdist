# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
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

#
HOST_PACKAGES-$(PTXCONF_HOST_MKELFIMAGE) += host-mkelfimage

#
# Paths and names
#
HOST_MKELFIMAGE_VERSION	:= 2.7
HOST_MKELFIMAGE_MD5	:= 6046f15f070443fbfa7c2a11e449f801
HOST_MKELFIMAGE		:= mkelfImage-$(HOST_MKELFIMAGE_VERSION)
HOST_MKELFIMAGE_SUFFIX	:= tar.gz
HOST_MKELFIMAGE_URL	:= \
	ftp://ftp.lnxi.com/pub/mkelfImage/$(HOST_MKELFIMAGE).$(HOST_MKELFIMAGE_SUFFIX) \
	ftp://ftp.bootsplash.org/pub/mirrors/ftp.lnxi.com/pub/mkelfImage/$(HOST_MKELFIMAGE).$(HOST_MKELFIMAGE_SUFFIX)
HOST_MKELFIMAGE_SOURCE	:= $(SRCDIR)/$(HOST_MKELFIMAGE).$(HOST_MKELFIMAGE_SUFFIX)
HOST_MKELFIMAGE_DIR	:= $(HOST_BUILDDIR)/$(HOST_MKELFIMAGE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MKELFIMAGE_PATH	:= PATH=$(HOST_PATH)
HOST_MKELFIMAGE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_MKELFIMAGE_AUTOCONF	:= $(HOST_AUTOCONF)

HOST_MKELFIMAGE_MAKE_OPT := MY_CPPFLAGS="$(HOST_CPPFLAGS)" LDFLAGS="$(HOST_LDFLAGS)"

# vim: syntax=make
