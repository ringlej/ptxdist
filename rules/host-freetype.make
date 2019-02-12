# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_FREETYPE) += host-freetype

#
# Paths and names
#
HOST_FREETYPE_DIR	= $(HOST_BUILDDIR)/$(FREETYPE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_FREETYPE_CONF_TOOL	:= autoconf
HOST_FREETYPE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--disable-biarch-config \
	--enable-freetype-config \
	--enable-mmap \
	--without-zlib \
	--without-bzip2 \
	--without-png \
	--without-harfbuzz \
	--without-old-mac-fonts \
	--without-fsspec \
	--without-fsref \
	--without-quickdraw-toolbox \
	--without-quickdraw-carbon \
	--without-ats

# vim: syntax=make
