# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Werner Schmitt mail2ws@gmx.de
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_FLTK
PACKAGES += fltk
endif

#
# Paths and names
#
FLTK_VERSION	= 1.1.6
FLTK		= fltk-$(FLTK_VERSION)
FLTK_SUFFIX	= source.tar.gz
FLTK_URL	= ftp://ftp.easysw.com/pub/fltk/$(FLTK_VERSION)/$(FLTK)-$(FLTK_SUFFIX)
FLTK_SOURCE	= $(SRCDIR)/$(FLTK)-$(FLTK_SUFFIX)
FLTK_DIR	= $(BUILDDIR)/$(FLTK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fltk_get: $(STATEDIR)/fltk.get

fltk_get_deps	=  $(FLTK_SOURCE)

$(STATEDIR)/fltk.get: $(fltk_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(FLTK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FLTK_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fltk_extract: $(STATEDIR)/fltk.extract

fltk_extract_deps	=  $(STATEDIR)/fltk.get

$(STATEDIR)/fltk.extract: $(fltk_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FLTK_DIR))
	@$(call extract, $(FLTK_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fltk_prepare: $(STATEDIR)/fltk.prepare

#
# dependencies
#
fltk_prepare_deps =  \
	$(STATEDIR)/fltk.extract \
	$(STATEDIR)/xfree430.install \
	$(STATEDIR)/virtual-xchain.install

FLTK_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
FLTK_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
FLTK_AUTOCONF	=  $(CROSS_AUTOCONF)
FLTK_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
FLTK_AUTOCONF	+= --x-includes=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
FLTK_AUTOCONF	+= --x-libraries=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
FLTK_AUTOCONF	+= --enable-shared 

ifdef PTXCONF_FLTK_THREADS
FLTK_AUTOCONF  += --enable-threads
endif

ifdef PTXCONF_FLTK_OPENGL
FLTK_AUTOCONF  += --enable-gl
else
FLTK_AUTOCONF  += --disable-gl
endif

FLTK_AUTOCONF  += --enable-localjpeg
FLTK_AUTOCONF  += --enable-localzlib
FLTK_AUTOCONF  += --enable-localpng

ifdef PTXCONF_FLTK_XFT
FLTK_AUTOCONF  += --enable-xft
endif

ifdef PTXCONF_FLTK_XDBE
FLTK_AUTOCONF  += --enable-xdbe
endif

$(STATEDIR)/fltk.prepare: $(fltk_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FLTK_BUILDDIR))
ifndef PTXCONF_FLTK_FLUID
	perl -p -i -e 's/src fluid test documentation/src/'  $(FLTK_DIR)/Makefile
endif
	cd $(FLTK_DIR) && \
		$(FLTK_PATH) $(FLTK_ENV) \
		./configure $(FLTK_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fltk_compile: $(STATEDIR)/fltk.compile

fltk_compile_deps =  $(STATEDIR)/fltk.prepare

$(STATEDIR)/fltk.compile: $(fltk_compile_deps)
	@$(call targetinfo, $@)
	$(FLTK_PATH) $(FLTK_ENV) make -C $(FLTK_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fltk_install: $(STATEDIR)/fltk.install

$(STATEDIR)/fltk.install: $(STATEDIR)/fltk.compile
	@$(call targetinfo, $@)
	$(FLTK_PATH) $(FLTK_ENV) make -C $(FLTK_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fltk_targetinstall: $(STATEDIR)/fltk.targetinstall


fltk_targetinstall_deps	=  $(STATEDIR)/fltk.compile \
	$(STATEDIR)/fltk.install \
	$(STATEDIR)/xfree430.targetinstall

$(STATEDIR)/fltk.targetinstall: $(fltk_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,fltk)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(FLTK_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfltk.so.1.1, \
		/usr/lib/libfltk.so.1.1)
	@$(call install_copy, 0, 0, 0644, \
		$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfltk_forms.so.1.1, \
		/usr/lib/libfltk_forms.so.1.1)
	@$(call install_copy, 0, 0, 0644, \
		$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfltk_images.so.1.1, \
		/usr/lib/libfltk_images.so.1.1)
	@$(call install_link, libfltk.so.1.1, /usr/lib/libfltk.so)
	@$(call install_link, libfltk_forms.so.1.1, /usr/lib/libfltk_forms.so)
	@$(call install_link, libfltk_images.so.1.1, /usr/lib/libfltk_images.so)
	
	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fltk_clean:
	rm -rf $(STATEDIR)/fltk.*
	rm -rf $(BUILDDIR)/fltk_*
	rm -rf $(FLTK_DIR)

# vim: syntax=make
