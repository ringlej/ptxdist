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
FLTK_VERSION	= 1.1.4
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
FLTK_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
FLTK_AUTOCONF	+= --build=$(GNU_HOST)
FLTK_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
FLTK_AUTOCONF	+= --x-includes=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11
FLTK_AUTOCONF	+= --x-libraries=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
FLTK_AUTOCONF	+= --enable-shared 
#FLTK_AUTOCONF	+= --enable-threads

$(STATEDIR)/fltk.prepare: $(fltk_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FLTK_BUILDDIR))
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
	install -d $(ROOTDIR)/lib
	cp -pd $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfltk*.so* $(ROOTDIR)/lib
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/lib/libfltk*
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fltk_clean:
	rm -rf $(STATEDIR)/fltk.*
	rm -rf $(FLTK_DIR)

# vim: syntax=make
