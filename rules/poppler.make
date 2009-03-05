# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2007 by Luotao Fu <l.fu@pengutronix.de>
#               2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POPPLER) += poppler

#
# Paths and names
#
POPPLER_VERSION	:= 0.10.4
POPPLER		:= poppler-$(POPPLER_VERSION)
POPPLER_SUFFIX	:= tar.gz
POPPLER_URL	:= http://poppler.freedesktop.org/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_SOURCE	:= $(SRCDIR)/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_DIR	:= $(BUILDDIR)/$(POPPLER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(POPPLER_SOURCE):
	@$(call targetinfo)
	@$(call get, POPPLER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POPPLER_PATH	:= PATH=$(CROSS_PATH)
POPPLER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
POPPLER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-abiword-output \
	--disable-poppler-qt \
	--disable-poppler-qt4 \
	--disable-gtk-test

ifdef PTXCONF_POPPLER_X
POPPLER_AUTOCONF += --with-x
else
POPPLER_AUTOCONF += --without-x
endif

ifdef PTXCONF_POPPLER_BIN
POPPLER_AUTOCONF += --enable-utils
else
POPPLER_AUTOCONF += --disable-utils
endif

ifdef PTXCONF_POPPLER_ZLIB
POPPLER_AUTOCONF += --enable-zlib
else
POPPLER_AUTOCONF += --disable-zlib
endif

ifdef PTXCONF_POPPLER_JPEG
POPPLER_AUTOCONF += --enable-libjpeg
else
POPPLER_AUTOCONF += --disable-libjpeg
endif

ifdef PTXCONF_POPPLER_CAIRO
POPPLER_AUTOCONF += --enable-cairo-output
else
POPPLER_AUTOCONF += --disable-cairo-output
endif

ifdef PTXCONF_POPPLER_GLIB
POPPLER_AUTOCONF += --enable-poppler-glib
else
POPPLER_AUTOCONF += --disable-poppler-glib
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/poppler.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  poppler)
	@$(call install_fixup, poppler, PACKAGE, poppler)
	@$(call install_fixup, poppler, PRIORITY, optional)
	@$(call install_fixup, poppler, VERSION, $(POPPLER_VERSION))
	@$(call install_fixup, poppler, SECTION, base)
	@$(call install_fixup, poppler, AUTHOR, "r.schwebel@pengutronix.de")
	@$(call install_fixup, poppler, DEPENDS,)
	@$(call install_fixup, poppler, DESCRIPTION, missing)

	@$(call install_copy, poppler, 0, 0, 0644, -, /usr/lib/libpoppler.so.4.0.0)
	@$(call install_link, poppler, libpoppler.so.4.0.0, /usr/lib/libpoppler.so.4)
	@$(call install_link, poppler, libpoppler.so.4.0.0, /usr/lib/libpoppler.so)

ifdef PTXCONF_POPPLER_BIN
	for i in `find $(POPPLER_DIR)/utils/.libs -type f`; do \
		$(call install_copy, poppler, 0, 0, 0755, $$i, /usr/bin/$$(basename $$i)); \
	done
endif

ifdef PTXCONF_POPPLER_GLIB
	@$(call install_copy, poppler, 0, 0, 0644, -, /usr/lib/libpoppler-glib.so.4.0.0)
	@$(call install_link, poppler, libpoppler-glib.so.4.0.0, /usr/lib/libpoppler-glib.so.4)
	@$(call install_link, poppler, libpoppler-glib.so.4.0.0, /usr/lib/libpoppler-glib.so)
endif

	@$(call install_finish, poppler)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

poppler_clean:
	rm -rf $(STATEDIR)/poppler.*
	rm -rf $(PKGDIR)/poppler_*
	rm -rf $(POPPLER_DIR)

# vim: syntax=make
