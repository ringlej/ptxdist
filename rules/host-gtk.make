# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel <r.schwebel@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_GTK) += host-gtk

#
# Paths and names
#
HOST_GTK_DIR	= $(HOST_BUILDDIR)/$(GTK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gtk.get: $(STATEDIR)/gtk.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GTK_PATH	:= PATH=$(HOST_PATH)
HOST_GTK_ENV 	:= \
	$(HOST_ENV) \
	ac_cv_path_CUPS_CONFIG=no

#
# autoconf
#

ifdef PTXCONF_HOST_GTK_LOADER_PNG
HOST_GTK_LOADERS += png
endif

ifdef PTXCONF_HOST_GTK_LOADER_BMP
HOST_GTK_LOADERS += bmp
endif

ifdef PTXCONF_HOST_GTK_LOADER_WBMP
HOST_GTK_LOADERS += wbmp
endif

ifdef PTXCONF_HOST_GTK_LOADER_GIF
HOST_GTK_LOADERS += gif
endif

ifdef PTXCONF_HOST_GTK_LOADER_ICO
HOST_GTK_LOADERS += ico
endif

ifdef PTXCONF_HOST_GTK_LOADER_ANI
HOST_GTK_LOADERS += ani
endif

ifdef PTXCONF_HOST_GTK_LOADER_JPEG
HOST_GTK_LOADERS += jpeg
endif

ifdef PTXCONF_HOST_GTK_LOADER_PNM
HOST_GTK_LOADERS += pnm
endif

ifdef PTXCONF_HOST_GTK_LOADER_RAS
HOST_GTK_LOADERS += ras
endif

ifdef PTXCONF_HOST_GTK_LOADER_TIFF
HOST_GTK_LOADERS += tiff
endif

ifdef PTXCONF_HOST_GTK_LOADER_XPM
HOST_GTK_LOADERS += xpm
endif

ifdef PTXCONF_HOST_GTK_LOADER_TGA
HOST_GTK_LOADERS += tga
endif

ifdef PTXCONF_HOST_GTK_LOADER_PCX
HOST_GTK_LOADERS += pcx
endif

HOST_GTK_AUTOCONF := \
	$(HOST_AUTOCONF)
	--enable-explicit-deps=yes \
	--disable-glibtest \
	--disable-modules \
	--with-included-loaders=$(subst $(space),$(comma),$(GTK_LOADERS))

ifndef PTXCONF_HOST_GTK_LOADER_PNG
HOST_GTK_AUTOCONF += --without-libpng
endif

ifndef PTXCONF_HOST_GTK_LOADER_TIFF
HOST_GTK_AUTOCONF += --without-libtiff
endif

ifndef PTXCONF_HOST_GTK_LOADER_JPEG
HOST_GTK_AUTOCONF += --without-libjpeg
endif

ifndef PTXCONF_GTK_LOADER_JPEG2000
HOST_GTK_AUTOCONF += --without-libjasper
endif

ifdef PTXCONF_HOST_GTK_TARGET_X11
HOST_GTK_AUTOCONF += --with-gdktarget=x11
endif

ifdef PTXCONF_HOST_GTK_TARGET_DIRECTFB
HOST_GTK_AUTOCONF += --with-gdktarget=directfb
endif

ifdef PTXCONF_HOST_GTK_TARGET_WIN32
HOST_GTK_AUTOCONF += --with-gdktarget=win32
endif


# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gtk_clean:
	rm -rf $(STATEDIR)/host-gtk.*
	rm -rf $(HOST_GTK_DIR)

# vim: syntax=make
