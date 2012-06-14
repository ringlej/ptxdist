# -*-makefile-*-
#
# Copyright (C) 2007-2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009 by Marc Kleine-Budde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBICONV) += host-libiconv

#
# Paths and names
#
HOST_LIBICONV_VERSION	:= 1.13.1
HOST_LIBICONV_MD5	:= 7ab33ebd26687c744a37264a330bbe9a
HOST_LIBICONV		:= libiconv-$(HOST_LIBICONV_VERSION)
HOST_LIBICONV_SUFFIX	:= tar.gz
HOST_LIBICONV_URL	:= $(call ptx/mirror, GNU, libiconv/$(HOST_LIBICONV).$(HOST_LIBICONV_SUFFIX))
HOST_LIBICONV_SOURCE	:= $(SRCDIR)/$(HOST_LIBICONV).$(HOST_LIBICONV_SUFFIX)
HOST_LIBICONV_DIR	:= $(HOST_BUILDDIR)/$(HOST_LIBICONV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBICONV_PATH	:= PATH=$(HOST_PATH)
HOST_LIBICONV_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBICONV_AUTOCONF	:= \
	$(HOST_AUTOCONF)

# vim: syntax=make
