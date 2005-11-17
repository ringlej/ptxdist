# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
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
PACKAGES-$(PTXCONF_HRTIMERS_SUPPORT) += hrtimers-support

#
# Paths and names
#
HRTIMERS_SUPPORT_VERSION	= 3.1.1
HRTIMERS_SUPPORT		= hrtimers-support-$(HRTIMERS_SUPPORT_VERSION)
HRTIMERS_SUPPORT_SUFFIX		= tar.bz2
HRTIMERS_SUPPORT_URL		= $(PTXCONF_SETUP_SFMIRROR)/high-res-timers/$(HRTIMERS_SUPPORT).$(HRTIMERS_SUPPORT_SUFFIX)
HRTIMERS_SUPPORT_SOURCE		= $(SRCDIR)/$(HRTIMERS_SUPPORT).$(HRTIMERS_SUPPORT_SUFFIX)
HRTIMERS_SUPPORT_DIR		= $(BUILDDIR)/$(HRTIMERS_SUPPORT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hrtimers-support_get: $(STATEDIR)/hrtimers-support.get

hrtimers-support_get_deps = $(HRTIMERS_SUPPORT_SOURCE)

$(STATEDIR)/hrtimers-support.get: $(hrtimers-support_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(HRTIMERS_SUPPORT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HRTIMERS_SUPPORT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hrtimers-support_extract: $(STATEDIR)/hrtimers-support.extract

hrtimers-support_extract_deps = $(STATEDIR)/hrtimers-support.get

$(STATEDIR)/hrtimers-support.extract: $(hrtimers-support_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HRTIMERS_SUPPORT_DIR))
	@$(call extract, $(HRTIMERS_SUPPORT_SOURCE))
	@$(call patchin, $(HRTIMERS_SUPPORT))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hrtimers-support_prepare: $(STATEDIR)/hrtimers-support.prepare

#
# dependencies
#
hrtimers-support_prepare_deps = \
	$(STATEDIR)/hrtimers-support.extract \
	$(STATEDIR)/virtual-xchain.install

HRTIMERS_SUPPORT_PATH	=  PATH=$(CROSS_PATH)
HRTIMERS_SUPPORT_ENV 	=  $(CROSS_ENV)
HRTIMERS_SUPPORT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
HRTIMERS_SUPPORT_AUTOCONF =  $(CROSS_AUTOCONF)
HRTIMERS_SUPPORT_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/hrtimers-support.prepare: $(hrtimers-support_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HRTIMERS_SUPPORT_DIR)/config.cache)
	cd $(HRTIMERS_SUPPORT_DIR) && \
		$(HRTIMERS_SUPPORT_PATH) $(HRTIMERS_SUPPORT_ENV) \
		./configure $(HRTIMERS_SUPPORT_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hrtimers-support_compile: $(STATEDIR)/hrtimers-support.compile

hrtimers-support_compile_deps = $(STATEDIR)/hrtimers-support.prepare

$(STATEDIR)/hrtimers-support.compile: $(hrtimers-support_compile_deps)
	@$(call targetinfo, $@)
	cd $(HRTIMERS_SUPPORT_DIR) && $(HRTIMERS_SUPPORT_ENV) $(HRTIMERS_SUPPORT_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hrtimers-support_install: $(STATEDIR)/hrtimers-support.install

$(STATEDIR)/hrtimers-support.install: $(STATEDIR)/hrtimers-support.compile
	@$(call targetinfo, $@)
	cd $(HRTIMERS_SUPPORT_DIR) && $(HRTIMERS_SUPPORT_ENV) $(HRTIMERS_SUPPORT_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hrtimers-support_targetinstall: $(STATEDIR)/hrtimers-support.targetinstall

hrtimers-support_targetinstall_deps = $(STATEDIR)/hrtimers-support.compile

$(STATEDIR)/hrtimers-support.targetinstall: $(hrtimers-support_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,hrtimers-support)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(HRTIMERS_SUPPORT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(HRTIMERS_SUPPORT_DIR)/lib/.libs/libposix-time.so.1.0.0, 
		/usr/lib/libposix-time.so.1.0.0)

	@$(call install_link, \
		libposix-time.so.1.0.0, \
		/usr/lib/libposix-time.so.1)

	@$(call install_link, \
		libposix-time.so.1.0.0, \
		/usr/lib/libposix-time.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hrtimers-support_clean:
	rm -rf $(STATEDIR)/hrtimers-support.*
	rm -rf $(IMAGEDIR)/hrtimers-support_*
	rm -rf $(HRTIMERS_SUPPORT_DIR)

# vim: syntax=make
