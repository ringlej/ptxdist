# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_EGGDBUS) += host-eggdbus

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_EGGDBUS_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-man-pages \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf

# vim: syntax=make
