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
ifdef PTXCONF_XLIBS_FONTENC
PACKAGES += xlibs-fontenc
endif

#
# Paths and names
#
XLIBS_FONTENC_VERSION	= 0.99.0
XLIBS_FONTENC		= libfontenc-$(XLIBS_FONTENC_VERSION)
XLIBS_FONTENC_SUFFIX	= tar.bz2
XLIBS_FONTENC_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_FONTENC).$(XLIBS_FONTENC_SUFFIX)
XLIBS_FONTENC_SOURCE	= $(SRCDIR)/$(XLIBS_FONTENC).$(XLIBS_FONTENC_SUFFIX)
XLIBS_FONTENC_DIR	= $(BUILDDIR)/$(XLIBS_FONTENC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-fontenc_get: $(STATEDIR)/xlibs-fontenc.get

xlibs-fontenc_get_deps = $(XLIBS_FONTENC_SOURCE)

$(STATEDIR)/xlibs-fontenc.get: $(xlibs-fontenc_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_FONTENC))
	$(call touch, $@)

$(XLIBS_FONTENC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_FONTENC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-fontenc_extract: $(STATEDIR)/xlibs-fontenc.extract

xlibs-fontenc_extract_deps = $(STATEDIR)/xlibs-fontenc.get

$(STATEDIR)/xlibs-fontenc.extract: $(xlibs-fontenc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTENC_DIR))
	@$(call extract, $(XLIBS_FONTENC_SOURCE))
	@$(call patchin, $(XLIBS_FONTENC))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-fontenc_prepare: $(STATEDIR)/xlibs-fontenc.prepare

#
# dependencies
#
xlibs-fontenc_prepare_deps = \
	$(STATEDIR)/xlibs-fontenc.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_FONTENC_PATH	=  PATH=$(CROSS_PATH)
XLIBS_FONTENC_ENV 	=  $(CROSS_ENV)
XLIBS_FONTENC_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_FONTENC_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_FONTENC_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-fontenc.prepare: $(xlibs-fontenc_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTENC_DIR)/config.cache)
	cd $(XLIBS_FONTENC_DIR) && \
		$(XLIBS_FONTENC_PATH) $(XLIBS_FONTENC_ENV) \
		./configure $(XLIBS_FONTENC_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-fontenc_compile: $(STATEDIR)/xlibs-fontenc.compile

xlibs-fontenc_compile_deps = $(STATEDIR)/xlibs-fontenc.prepare

$(STATEDIR)/xlibs-fontenc.compile: $(xlibs-fontenc_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTENC_DIR) && $(XLIBS_FONTENC_ENV) $(XLIBS_FONTENC_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-fontenc_install: $(STATEDIR)/xlibs-fontenc.install

$(STATEDIR)/xlibs-fontenc.install: $(STATEDIR)/xlibs-fontenc.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTENC_DIR) && $(XLIBS_FONTENC_ENV) $(XLIBS_FONTENC_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-fontenc_targetinstall: $(STATEDIR)/xlibs-fontenc.targetinstall

xlibs-fontenc_targetinstall_deps = $(STATEDIR)/xlibs-fontenc.compile

$(STATEDIR)/xlibs-fontenc.targetinstall: $(xlibs-fontenc_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-fontenc)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_FONTENC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_FONTENC_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-fontenc_clean:
	rm -rf $(STATEDIR)/xlibs-fontenc.*
	rm -rf $(IMAGEDIR)/xlibs-fontenc_*
	rm -rf $(XLIBS_FONTENC_DIR)

# vim: syntax=make
