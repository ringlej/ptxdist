# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
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

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#HOST_CAIRO_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_CAIRO_CONF_TOOL	:= autoconf
HOST_CAIRO_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--enable-atomic \
	--disable-gcov \
	--disable-valgrind \
	--disable-xlib \
	--disable-xlib-xrender \
	--disable-xcb \
	--disable-xlib-xcb \
	--disable-xcb-shm \
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
	--disable-png \
	--disable-gl \
	--disable-glesv2 \
	--disable-cogl \
	--disable-directfb \
	--disable-vg \
	--disable-egl \
	--disable-glx \
	--disable-wgl \
	--disable-script \
	--enable-ft \
	--enable-fc \
	--disable-ps \
	--disable-pdf \
	--disable-svg \
	--disable-test-surfaces \
	--disable-tee \
	--disable-xml \
	--enable-pthread \
	--disable-gobject \
	--disable-full-testing \
	--disable-trace \
	--disable-interpreter \
	--disable-symbol-lookup \
	--disable-some-floating-point \
	--without-x

# vim: syntax=make
