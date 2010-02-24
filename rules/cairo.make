# -*-makefile-*-
#
# Copyright (C) 2006, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CAIRO) += cairo

#
# Paths and names
#
CAIRO_SUFFIX	:= tar.gz
CAIRO_VERSION	:= 1.8.10
CAIRO_URL	:= http://cairographics.org/releases/cairo-$(CAIRO_VERSION).$(CAIRO_SUFFIX)
CAIRO		:= cairo-$(CAIRO_VERSION)
CAIRO_SOURCE	:= $(SRCDIR)/$(CAIRO).$(CAIRO_SUFFIX)
CAIRO_DIR	:= $(BUILDDIR)/$(CAIRO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CAIRO_SOURCE):
	@$(call targetinfo)
	@$(call get, CAIRO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CAIRO_PATH	:= PATH=$(CROSS_PATH)
CAIRO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CAIRO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--disable-gtk-doc \
	--disable-gcov \
	--disable-xlib-xrender \
	--disable-xcb \
	--disable-quartz \
	--disable-quartz-font \
	--disable-quartz-image \
	--disable-os2 \
	--disable-beos \
	--disable-glitz \
	--enable-pthread \
	--disable-test-surfaces

ifdef PTXCONF_CAIRO_XLIB
CAIRO_AUTOCONF += --enable-xlib
else
CAIRO_AUTOCONF += \
	--disable-xlib \
	--without-x
endif

ifdef PTXCONF_CAIRO_WIN32
CAIRO_AUTOCONF += \
	--enable-win32 \
	--enable-win32-font
else
CAIRO_AUTOCONF += \
	--disable-win32 \
	--disable-win32-font
endif

ifdef PTXCONF_CAIRO_SVG
CAIRO_AUTOCONF += --enable-svg
else
CAIRO_AUTOCONF += --disable-svg
endif

ifdef PTXCONF_CAIRO_PNG
CAIRO_AUTOCONF += --enable-png
else
CAIRO_AUTOCONF += --disable-png
endif

ifdef PTXCONF_CAIRO_DIRECTFB
CAIRO_AUTOCONF += --enable-directfb
else
CAIRO_AUTOCONF += --disable-directfb
endif

ifdef PTXCONF_CAIRO_FREETYPE
CAIRO_AUTOCONF += --enable-ft
else
CAIRO_AUTOCONF += --disable-ft
endif

ifdef PTXCONF_CAIRO_PS
CAIRO_AUTOCONF += --enable-ps
else
CAIRO_AUTOCONF += --disable-ps
endif

ifdef PTXCONF_CAIRO_PDF
CAIRO_AUTOCONF += --enable-pdf
else
CAIRO_AUTOCONF += --disable-pdf
endif

ifdef PTXCONF_HAS_HARDFLOAT
CAIRO_AUTOCONF += --enable-some-floating-point
else
CAIRO_AUTOCONF += --disable-some-floating-point
endif

#  --with-x                use the X Window System

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cairo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cairo)
	@$(call install_fixup,cairo,PACKAGE,cairo)
	@$(call install_fixup,cairo,PRIORITY,optional)
	@$(call install_fixup,cairo,VERSION,$(CAIRO_VERSION))
	@$(call install_fixup,cairo,SECTION,base)
	@$(call install_fixup,cairo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,cairo,DEPENDS,)
	@$(call install_fixup,cairo,DESCRIPTION,missing)

	@$(call install_copy, cairo, 0, 0, 0644, -, /usr/lib/libcairo.so.2.10800.10)
	@$(call install_link, cairo, libcairo.so.2.10800.10, /usr/lib/libcairo.so.2)
	@$(call install_link, cairo, libcairo.so.2.10800.10, /usr/lib/libcairo.so)

	@$(call install_finish,cairo)

	@$(call touch)

# vim: syntax=make
