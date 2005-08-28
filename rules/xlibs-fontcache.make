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
ifdef PTXCONF_XLIBS_FONTCACHE
PACKAGES += xlibs-fontcache
endif

#
# Paths and names
#
XLIBS_FONTCACHE_VERSION	= 0.99.0
XLIBS_FONTCACHE		= libXfontcache-$(XLIBS_FONTCACHE_VERSION)
XLIBS_FONTCACHE_SUFFIX	= tar.bz2
XLIBS_FONTCACHE_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_FONTCACHE).$(XLIBS_FONTCACHE_SUFFIX)
XLIBS_FONTCACHE_SOURCE	= $(SRCDIR)/$(XLIBS_FONTCACHE).$(XLIBS_FONTCACHE_SUFFIX)
XLIBS_FONTCACHE_DIR	= $(BUILDDIR)/$(XLIBS_FONTCACHE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-fontcache_get: $(STATEDIR)/xlibs-fontcache.get

xlibs-fontcache_get_deps = $(XLIBS_FONTCACHE_SOURCE)

$(STATEDIR)/xlibs-fontcache.get: $(xlibs-fontcache_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_FONTCACHE))
	touch $@

$(XLIBS_FONTCACHE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_FONTCACHE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-fontcache_extract: $(STATEDIR)/xlibs-fontcache.extract

xlibs-fontcache_extract_deps = $(STATEDIR)/xlibs-fontcache.get

$(STATEDIR)/xlibs-fontcache.extract: $(xlibs-fontcache_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTCACHE_DIR))
	@$(call extract, $(XLIBS_FONTCACHE_SOURCE))
	@$(call patchin, $(XLIBS_FONTCACHE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-fontcache_prepare: $(STATEDIR)/xlibs-fontcache.prepare

#
# dependencies
#
xlibs-fontcache_prepare_deps = \
	$(STATEDIR)/xlibs-fontcache.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/xlibs-x11.install \
	$(STATEDIR)/xlibs-xext.install \
	$(STATEDIR)/xlibs-fontcacheproto.install 

XLIBS_FONTCACHE_PATH	=  PATH=$(CROSS_PATH)
XLIBS_FONTCACHE_ENV 	=  $(CROSS_ENV)
XLIBS_FONTCACHE_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_FONTCACHE_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_FONTCACHE_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-fontcache.prepare: $(xlibs-fontcache_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTCACHE_DIR)/config.cache)
	cd $(XLIBS_FONTCACHE_DIR) && \
		$(XLIBS_FONTCACHE_PATH) $(XLIBS_FONTCACHE_ENV) \
		./configure $(XLIBS_FONTCACHE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-fontcache_compile: $(STATEDIR)/xlibs-fontcache.compile

xlibs-fontcache_compile_deps = $(STATEDIR)/xlibs-fontcache.prepare

$(STATEDIR)/xlibs-fontcache.compile: $(xlibs-fontcache_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTCACHE_DIR) && $(XLIBS_FONTCACHE_ENV) $(XLIBS_FONTCACHE_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-fontcache_install: $(STATEDIR)/xlibs-fontcache.install

$(STATEDIR)/xlibs-fontcache.install: $(STATEDIR)/xlibs-fontcache.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTCACHE_DIR) && $(XLIBS_FONTCACHE_ENV) $(XLIBS_FONTCACHE_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-fontcache_targetinstall: $(STATEDIR)/xlibs-fontcache.targetinstall

xlibs-fontcache_targetinstall_deps = \
	$(STATEDIR)/xlibs-fontcache.compile \
	$(STATEDIR)/xlibs-x11.install \
	$(STATEDIR)/xlibs-xext.install \
	$(STATEDIR)/xlibs-fontcacheproto.install \

$(STATEDIR)/xlibs-fontcache.targetinstall: $(xlibs-fontcache_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-fontcache)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_FONTCACHE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_FONTCACHE_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-fontcache_clean:
	rm -rf $(STATEDIR)/xlibs-fontcache.*
	rm -rf $(IMAGEDIR)/xlibs-fontcache_*
	rm -rf $(XLIBS_FONTCACHE_DIR)

# vim: syntax=make
