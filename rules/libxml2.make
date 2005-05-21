# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBXML2
PACKAGES += libxml2
endif

#
# Paths and names
#
LIBXML2_VERSION	= 2.6.2
LIBXML2		= libxml2-$(LIBXML2_VERSION)
LIBXML2_SUFFIX	= tar.bz2
LIBXML2_URL	= ftp://ftp.gnome.org/pub/GNOME/sources/libxml2/2.6//$(LIBXML2).$(LIBXML2_SUFFIX)
LIBXML2_SOURCE	= $(SRCDIR)/$(LIBXML2).$(LIBXML2_SUFFIX)
LIBXML2_DIR	= $(BUILDDIR)/$(LIBXML2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libxml2_get: $(STATEDIR)/libxml2.get

libxml2_get_deps = $(LIBXML2_SOURCE)

$(STATEDIR)/libxml2.get: $(libxml2_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(LIBXML2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBXML2_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libxml2_extract: $(STATEDIR)/libxml2.extract

libxml2_extract_deps = $(STATEDIR)/libxml2.get

$(STATEDIR)/libxml2.extract: $(libxml2_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXML2_DIR))
	@$(call extract, $(LIBXML2_SOURCE))
	@$(call patchin, $(LIBXML2))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libxml2_prepare: $(STATEDIR)/libxml2.prepare

#
# dependencies
#
libxml2_prepare_deps = \
	$(STATEDIR)/libxml2.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.install

LIBXML2_PATH	=  PATH=$(CROSS_PATH)
LIBXML2_ENV 	=  $(CROSS_ENV)
#LIBXML2_ENV	+=

#
# autoconf
#
LIBXML2_AUTOCONF =  $(CROSS_AUTOCONF)
LIBXML2_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
LIBXML2_AUTOCONF += --without-python
 
$(STATEDIR)/libxml2.prepare: $(libxml2_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXML2_DIR)/config.cache)
	cd $(LIBXML2_DIR) && \
		$(LIBXML2_PATH) $(LIBXML2_ENV) \
		./configure $(LIBXML2_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libxml2_compile: $(STATEDIR)/libxml2.compile

libxml2_compile_deps = $(STATEDIR)/libxml2.prepare

$(STATEDIR)/libxml2.compile: $(libxml2_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBXML2_DIR) && $(LIBXML2_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libxml2_install: $(STATEDIR)/libxml2.install

$(STATEDIR)/libxml2.install: $(STATEDIR)/libxml2.compile
	@$(call targetinfo, $@)
	cd $(LIBXML2_DIR) && $(LIBXML2_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libxml2_targetinstall: $(STATEDIR)/libxml2.targetinstall

libxml2_targetinstall_deps = $(STATEDIR)/libxml2.compile \
	$(STATEDIR)/zlib.targetinstall

$(STATEDIR)/libxml2.targetinstall: $(libxml2_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libxml2)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBXML2_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0644, \
		$(LIBXML2_DIR)/.libs/libxml2.so.2.6.2, \
		/usr/lib/libxml2.so.2.6.2)
	@$(call install_link, libxml2.so.2.6.2, /usr/lib/libxml2.so.2)
	@$(call install_link, libxml2.so.2.6.2, /usr/lib/libxml2.so)
	
	@$(call install_finish)
	
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libxml2_clean:
	rm -rf $(STATEDIR)/libxml2.*
	rm -rf $(IMAGEDIR)/libxml2_*
	rm -rf $(LIBXML2_DIR)

# vim: syntax=make
