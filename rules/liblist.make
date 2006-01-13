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
PACKAGES-$(PTXCONF_LIBLIST) += liblist

#
# Paths and names
#
LIBLIST_VERSION		= 1.0.3
LIBLIST			= liblist-$(LIBLIST_VERSION)
LIBLIST_SUFFIX		= tar.gz
LIBLIST_URL		= http://www.pengutronix.de/software/liblist/download/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_SOURCE		= $(SRCDIR)/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_DIR		= $(BUILDDIR)/$(LIBLIST)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

liblist_get: $(STATEDIR)/liblist.get

$(STATEDIR)/liblist.get: $(liblist_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LIBLIST))
	@$(call touch, $@)

$(LIBLIST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBLIST_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

liblist_extract: $(STATEDIR)/liblist.extract

$(STATEDIR)/liblist.extract: $(liblist_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBLIST_DIR))
	@$(call extract, $(LIBLIST_SOURCE))
	@$(call patchin, $(LIBLIST))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

liblist_prepare: $(STATEDIR)/liblist.prepare

LIBLIST_PATH	=  PATH=$(CROSS_PATH)
LIBLIST_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBLIST_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/liblist.prepare: $(liblist_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBLIST_DIR)/config.cache)
	cd $(LIBLIST_DIR) && \
		$(LIBLIST_PATH) $(LIBLIST_ENV) \
		./configure $(LIBLIST_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

liblist_compile: $(STATEDIR)/liblist.compile

$(STATEDIR)/liblist.compile: $(liblist_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBLIST_DIR) && $(LIBLIST_ENV) $(LIBLIST_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

liblist_install: $(STATEDIR)/liblist.install

$(STATEDIR)/liblist.install: $(liblist_install_deps_default)
	@$(call targetinfo, $@)
	$(call install, LIBLIST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

liblist_targetinstall: $(STATEDIR)/liblist.targetinstall

$(STATEDIR)/liblist.targetinstall: $(liblist_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,liblist)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBLIST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(LIBLIST_DIR)/src/.libs/libptxlist.so.0.0.0, /usr/lib/libptxlist.so.0.0.0)
	@$(call install_link, libptxlist.so.0.0.0, /usr/lib/libptxlist.so.0)
	@$(call install_link, libptxlist.so.0.0.0, /usr/lib/libptxlist.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liblist_clean:
	rm -rf $(STATEDIR)/liblist.*
	rm -rf $(IMAGEDIR)/liblist_*
	rm -rf $(LIBLIST_DIR)

# vim: syntax=make
