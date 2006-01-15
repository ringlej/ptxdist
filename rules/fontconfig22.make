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
PACKAGES-$(PTXCONF_FONTCONFIG22) += fontconfig22


#
# Paths and names
#
FONTCONFIG22_VERSION		= 2.2.99
FONTCONFIG22			= fontconfig-$(FONTCONFIG22_VERSION)
FONTCONFIG22_SUFFIX		= tar.gz
FONTCONFIG22_URL		= http://fontconfig.org/release/$(FONTCONFIG22).$(FONTCONFIG22_SUFFIX)
FONTCONFIG22_SOURCE		= $(SRCDIR)/$(FONTCONFIG22).$(FONTCONFIG22_SUFFIX)
FONTCONFIG22_DIR		= $(BUILDDIR)/$(FONTCONFIG22)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fontconfig22_get: $(STATEDIR)/fontconfig22.get

$(STATEDIR)/fontconfig22.get: $(fontconfig22_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(FONTCONFIG22))
	@$(call touch, $@)

$(FONTCONFIG22_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FONTCONFIG22_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fontconfig22_extract: $(STATEDIR)/fontconfig22.extract

$(STATEDIR)/fontconfig22.extract: $(fontconfig22_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FONTCONFIG22_DIR))
	@$(call extract, $(FONTCONFIG22_SOURCE))
	@$(call patchin, $(FONTCONFIG22))

	# man pages are missing, fake them
	touch $(FONTCONFIG22_DIR)/fc-cache/fc-cache.1 
	touch $(FONTCONFIG22_DIR)/fc-list/fc-list.1

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fontconfig22_prepare: $(STATEDIR)/fontconfig22.prepare

FONTCONFIG22_PATH	=  PATH=$(CROSS_PATH)
FONTCONFIG22_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
FONTCONFIG22_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
FONTCONFIG22_AUTOCONF	+= --disable-docs
FONTCONFIG22_AUTOCONF	+= --with-expat-lib=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
FONTCONFIG22_AUTOCONF	+= --with-expat-include=$(PTXCONF_PREFIX)/include
FONTCONFIG22_AUTOCONF	+= --with-freetype-config="pkg-config freetype2"

$(STATEDIR)/fontconfig22.prepare: $(fontconfig22_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FONTCONFIG22_BUILDDIR))
	cd $(FONTCONFIG22_DIR) && \
		$(FONTCONFIG22_PATH) $(FONTCONFIG22_ENV) \
		./configure $(FONTCONFIG22_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fontconfig22_compile: $(STATEDIR)/fontconfig22.compile

$(STATEDIR)/fontconfig22.compile: $(fontconfig22_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FONTCONFIG22_DIR) && \
		$(FONTCONFIG22_PATH) make 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fontconfig22_install: $(STATEDIR)/fontconfig22.install

$(STATEDIR)/fontconfig22.install: $(fontconfig22_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FONTCONFIG22)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fontconfig22_targetinstall: $(STATEDIR)/fontconfig22.targetinstall

$(STATEDIR)/fontconfig22.targetinstall: $(fontconfig22_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,fontconfig22)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(FONTCONFIG22_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(FONTCONFIG22_DIR)/src/.libs/libfontconfig.so.1.0.4, \
		/usr/lib/libfontconfig.so.1.0.4)
	@$(call install_link, libfontconfig.so.1.0.4, /usr/lib/libfontconfig.so.1)
	@$(call install_link, libfontconfig.so.1.0.4, /usr/lib/libfontconfig.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fontconfig22_clean:
	rm -rf $(STATEDIR)/fontconfig22.*
	rm -rf $(IMAGEDIR)/fontconfig22_*
	rm -rf $(FONTCONFIG22_DIR)

# vim: syntax=make
