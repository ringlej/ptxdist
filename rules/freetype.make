# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FREETYPE) += freetype

#
# Paths and names
#
FREETYPE_VERSION	= 2.1.9
FREETYPE		= freetype-$(FREETYPE_VERSION)
FREETYPE_SUFFIX		= tar.gz
FREETYPE_URL		= ftp://gd.tuwien.ac.at/publishing/freetype/freetype2/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_SOURCE		= $(SRCDIR)/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_DIR		= $(BUILDDIR)/$(FREETYPE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

freetype_get: $(STATEDIR)/freetype.get

$(STATEDIR)/freetype.get: $(freetype_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FREETYPE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FREETYPE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

freetype_extract: $(STATEDIR)/freetype.extract

$(STATEDIR)/freetype.extract: $(freetype_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FREETYPE_DIR))
	@$(call extract, $(FREETYPE_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

freetype_prepare: $(STATEDIR)/freetype.prepare

FREETYPE_PATH	=  PATH=$(CROSS_PATH)
FREETYPE_ENV 	=  $(CROSS_ENV)
FREETYPE_ENV		+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
FREETYPE_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/freetype.prepare: $(freetype_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FREETYPE_BUILDDIR))
	cd $(FREETYPE_DIR) && \
		$(FREETYPE_PATH) $(FREETYPE_ENV) \
		./configure $(FREETYPE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

freetype_compile: $(STATEDIR)/freetype.compile

$(STATEDIR)/freetype.compile: $(freetype_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FREETYPE_DIR) $(FREETYPE_PATH) make
	chmod a+x $(FREETYPE_DIR)/builds/unix/freetype-config
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

freetype_install: $(STATEDIR)/freetype.install

$(STATEDIR)/freetype.install: $(freetype_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FREETYPE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

freetype_targetinstall: $(STATEDIR)/freetype.targetinstall

$(STATEDIR)/freetype.targetinstall: $(freetype_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,freetype)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(FREETYPE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0644, \
		$(FREETYPE_DIR)/objs/.libs/libfreetype.so.6.3.5, \
		/usr/lib/libfreetype.so.6.3.5)
	@$(call install_link, libfreetype.so.6.3.5, /usr/lib/libfreetype.so.6)		
	@$(call install_link, libfreetype.so.6.3.5, /usr/lib/libfreetype.so)		

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

freetype_clean:
	rm -rf $(STATEDIR)/freetype.*
	rm -rf $(IMAGEDIR)/freetype_*
	rm -rf $(FREETYPE_DIR)

# vim: syntax=make
