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
HOST_PACKAGES-$(PTXCONF_HOST_CAIRO) += host-cairo

#
# Paths and names
#
HOST_CAIRO_DIR	= $(HOST_BUILDDIR)/$(CAIRO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-cairo.get: $(STATEDIR)/cairo.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CAIRO_PATH	:= PATH=$(HOST_PATH)
HOST_CAIRO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_CAIRO_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-quartz \
	--disable-xcb \
	--disable-beos \
	--disable-glitz \
	--enable-svg \
	--disable-atsui \
	--enable-xlib \
	--disable-directfb \
	--disable-win32 \
	--disable-win32-font \
	--enable-freetype

ifdef PTXCONF_HOST_CAIRO_PS
HOST_CAIRO_AUTOCONF += --enable-ps
else
HOST_CAIRO_AUTOCONF +=--disable-ps
endif

ifdef PTXCONF_HOST_CAIRO_PDF
HOST_CAIRO_AUTOCONF += --enable-pdf
else
HOST_CAIRO_AUTOCONF +=--disable-pdf
endif

ifdef PTXCONF_HOST_CAIRO_PNG
HOST_CAIRO_AUTOCONF += --enable-png
else
HOST_CAIRO_AUTOCONF += --disable-png
endif

# vim: syntax=make
