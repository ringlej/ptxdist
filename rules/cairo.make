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
CAIRO_VERSION	:= 1.14.12
CAIRO_MD5	:= 9f0db9dbfca0966be8acd682e636d165
CAIRO		:= cairo-$(CAIRO_VERSION)
CAIRO_SUFFIX	:= tar.xz
CAIRO_URL	:= http://cairographics.org/releases/cairo-$(CAIRO_VERSION).$(CAIRO_SUFFIX)
CAIRO_SOURCE	:= $(SRCDIR)/$(CAIRO).$(CAIRO_SUFFIX)
CAIRO_DIR	:= $(BUILDDIR)/$(CAIRO)
CAIRO_LICENSE	:= LGPL-2.1-only AND MPL-1.1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CAIRO_CONF_TOOL	:= autoconf
CAIRO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-atomic \
	--disable-gcov \
	--disable-valgrind \
	--$(call ptx/endis, PTXCONF_CAIRO_XLIB)-xlib \
	--$(call ptx/endis, PTXCONF_CAIRO_XLIB)-xlib-xrender \
	--$(call ptx/endis, PTXCONF_CAIRO_XCB)-xcb \
	--disable-xlib-xcb \
	--$(call ptx/endis, PTXCONF_CAIRO_XCB)-xcb-shm \
	--disable-qt \
	--disable-quartz \
	--disable-quartz-font \
	--disable-quartz-image \
	--disable-win32 \
	--disable-win32-font \
	--disable-skia \
	--disable-os2 \
	--disable-beos \
	--disable-drm \
	--disable-gallium \
	--$(call ptx/endis, PTXCONF_CAIRO_PNG)-png \
	--$(call ptx/endis, PTXCONF_CAIRO_GL)-gl \
	--$(call ptx/endis, PTXCONF_CAIRO_GLES2)-glesv2 \
	--disable-cogl \
	--$(call ptx/endis, PTXCONF_CAIRO_DIRECTFB)-directfb \
	--disable-vg \
	--$(call ptx/endis, PTXCONF_CAIRO_EGL)-egl \
	--$(call ptx/endis, PTXCONF_CAIRO_GLX)-glx \
	--disable-wgl \
	--disable-script \
	--$(call ptx/endis, PTXCONF_CAIRO_FREETYPE)-ft \
	--$(call ptx/endis, PTXCONF_CAIRO_FREETYPE)-fc \
	--$(call ptx/endis, PTXCONF_CAIRO_PS)-ps \
	--$(call ptx/endis, PTXCONF_CAIRO_PDF)-pdf \
	--$(call ptx/endis, PTXCONF_CAIRO_SVG)-svg \
	--disable-test-surfaces \
	--disable-tee \
	--disable-xml \
	--enable-pthread \
	--$(call ptx/endis, PTXCONF_CAIRO_GOBJECT)-gobject \
	--disable-full-testing \
	--disable-trace \
	--disable-interpreter \
	--disable-symbol-lookup \
	--$(call ptx/endis, PTXCONF_HAS_HARDFLOAT)-some-floating-point \
	--$(call ptx/wwo, PTXCONF_CAIRO_XLIB)-x

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
