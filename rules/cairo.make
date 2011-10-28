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
CAIRO_VERSION	:= 1.10.2
CAIRO_MD5	:= f101a9e88b783337b20b2e26dfd26d5f
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
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--disable-gcov \
	--disable-valgrind \
	--disable-xlib-xrender \
	--disable-xcb \
	--disable-xlib-xcb \
	--disable-xcb-shm \
	--disable-qt \
	--disable-quartz \
	--disable-quartz-font \
	--disable-quartz-image \
	--disable-skia \
	--disable-os2 \
	--disable-beos \
	--disable-drm \
	--disable-drm-xr \
	--disable-gallium \
	--disable-xcb-drm \
	--disable-gl \
	--disable-vg \
	--disable-egl \
	--disable-glx \
	--disable-wgl \
	--disable-script \
	--disable-tee \
	--disable-xml \
	--enable-pthread \
	--$(call ptx/endis, PTXCONF_CAIRO_GOBJECT)-gobject \
	--disable-full-testing \
	--disable-trace \
	--disable-interpreter \
	--disable-symbol-lookup \
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
CAIRO_AUTOCONF += --enable-ft --enable-fc
else
CAIRO_AUTOCONF += --disable-ft --disable-fc
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
	@$(call install_fixup, cairo,PRIORITY,optional)
	@$(call install_fixup, cairo,SECTION,base)
	@$(call install_fixup, cairo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, cairo,DESCRIPTION,missing)

	@$(call install_lib, cairo, 0, 0, 0644, libcairo)

	@$(call install_finish, cairo)

	@$(call touch)

# vim: syntax=make
