# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
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
ifdef PTXCONF_LIBXMLCONFIG
PACKAGES += libxmlconfig
endif

#
# Paths and names
#
LIBXMLCONFIG_VERSION	= 1.0.1
LIBXMLCONFIG		= libxmlconfig-$(LIBXMLCONFIG_VERSION)
LIBXMLCONFIG_SUFFIX	= tar.bz2
LIBXMLCONFIG_URL	= http://www.pengutronix.de/software/libxmlconfig/download/$(LIBXMLCONFIG).$(LIBXMLCONFIG_SUFFIX)
LIBXMLCONFIG_SOURCE	= $(SRCDIR)/$(LIBXMLCONFIG).$(LIBXMLCONFIG_SUFFIX)
LIBXMLCONFIG_DIR	= $(BUILDDIR)/$(LIBXMLCONFIG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libxmlconfig_get: $(STATEDIR)/libxmlconfig.get

libxmlconfig_get_deps = $(LIBXMLCONFIG_SOURCE)

$(STATEDIR)/libxmlconfig.get: $(libxmlconfig_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LIBXMLCONFIG))
	touch $@

$(LIBXMLCONFIG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBXMLCONFIG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libxmlconfig_extract: $(STATEDIR)/libxmlconfig.extract

libxmlconfig_extract_deps = $(STATEDIR)/libxmlconfig.get

$(STATEDIR)/libxmlconfig.extract: $(libxmlconfig_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXMLCONFIG_DIR))
	@$(call extract, $(LIBXMLCONFIG_SOURCE))
	@$(call patchin, $(LIBXMLCONFIG))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libxmlconfig_prepare: $(STATEDIR)/libxmlconfig.prepare

#
# dependencies
#
libxmlconfig_prepare_deps =  $(STATEDIR)/libxmlconfig.extract
libxmlconfig_prepare_deps += $(STATEDIR)/virtual-xchain.install
libxmlconfig_prepare_deps += $(STATEDIR)/libxml2.install

LIBXMLCONFIG_PATH	=  PATH=$(CROSS_PATH)
LIBXMLCONFIG_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBXMLCONFIG_AUTOCONF =  $(CROSS_AUTOCONF)
LIBXMLCONFIG_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
LIBXMLCONFIG_AUTOCONF += --with-libxml2=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

$(STATEDIR)/libxmlconfig.prepare: $(libxmlconfig_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXMLCONFIG_DIR)/config.cache)
	cd $(LIBXMLCONFIG_DIR) && \
		$(LIBXMLCONFIG_PATH) $(LIBXMLCONFIG_ENV) \
		./configure $(LIBXMLCONFIG_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libxmlconfig_compile: $(STATEDIR)/libxmlconfig.compile

libxmlconfig_compile_deps = $(STATEDIR)/libxmlconfig.prepare

$(STATEDIR)/libxmlconfig.compile: $(libxmlconfig_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBXMLCONFIG_DIR) && $(LIBXMLCONFIG_ENV) $(LIBXMLCONFIG_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libxmlconfig_install: $(STATEDIR)/libxmlconfig.install

$(STATEDIR)/libxmlconfig.install: $(STATEDIR)/libxmlconfig.compile
	@$(call targetinfo, $@)
	cd $(LIBXMLCONFIG_DIR) && $(LIBXMLCONFIG_ENV) $(LIBXMLCONFIG_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libxmlconfig_targetinstall: $(STATEDIR)/libxmlconfig.targetinstall

libxmlconfig_targetinstall_deps = $(STATEDIR)/libxmlconfig.compile

$(STATEDIR)/libxmlconfig.targetinstall: $(libxmlconfig_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libxmlconfig)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBXMLCONFIG_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(LIBXMLCONFIG_DIR)/.libs/libxmlconfig.so.0.0.0, /usr/lib/libxmlconfig.so.0.0.0)
	@$(call install_link, libxmlconfig.so.0.0.0, /usr/lib/libxmlconfig.so.0)
	@$(call install_link, libxmlconfig.so.0.0.0, /usr/lib/libxmlconfig.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libxmlconfig_clean:
	rm -rf $(STATEDIR)/libxmlconfig.*
	rm -rf $(IMAGEDIR)/libxmlconfig_*
	rm -rf $(LIBXMLCONFIG_DIR)

# vim: syntax=make
