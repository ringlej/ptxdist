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
ifdef PTXCONF_FONTCONFIG22
PACKAGES += fontconfig22
endif


# http://pdx.freedesktop.org/~fontconfig/release/fontconfig-2.2.92.tar.gz
#
# Paths and names
#
FONTCONFIG22_VERSION		= 2.2.95
FONTCONFIG22			= fontconfig-$(FONTCONFIG22_VERSION)
FONTCONFIG22_SUFFIX		= tar.gz
FONTCONFIG22_URL		= http://pdx.freedesktop.org/~fontconfig/release/$(FONTCONFIG22).$(FONTCONFIG22_SUFFIX)
FONTCONFIG22_SOURCE		= $(SRCDIR)/$(FONTCONFIG22).$(FONTCONFIG22_SUFFIX)
FONTCONFIG22_DIR		= $(BUILDDIR)/$(FONTCONFIG22)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fontconfig22_get: $(STATEDIR)/fontconfig22.get

fontconfig22_get_deps	=  $(FONTCONFIG22_SOURCE)

$(STATEDIR)/fontconfig22.get: $(fontconfig22_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(FONTCONFIG22))
	touch $@

$(FONTCONFIG22_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FONTCONFIG22_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fontconfig22_extract: $(STATEDIR)/fontconfig22.extract

fontconfig22_extract_deps	=  $(STATEDIR)/fontconfig22.get

$(STATEDIR)/fontconfig22.extract: $(fontconfig22_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FONTCONFIG22_DIR))
	@$(call extract, $(FONTCONFIG22_SOURCE))
	@$(call patchin, $(FONTCONFIG22))

	# man pages are missing, fake them
	touch $(FONTCONFIG22_DIR)/fc-cache/fc-cache.1 
	touch $(FONTCONFIG22_DIR)/fc-list/fc-list.1

	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fontconfig22_prepare: $(STATEDIR)/fontconfig22.prepare

#
# dependencies
#
fontconfig22_prepare_deps =  \
	$(STATEDIR)/fontconfig22.extract \
	$(STATEDIR)/glib22.install \
	$(STATEDIR)/expat.install \
	$(STATEDIR)/freetype.install \
	$(STATEDIR)/virtual-xchain.install

FONTCONFIG22_PATH	=  PATH=$(CROSS_PATH)
FONTCONFIG22_ENV 	=  $(CROSS_ENV)
FONTCONFIG22_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
FONTCONFIG22_AUTOCONF	=  $(CROSS_AUTOCONF)
FONTCONFIG22_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)

FONTCONFIG22_AUTOCONF	+= --disable-docs
FONTCONFIG22_AUTOCONF	+= --with-expat-lib=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
FONTCONFIG22_AUTOCONF	+= --with-expat-include=$(PTXCONF_PREFIX)/include
FONTCONFIG22_AUTOCONF	+= --with-freetype-config="pkg-config freetype2"

$(STATEDIR)/fontconfig22.prepare: $(fontconfig22_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FONTCONFIG22_BUILDDIR))
	cd $(FONTCONFIG22_DIR) && \
		$(FONTCONFIG22_PATH) $(FONTCONFIG22_ENV) \
		./configure $(FONTCONFIG22_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fontconfig22_compile: $(STATEDIR)/fontconfig22.compile

fontconfig22_compile_deps =  $(STATEDIR)/fontconfig22.prepare

$(STATEDIR)/fontconfig22.compile: $(fontconfig22_compile_deps)
	@$(call targetinfo, $@)
	cd $(FONTCONFIG22_DIR) && \
	   $(FONTCONFIG22_PATH) make 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fontconfig22_install: $(STATEDIR)/fontconfig22.install

$(STATEDIR)/fontconfig22.install: $(STATEDIR)/fontconfig22.compile
	@$(call targetinfo, $@)
	cd $(FONTCONFIG22_DIR) && \
	   $(FONTCONFIG22_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fontconfig22_targetinstall: $(STATEDIR)/fontconfig22.targetinstall

fontconfig22_targetinstall_deps	=	$(STATEDIR)/fontconfig22.compile
fontconfig22_targetinstall_deps +=	$(STATEDIR)/glib22.targetinstall
fontconfig22_targetinstall_deps +=	$(STATEDIR)/expat.targetinstall
fontconfig22_targetinstall_deps +=	$(STATEDIR)/freetype.targetinstall

$(STATEDIR)/fontconfig22.targetinstall: $(fontconfig22_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,fontconfig22)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(FONTCONFIG22_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(FONTCONFIG22_DIR)/src/.libs/libfontconfig.so.1.0.4, \
		/usr/lib/libfontconfig.so.1.0.4)
	@$(call install_link, libfontconfig.so.1.0.4, /usr/lib/libfontconfig.so.1)
	@$(call install_link, libfontconfig.so.1.0.4, /usr/lib/libfontconfig.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fontconfig22_clean:
	rm -rf $(STATEDIR)/fontconfig22.*
	rm -rf $(IMAGEDIR)/fontconfig22_*
	rm -rf $(FONTCONFIG22_DIR)

# vim: syntax=make
