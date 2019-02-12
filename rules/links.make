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
LINKS_VERSION	:= 2.7
LINKS_MD5	:= d06aa6e14b2172d73188871a5357185a
LINKS		:= $(LINKS_NAME)-$(LINKS_VERSION)
LINKS_SUFFIX	:= tar.bz2
LINKS_URL	:= http://links.twibright.com/download/$(LINKS).$(LINKS_SUFFIX)
LINKS_SOURCE	:= $(SRCDIR)/$(LINKS).$(LINKS_SUFFIX)
LINKS_DIR	:= $(BUILDDIR)/$(LINKS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LINKS_PATH     := PATH=$(CROSS_PATH)
LINKS_ENV      := $(CROSS_ENV)

#
# autoconf
#
LINKS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/wwo, PTXCONF_LINKS_SSL)-ssl \
	--$(call ptx/wwo, PTXCONF_LINKS_GPM)-gpm \
	--$(call ptx/wwo, PTXCONF_LINKS_PNG)-png \
	--$(call ptx/wwo, PTXCONF_LINKS_JPEG)-libjpeg \
	--$(call ptx/wwo, PTXCONF_LINKS_FBCON)-fb \
	--$(call ptx/wwo, PTXCONF_LINKS_TIFF)-libtiff \
	--$(call ptx/wwo, PTXCONF_LINKS_X)-x \
	--without-directfb \
	--$(call ptx/wwo, PTXCONF_LINKS_SDL)-sdl \
	--$(call ptx/wwo, PTXCONF_LINKS_ZLIB)-zlib \
	--$(call ptx/wwo, PTXCONF_LINKS_BZIP2)-bzip2 \
	--$(call ptx/wwo, PTXCONF_LINKS_LZMA)-lzma \

ifneq ($(PTXCONF_LINKS_X)$(PTXCONF_LINKS_FBCON),)
LINKS_AUTOCONF += --enable-graphics
else
LINKS_AUTOCONF += --disable-graphics
endif

# Note: ./configure only support 'gpm' features auto-detection, so
# we use the autoconf trick (see Gentoo ebuild)
ifndef PTXCONF_LINKS_GPM
LINKS_ENV += ac_cv_lib_gpm_Gpm_Open=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/links.targetinstall:
	@$(call targetinfo)

	@$(call install_init, links)
	@$(call install_fixup, links,PRIORITY,optional)
	@$(call install_fixup, links,SECTION,base)
	@$(call install_fixup, links,AUTHOR,"Markus Rathgeb <rathgeb.markus@googlemail.com>")
	@$(call install_fixup, links,DESCRIPTION,missing)

	@$(call install_copy, links, 0, 0, 0755, -, /usr/bin/links)

	@$(call install_finish, links)

	@$(call touch)

# vim: syntax=make
