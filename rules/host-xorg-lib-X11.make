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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_X11) += host-xorg-lib-x11

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_LIB_X11_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--disable-man-pages \
	--disable-specs \
	--enable-xkb \
	--disable-secure-rpc \
	--disable-xf86bigfont \
	--disable-loadable-i18n \
	--disable-loadable-xcursor

# vim: syntax=make
