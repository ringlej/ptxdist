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
ifdef PTXCONF_XLIBS_PROTO_FONTCACHEPROTO
PACKAGES += xlibs-fontcacheproto
endif

#
# Paths and names
#
XLIBS_FONTCACHEPROTO_VERSION	= 0.1
XLIBS_FONTCACHEPROTO		= fontcacheproto-$(XLIBS_FONTCACHEPROTO_VERSION)
XLIBS_FONTCACHEPROTO_SUFFIX	= tar.bz2
XLIBS_FONTCACHEPROTO_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_FONTCACHEPROTO).$(XLIBS_FONTCACHEPROTO_SUFFIX)
XLIBS_FONTCACHEPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_FONTCACHEPROTO).$(XLIBS_FONTCACHEPROTO_SUFFIX)
XLIBS_FONTCACHEPROTO_DIR	= $(BUILDDIR)/$(XLIBS_FONTCACHEPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-fontcacheproto_get: $(STATEDIR)/xlibs-fontcacheproto.get

xlibs-fontcacheproto_get_deps = $(XLIBS_FONTCACHEPROTO_SOURCE)

$(STATEDIR)/xlibs-fontcacheproto.get: $(xlibs-fontcacheproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_FONTCACHEPROTO))
	touch $@

$(XLIBS_FONTCACHEPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_FONTCACHEPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-fontcacheproto_extract: $(STATEDIR)/xlibs-fontcacheproto.extract

xlibs-fontcacheproto_extract_deps = $(STATEDIR)/xlibs-fontcacheproto.get

$(STATEDIR)/xlibs-fontcacheproto.extract: $(xlibs-fontcacheproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTCACHEPROTO_DIR))
	@$(call extract, $(XLIBS_FONTCACHEPROTO_SOURCE))
	@$(call patchin, $(XLIBS_FONTCACHEPROTO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-fontcacheproto_prepare: $(STATEDIR)/xlibs-fontcacheproto.prepare

#
# dependencies
#
xlibs-fontcacheproto_prepare_deps = \
	$(STATEDIR)/xlibs-fontcacheproto.extract \
	$(STATEDIR)/xlibs-fontsproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_FONTCACHEPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_FONTCACHEPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_FONTCACHEPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_FONTCACHEPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_FONTCACHEPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-fontcacheproto.prepare: $(xlibs-fontcacheproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTCACHEPROTO_DIR)/config.cache)
	cd $(XLIBS_FONTCACHEPROTO_DIR) && \
		$(XLIBS_FONTCACHEPROTO_PATH) $(XLIBS_FONTCACHEPROTO_ENV) \
		./configure $(XLIBS_FONTCACHEPROTO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-fontcacheproto_compile: $(STATEDIR)/xlibs-fontcacheproto.compile

xlibs-fontcacheproto_compile_deps = $(STATEDIR)/xlibs-fontcacheproto.prepare

$(STATEDIR)/xlibs-fontcacheproto.compile: $(xlibs-fontcacheproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTCACHEPROTO_DIR) && $(XLIBS_FONTCACHEPROTO_ENV) $(XLIBS_FONTCACHEPROTO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-fontcacheproto_install: $(STATEDIR)/xlibs-fontcacheproto.install

$(STATEDIR)/xlibs-fontcacheproto.install: $(STATEDIR)/xlibs-fontcacheproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTCACHEPROTO_DIR) && $(XLIBS_FONTCACHEPROTO_ENV) $(XLIBS_FONTCACHEPROTO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-fontcacheproto_targetinstall: $(STATEDIR)/xlibs-fontcacheproto.targetinstall

xlibs-fontcacheproto_targetinstall_deps = \
	$(STATEDIR)/xlibs-fontcacheproto.compile \
	$(STATEDIR)/xlibs-fontsproto.extract

$(STATEDIR)/xlibs-fontcacheproto.targetinstall: $(xlibs-fontcacheproto_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-fontcacheproto)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_FONTCACHEPROTO_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_FONTCACHEPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-fontcacheproto_clean:
	rm -rf $(STATEDIR)/xlibs-fontcacheproto.*
	rm -rf $(IMAGEDIR)/xlibs-fontcacheproto_*
	rm -rf $(XLIBS_FONTCACHEPROTO_DIR)

# vim: syntax=make
