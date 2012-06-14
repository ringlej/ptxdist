# -*-makefile-*-
#
# Copyright (C) 2003 by Werner Schmitt mail2ws@gmx.de
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
PACKAGES-$(PTXCONF_FLTK) += fltk

#
# Paths and names
#
FLTK_VERSION	:= 1.1.6
FLTK_MD5	:=
FLTK		:= fltk-$(FLTK_VERSION)
FLTK_SUFFIX	:= source.tar.bz2
FLTK_URL	:= \
	http://ftp.funet.fi/pub/mirrors/ftp.easysw.com/pub/fltk/$(FLTK_VERSION)/$(FLTK)-$(FLTK_SUFFIX) \
	http://ftp.rz.tu-bs.de/pub/mirror/ftp.easysw.com/ftp/pub/fltk/$(FLTK_VERSION)/$(FLTK)-$(FLTK_SUFFIX) \
	ftp://ftp.easysw.com/pub/fltk/$(FLTK_VERSION)/$(FLTK)-$(FLTK_SUFFIX)
FLTK_SOURCE	:= $(SRCDIR)/$(FLTK)-$(FLTK_SUFFIX)
FLTK_DIR	:= $(BUILDDIR)/$(FLTK)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FLTK_PATH	:= PATH=$(CROSS_PATH)
FLTK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FLTK_AUTOCONF	=  $(CROSS_AUTOCONF_USR) \
	--x-includes=$(SYSROOT)/include \
	--x-libraries=$(SYSROOT)/lib \
	--enable-shared \
	--enable-localjpeg \
	--enable-localzlib \
	--enable-localpng

ifdef PTXCONF_FLTK_THREADS
FLTK_AUTOCONF  += --enable-threads
endif

ifdef PTXCONF_FLTK_OPENGL
FLTK_AUTOCONF  += --enable-gl
else
FLTK_AUTOCONF  += --disable-gl
endif

ifdef PTXCONF_FLTK_XFT
FLTK_AUTOCONF  += --enable-xft
endif

ifdef PTXCONF_FLTK_XDBE
FLTK_AUTOCONF  += --enable-xdbe
endif

$(STATEDIR)/fltk.prepare:
	@$(call targetinfo)
	@$(call clean, $(FLTK_BUILDDIR))
ifndef PTXCONF_FLTK_FLUID
	sed -i -e 's/src fluid test documentation/src/g' $(FLTK_DIR)/Makefile
endif
	cd $(FLTK_DIR) && \
		$(FLTK_PATH) $(FLTK_ENV) \
		./configure $(FLTK_AUTOCONF)
	@$(call touch)

# FIXME: if fltk breaks, it is not handled to the toplevel make, so
# it breaks silently. Remove the xorg-lib-X11 dependency from the in
# file in order to trigger this. Needs a proper patch.

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fltk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fltk)
	@$(call install_fixup, fltk,PRIORITY,optional)
	@$(call install_fixup, fltk,SECTION,base)
	@$(call install_fixup, fltk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fltk,DESCRIPTION,missing)

	@$(call install_lib, fltk, 0, 0, 0644, libfltk)
	@$(call install_lib, fltk, 0, 0, 0644, libfltk_forms)

#	FIXME: only static?
#	@$(call install_lib, fltk, 0, 0, 0644, libfltk_images)

	@$(call install_finish, fltk)

	@$(call touch)

# vim: syntax=make
