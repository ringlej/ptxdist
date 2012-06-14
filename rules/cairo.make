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
	--disable-test-surfaces \
	--$(call ptx/endis, PTXCONF_CAIRO_XLIB)-xlib \
	--$(call ptx/endis, PTXCONF_CAIRO_WIN32)-win32 \
	--$(call ptx/endis, PTXCONF_CAIRO_WIN32)-win32-font \
	--$(call ptx/endis, PTXCONF_CAIRO_SVG)-svg \
	--$(call ptx/endis, PTXCONF_CAIRO_PNG)-png \
	--$(call ptx/endis, PTXCONF_CAIRO_DIRECTFB)-directfb \
	--$(call ptx/endis, PTXCONF_CAIRO_FREETYPE)-ft \
	--$(call ptx/endis, PTXCONF_CAIRO_FREETYPE)-fc \
	--$(call ptx/endis, PTXCONF_CAIRO_PS)-ps \
	--$(call ptx/endis, PTXCONF_CAIRO_PDF)-pdf

ifndef PTXCONF_CAIRO_XLIB
CAIRO_AUTOCONF += --without-x
endif

ifdef PTXCONF_HAS_HARDFLOAT
CAIRO_AUTOCONF += --enable-some-floating-point
else
CAIRO_AUTOCONF += --disable-some-floating-point
endif

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
ifdef PTXCONF_CAIRO_GOBJECT
	@$(call install_lib, cairo, 0, 0, 0644, libcairo-gobject)
endif

	@$(call install_finish, cairo)

	@$(call touch)

# vim: syntax=make
