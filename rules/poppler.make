# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Luotao Fu <l.fu@pengutronix.de>
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
POPPLER_VERSION	:= 0.6.2
POPPLER		:= poppler-$(POPPLER_VERSION)
POPPLER_SUFFIX		:= tar.gz
POPPLER_URL		:= http://poppler.freedesktop.org/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_SOURCE		:= $(SRCDIR)/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_DIR		:= $(BUILDDIR)/$(POPPLER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

poppler_get: $(STATEDIR)/poppler.get

$(STATEDIR)/poppler.get: $(poppler_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(POPPLER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, POPPLER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

poppler_extract: $(STATEDIR)/poppler.extract

$(STATEDIR)/poppler.extract: $(poppler_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(POPPLER_DIR))
	@$(call extract, POPPLER)
	@$(call patchin, POPPLER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

poppler_prepare: $(STATEDIR)/poppler.prepare

POPPLER_PATH	:= PATH=$(CROSS_PATH)
POPPLER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
POPPLER_AUTOCONF := $(CROSS_AUTOCONF_USR)
POPPLER_AUTOCONF += --disable-abiword-output --disable-poppler-qt \
	--disable-poppler-qt4 --disable-gtk-test

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

$(STATEDIR)/poppler.prepare: $(poppler_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(POPPLER_DIR)/config.cache)
	cd $(POPPLER_DIR) && \
		$(POPPLER_PATH) $(POPPLER_ENV) \
		./configure $(POPPLER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

poppler_compile: $(STATEDIR)/poppler.compile

$(STATEDIR)/poppler.compile: $(poppler_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(POPPLER_DIR) && $(POPPLER_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

poppler_install: $(STATEDIR)/poppler.install

$(STATEDIR)/poppler.install: $(poppler_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, POPPLER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

poppler_targetinstall: $(STATEDIR)/poppler.targetinstall

$(STATEDIR)/poppler.targetinstall: $(poppler_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, poppler)
	@$(call install_fixup, poppler,PACKAGE,poppler)
	@$(call install_fixup, poppler,PRIORITY,optional)
	@$(call install_fixup, poppler,VERSION,$(POPPLER_VERSION))
	@$(call install_fixup, poppler,SECTION,base)
	@$(call install_fixup, poppler,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, poppler,DEPENDS,)
	@$(call install_fixup, poppler,DESCRIPTION,missing)

	@$(call install_copy, poppler, 0, 0, 0755,\
		$(POPPLER_DIR)/poppler/.libs/libpoppler.so.2.0.0, /usr/lib/libpoppler.so.2.0.0)	
	@$(call install_link, poppler, libpoppler.so.2.0.0, /usr/lib/libpoppler.so.2)
	@$(call install_link, poppler, libpoppler.so.2.0.0, /usr/lib/libpoppler.so)

ifdef PTXCONF_POPPLER_BIN
	for i in `find $(POPPLER_DIR)/utils/.libs -type f`; do \
		$(call install_copy, poppler, 0, 0, 0755, $$i, /usr/bin/$$(basename $$i)); \
	done
endif

ifdef PTXCONF_POPPLER_GLIB
	@$(call install_copy, poppler, 0, 0, 0755,\
		$(POPPLER_DIR)/glib/.libs/libpoppler-glib.so.2.0.0, /usr/lib/libpoppler-glib.so.2.0.0)	
	@$(call install_link, poppler, libpoppler-glib.so.2.0.0, /usr/lib/libpoppler-glib.so.2)
	@$(call install_link, poppler, libpoppler-glib.so.2.0.0, /usr/lib/libpoppler-glib.so)
endif

	@$(call install_finish, poppler)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

poppler_clean:
	rm -rf $(STATEDIR)/poppler.*
	rm -rf $(IMAGEDIR)/poppler_*
	rm -rf $(POPPLER_DIR)

# vim: syntax=make
