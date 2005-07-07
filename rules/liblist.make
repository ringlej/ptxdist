# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBLIST
PACKAGES += liblist
endif

#
# Paths and names
#
LIBLIST_VERSION		= 1.0.0
LIBLIST			= liblist-$(LIBLIST_VERSION)
LIBLIST_SUFFIX		= tar.gz
LIBLIST_URL		= http://www.pengutronix.de/software/liblist/download/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_SOURCE		= $(SRCDIR)/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_DIR		= $(BUILDDIR)/$(LIBLIST)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

liblist_get: $(STATEDIR)/liblist.get

liblist_get_deps = $(LIBLIST_SOURCE)

$(STATEDIR)/liblist.get: $(liblist_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LIBLIST))
	touch $@

$(LIBLIST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBLIST_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

liblist_extract: $(STATEDIR)/liblist.extract

liblist_extract_deps = $(STATEDIR)/liblist.get

$(STATEDIR)/liblist.extract: $(liblist_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBLIST_DIR))
	@$(call extract, $(LIBLIST_SOURCE))
	@$(call patchin, $(LIBLIST))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

liblist_prepare: $(STATEDIR)/liblist.prepare

#
# dependencies
#
liblist_prepare_deps = \
	$(STATEDIR)/liblist.extract \
	$(STATEDIR)/virtual-xchain.install

LIBLIST_PATH	=  PATH=$(CROSS_PATH)
LIBLIST_ENV 	=  $(CROSS_ENV)
#LIBLIST_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#LIBLIST_ENV	+=

#
# autoconf
#
LIBLIST_AUTOCONF =  $(CROSS_AUTOCONF)
LIBLIST_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/liblist.prepare: $(liblist_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBLIST_DIR)/config.cache)
	cd $(LIBLIST_DIR) && \
		$(LIBLIST_PATH) $(LIBLIST_ENV) \
		./configure $(LIBLIST_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

liblist_compile: $(STATEDIR)/liblist.compile

liblist_compile_deps = $(STATEDIR)/liblist.prepare

$(STATEDIR)/liblist.compile: $(liblist_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBLIST_DIR) && $(LIBLIST_ENV) $(LIBLIST_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

liblist_install: $(STATEDIR)/liblist.install

$(STATEDIR)/liblist.install: $(STATEDIR)/liblist.compile
	@$(call targetinfo, $@)
	cd $(LIBLIST_DIR) && $(LIBLIST_ENV) $(LIBLIST_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

liblist_targetinstall: $(STATEDIR)/liblist.targetinstall

liblist_targetinstall_deps = $(STATEDIR)/liblist.compile

$(STATEDIR)/liblist.targetinstall: $(liblist_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,liblist)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBLIST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(LIBLIST_DIR)/.libs/libptxlist.so.0.0.0, /usr/lib/libptxlist.so.0.0.0)
	@$(call install_link, libptxlist.so.1.0.0, /usr/lib/libptxlist.so.0)
	@$(call install_link, libptxlist.so.1.0.0, /usr/lib/libptxlist.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liblist_clean:
	rm -rf $(STATEDIR)/liblist.*
	rm -rf $(IMAGEDIR)/liblist_*
	rm -rf $(LIBLIST_DIR)

# vim: syntax=make
