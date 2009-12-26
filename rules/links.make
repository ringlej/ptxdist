# -*-makefile-*-
#
# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_LINKS) += links

#
# Paths and names
#
LINKS_NAME	:= links
LINKS_VERSION	:= 2.2
LINKS		:= $(LINKS_NAME)-$(LINKS_VERSION)
LINKS_SUFFIX	:= tar.bz2
LINKS_URL	:= http://links.twibright.com/download/$(LINKS).$(LINKS_SUFFIX)
LINKS_SOURCE	:= $(SRCDIR)/$(LINKS).$(LINKS_SUFFIX)
LINKS_DIR	:= $(BUILDDIR)/$(LINKS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LINKS_SOURCE):
	@$(call targetinfo)
	@$(call get, LINKS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LINKS_PATH     := PATH=$(CROSS_PATH)
LINKS_ENV      := $(CROSS_ENV)

#
# autoconf
#
LINKS_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifneq ($(PTXCONF_LINKS_X)$(PTXCONF_LINKS_FBCON)$(PTXCONF_LINKS_DIRECTFB),)
LINKS_AUTOCONF += --enable-graphics
else
LINKS_AUTOCONF += --disable-graphics
endif

ifdef PTXCONF_LINKS_SSL
LINKS_AUTOCONF += --with-ssl
else
LINKS_AUTOCONF += --without-ssl
endif

ifdef PTXCONF_LINKS_GPM
LINKS_AUTOCONF += --with-gpm
else
LINKS_AUTOCONF += --without-gpm
# Note: ./configure only support 'gpm' features auto-detection, so
# we use the autoconf trick (see Gentoo ebuild)
LINKS_ENV += ac_cv_lib_gpm_Gpm_Open=no
endif

ifdef PTXCONF_LINKS_PNG
LINKS_AUTOCONF += --with-libpng
else
LINKS_AUTOCONF += --without-libpng
endif

ifdef PTXCONF_LINKS_JPEG
LINKS_AUTOCONF += --with-libjpeg
else
LINKS_AUTOCONF += --without-libjpeg
endif

ifdef PTXCONF_LINKS_FBCON
LINKS_AUTOCONF += --with-fb
else
LINKS_AUTOCONF += --without-fb
endif

ifdef PTXCONF_LINKS_TIFF
LINKS_AUTOCONF += --with-libtiff
else
LINKS_AUTOCONF += --without-libtiff
endif

ifdef PTXCONF_LINKS_X
LINKS_AUTOCONF += --with-x
else
LINKS_AUTOCONF += --without-x
endif

ifdef PTXCONF_LINKS_DIRECTFB
LINKS_AUTOCONF += --with-directfb
else
LINKS_AUTOCONF += --without-directfb
endif

ifdef PTXCONF_LINKS_SDL
LINKS_AUTOCONF += --with-sdl
else
LINKS_AUTOCONF += --without-sdl
endif

ifdef PTXCONF_LINKS_ZLIB
LINKS_AUTOCONF += --with-zlib
else
LINKS_AUTOCONF += --without-zlib
endif

ifdef PTXCONF_LINKS_BZIP2
LINKS_AUTOCONF += --with-bzip2
else
LINKS_AUTOCONF += --without-bzip2
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/links.targetinstall:
	@$(call targetinfo)

	@$(call install_init, links)
	@$(call install_fixup, links,PACKAGE,links)
	@$(call install_fixup, links,PRIORITY,optional)
	@$(call install_fixup, links,VERSION,$(LINKS_VERSION))
	@$(call install_fixup, links,SECTION,base)
	@$(call install_fixup, links,AUTHOR,"Markus Rathgeb <rathgeb.markus@googlemail.com>")
	@$(call install_fixup, links,DEPENDS,)
	@$(call install_fixup, links,DESCRIPTION,missing)

	@$(call install_copy, links, 0, 0, 0755, -, /usr/bin/links)

	@$(call install_finish, links)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

links_clean:
	rm -rf $(STATEDIR)/links.*
	rm -rf $(PKGDIR)/links_*
	rm -rf $(LINKS_DIR)

# vim: syntax=make
