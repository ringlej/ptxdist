# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGO12) += pango

#
# Paths and names
#
PANGO12_VERSION		= 1.3.2
PANGO12			= pango-$(PANGO12_VERSION)
PANGO12_SUFFIX		= tar.gz
PANGO12_URL		= ftp://ftp.gnome.org/pub/GNOME/sources/pango/1.3/$(PANGO12).$(PANGO12_SUFFIX)
PANGO12_SOURCE		= $(SRCDIR)/$(PANGO12).$(PANGO12_SUFFIX)
PANGO12_DIR		= $(BUILDDIR)/$(PANGO12)
PANGO_MODULE_VERSION	= 1.4

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pango12_get: $(STATEDIR)/pango12.get

$(STATEDIR)/pango12.get: $(PANGO12_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PANGO12_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PANGO12_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pango12_extract: $(STATEDIR)/pango12.extract

$(STATEDIR)/pango12.extract: $(pango12_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO12_DIR))
	@$(call extract, $(PANGO12_SOURCE))
	@$(call patchin, $(PANGO12))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pango12_prepare: $(STATEDIR)/pango12.prepare

PANGO12_PATH	=  PATH=$(CROSS_PATH)
PANGO12_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
PANGO12_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
PANGO12_AUTOCONF	+= --with-x=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/usr/X11R6
PANGO12_AUTOCONF	+= --enable-explicit-deps

$(STATEDIR)/pango12.prepare: $(pango12_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO12_BUILDDIR))
	cd $(PANGO12_DIR) && \
		$(PANGO12_PATH) $(PANGO12_ENV) \
		./configure $(PANGO12_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pango12_compile: $(STATEDIR)/pango12.compile

$(STATEDIR)/pango12.compile: $(pango12_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PANGO12_DIR) && $(PANGO12_PATH) $(PANGO12_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pango12_install: $(STATEDIR)/pango12.install

$(STATEDIR)/pango12.install: $(STATEDIR)/pango12.compile
	@$(call targetinfo, $@)
	@$(call install, PANGO12)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pango12_targetinstall: $(STATEDIR)/pango12.targetinstall

$(STATEDIR)/pango12.targetinstall: $(pango12_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,pango12)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PANGO12_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	rm -f $(ROOTDIR)/lib/libpango-1.0.so*

	@$(call install_copy, 0, 0, 0644, \
		$(PANGO12_DIR)/pango/.libs/libpango-1.0.so.0.300.2, \
		/usr/lib/libpango-1.0.so.0.300.2)
	@$(call install_link, libpango-1.0.so.0.300.2, /usr/lib/libpango-1.0.so.0)
	@$(call install_link, libpango-1.0.so.0.300.2, /usr/lib/libpango-1.0.so)

	@$(call install_copy, 0, 0, 0644, \
		$(PANGO12_DIR)/pango/.libs/libpangox-1.0.so.0.300.2, \
		/usr/lib/libpangox-1.0.so.0.300.2)
	@$(call install_link, libpangox-1.0.so.0.300.2, /lib/libpangox-1.0.so.0)
	@$(call install_link, libpangox-1.0.so.0.300.2, /lib/libpangox-1.0.so)

	@$(call install_copy, 0, 0, 0644, \
		$(PANGO12_DIR)/pango/.libs/libpangoxft-1.0.so.0.300.2, \
		/usr/lib/libpangoxft-1.0.so.0.300.2)
	@$(call install_link, libpangoxft-1.0.so.0.300.2, /usr/lib/libpangoxft-1.0.so.0)
	@$(call install_link, libpangoxft-1.0.so.0.300.2, /usr/lib/libpangoxft-1.0.so)

	@$(call install_copy, 0, 0, 0644, \
		$(PANGO12_DIR)/pango/.libs/libpangoft2-1.0.so.0.300.2, \
		/usr/lib/libpangoft2-1.0.so.0.300.2)
	@$(call install_link, libpangoft2-1.0.so.0.300.2, /lib/libpangoft2-1.0.so.0)
	@$(call install_link, libpangoft2-1.0.so.0.300.2, /lib/libpangoft2-1.0.so)
	
	@$(call install_copy, 0, 0, 0644, \
		$(PANGO12_DIR)/pango/.libs/pango-querymodules, \
		/usr/bin/pango-querymodules)
		
	# FIXME: ipkgize
	cp -a $(CROSS_LIB_DIR)/lib/pango $(ROOTDIR)/usr/lib

	# FIXME: broken path; compare with ptxdist before 0.7.4
	@$(call install_copy, 0, 0, 0644, \
		$(ROOTDIR)/usr/lib/pango/$(PANGO_MODULE_VERSION)/modules, 
		/usr/lib/pango/$(PANGO_MODULE_VERSION)/modules)
	@$(call install_copy, 0, 0, 0644, \
		$(PANGO12_DIR)/modules/basic/.libs/*.so, \
		/usr/lib/pango/$(PANGO_MODULE_VERSION)/modules)
	@$(call install_finish)
	
	@$(call touch, $@)
	

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pango12_clean:
	rm -rf $(STATEDIR)/pango12.*
	rm -rf $(IMAGEDIR)/pango12_*
	rm -rf $(PANGO12_DIR)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/pango*

# vim: syntax=make
