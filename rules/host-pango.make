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
HOST_PACKAGES-$(PTXCONF_HOST_PANGO) += host-pango

#
# Paths and names
#
HOST_PANGO_DIR	= $(HOST_BUILDDIR)/$(PANGO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PANGO_PATH	:= PATH=$(HOST_PATH)
HOST_PANGO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
ifdef PTXCONF_HOST_PANGO_BASIC
HOST_PANGO_MODULES += basic-fc,basic-win32,basic-x,basic-atsui
endif

ifdef PTXCONF_HOST_PANGO_ARABIC
HOST_PANGO_MODULES += arabic-fc
endif

ifdef PTXCONF_HOST_PANGO_HANGUL
HOST_PANGO_MODULES += hangul-fc
endif

ifdef PTXCONF_HOST_PANGO_HEBREW
HOST_PANGO_MODULES += hebrew-fc
endif

ifdef PTXCONF_HOST_PANGO_INDIC
HOST_PANGO_MODULES += indic-fc,indic-lang
endif

ifdef PTXCONF_HOST_PANGO_KHMER
HOST_PANGO_MODULES += khmer-fc
endif

ifdef PTXCONF_HOST_PANGO_SYRIAC
HOST_PANGO_MODULES += syriac-fc
endif

ifdef PTXCONF_HOST_PANGO_THAI
HOST_PANGO_MODULES += thai-fc
endif

ifdef PTXCONF_HOST_PANGO_TIBETAN
HOST_PANGO_MODULES += tibetan-fc
endif

HOST_PANGO_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-explicit-deps=yes \
	--without-dynamic-modules \
	--with-included-modules=$(subst $(space),$(comma),$(HOST_PANGO_MODULES))

#ifdef PTXCONF_PANGO_TARGET_X11
#HOST_PANGO_AUTOCONF += --with-x=$(SYSROOT)/usr
#else
#HOST_PANGO_AUTOCONF += --without-x
#endif

# vim: syntax=make
