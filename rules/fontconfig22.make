# -*-makefile-*-
# $Id: fontconfig22.make,v 1.4 2004/02/23 16:15:18 bsp Exp $
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
FONTCONFIG22_VERSION		= 2.2.92
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
	$(STATEDIR)/freetype214.install \
	$(STATEDIR)/virtual-xchain.install

FONTCONFIG22_PATH	=  PATH=$(CROSS_PATH)
FONTCONFIG22_ENV 	=  $(CROSS_ENV)
FONTCONFIG22_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
FONTCONFIG22_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)
FONTCONFIG22_AUTOCONF	+= --build=$(GNU_HOST)
FONTCONFIG22_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

FONTCONFIG22_AUTOCONF	+= --disable-docs
FONTCONFIG22_AUTOCONF	+= --with-expat-lib=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
FONTCONFIG22_AUTOCONF	+= --with-expat-include=$(PTXCONF_PREFIX)/include
FONTCONFIG22_AUTOCONF	+= --with-freetype-config="pkg-config freetype2"

ifdef PTXCONF_FONTCONFIG22_FOO
FONTCONFIG22_AUTOCONF	+= --enable-foo
endif

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
# FIXME: uggly hack to fix wrongly detected libfreetype.la path
	- $(FONTCONFIG22_PATH) make -C $(FONTCONFIG22_DIR)
	cd $(FONTCONFIG22_DIR)/src && \
		perl -i -p -e "s,/usr/lib/libfreetype.la,$(FREETYPE214_DIR)/objs/libfreetype.la,g" libfontconfig.la
	cd $(FONTCONFIG22_DIR) && $(FONTCONFIG22_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fontconfig22_install: $(STATEDIR)/fontconfig22.install

$(STATEDIR)/fontconfig22.install: $(STATEDIR)/fontconfig22.compile
	@$(call targetinfo, $@)
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/$(PTXCONF_GNU_TARGET)/lib/libfontconfig.so*
	install $(FONTCONFIG22_DIR)/src/.libs/libfontconfig.so.1.0.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/
	ln -sf libfontconfig.so.1.0.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfontconfig.so.1
	ln -sf libfontconfig.so.1.0.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfontconfig.so
	rm -fr $(PTXCONF_PREFIX)/$(PTXCONV_GNU_TARGET)/include/fontconfig
	cp -a $(FONTCONFIG22_DIR)/fontconfig $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fontconfig22_targetinstall: $(STATEDIR)/fontconfig22.targetinstall

fontconfig22_targetinstall_deps	=  $(STATEDIR)/fontconfig22.compile

$(STATEDIR)/fontconfig22.targetinstall: $(fontconfig22_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)
	rm -f $(ROOTDIR)/lib/libfontconfig.so*
	install $(FONTCONFIG22_DIR)/src/.libs/libfontconfig.so.1.0.4 $(ROOTDIR)/lib/
	ln -sf libfontconfig.so.1.0.4 $(ROOTDIR)/lib/libfontconfig.so.1
	ln -sf libfontconfig.so.1.0.4 $(ROOTDIR)/lib/libfontconfig.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fontconfig22_clean:
	rm -rf $(STATEDIR)/fontconfig22.*
	rm -rf $(FONTCONFIG22_DIR)

# vim: syntax=make
