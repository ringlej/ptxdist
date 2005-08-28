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
ifdef PTXCONF_XLIBS_XSCRNSAVER
PACKAGES += xlibs-xscrnsaver
endif

#
# Paths and names
#
XLIBS_XSCRNSAVER_VERSION	= 0.99.0
XLIBS_XSCRNSAVER		= libXScrnSaver-$(XLIBS_XSCRNSAVER_VERSION)
XLIBS_XSCRNSAVER_SUFFIX		= tar.bz2
XLIBS_XSCRNSAVER_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_XSCRNSAVER).$(XLIBS_XSCRNSAVER_SUFFIX)
XLIBS_XSCRNSAVER_SOURCE		= $(SRCDIR)/$(XLIBS_XSCRNSAVER).$(XLIBS_XSCRNSAVER_SUFFIX)
XLIBS_XSCRNSAVER_DIR		= $(BUILDDIR)/$(XLIBS_XSCRNSAVER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xscrnsaver_get: $(STATEDIR)/xlibs-xscrnsaver.get

xlibs-xscrnsaver_get_deps = $(XLIBS_XSCRNSAVER_SOURCE)

$(STATEDIR)/xlibs-xscrnsaver.get: $(xlibs-xscrnsaver_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XSCRNSAVER))
	$(call touch, $@)

$(XLIBS_XSCRNSAVER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XSCRNSAVER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xscrnsaver_extract: $(STATEDIR)/xlibs-xscrnsaver.extract

xlibs-xscrnsaver_extract_deps = $(STATEDIR)/xlibs-xscrnsaver.get

$(STATEDIR)/xlibs-xscrnsaver.extract: $(xlibs-xscrnsaver_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XSCRNSAVER_DIR))
	@$(call extract, $(XLIBS_XSCRNSAVER_SOURCE))
	@$(call patchin, $(XLIBS_XSCRNSAVER))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xscrnsaver_prepare: $(STATEDIR)/xlibs-xscrnsaver.prepare

#
# dependencies
#
xlibs-xscrnsaver_prepare_deps = \
	$(STATEDIR)/xlibs-xscrnsaver.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/xlibs-scrnsaverproto.install

XLIBS_XSCRNSAVER_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XSCRNSAVER_ENV 	=  $(CROSS_ENV)
XLIBS_XSCRNSAVER_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XSCRNSAVER_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XSCRNSAVER_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xscrnsaver.prepare: $(xlibs-xscrnsaver_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XSCRNSAVER_DIR)/config.cache)
	cd $(XLIBS_XSCRNSAVER_DIR) && \
		$(XLIBS_XSCRNSAVER_PATH) $(XLIBS_XSCRNSAVER_ENV) \
		./configure $(XLIBS_XSCRNSAVER_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xscrnsaver_compile: $(STATEDIR)/xlibs-xscrnsaver.compile

xlibs-xscrnsaver_compile_deps = $(STATEDIR)/xlibs-xscrnsaver.prepare

$(STATEDIR)/xlibs-xscrnsaver.compile: $(xlibs-xscrnsaver_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XSCRNSAVER_DIR) && $(XLIBS_XSCRNSAVER_ENV) $(XLIBS_XSCRNSAVER_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xscrnsaver_install: $(STATEDIR)/xlibs-xscrnsaver.install

$(STATEDIR)/xlibs-xscrnsaver.install: $(STATEDIR)/xlibs-xscrnsaver.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XSCRNSAVER_DIR) && $(XLIBS_XSCRNSAVER_ENV) $(XLIBS_XSCRNSAVER_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xscrnsaver_targetinstall: $(STATEDIR)/xlibs-xscrnsaver.targetinstall

xlibs-xscrnsaver_targetinstall_deps = \
	$(STATEDIR)/xlibs-xscrnsaver.compile \
	$(STATEDIR)/xlibs-scrnsaverproto.install

$(STATEDIR)/xlibs-xscrnsaver.targetinstall: $(xlibs-xscrnsaver_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xscrnsaver)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_XSCRNSAVER_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_XSCRNSAVER_DIR)/src/.libs/libXScrnSaver.so.7.0.0, /usr/X11R6/lib/libXScrnSaver.so.7.0.0)
	@$(call install_link, libXScrnSaver.so.7.0.0, /usr/X11R6/lib/libXScrnSaver.so.7)
	@$(call install_link, libXScrnSaver.so.7.0.0, /usr/X11R6/lib/libXScrnSaver.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xscrnsaver_clean:
	rm -rf $(STATEDIR)/xlibs-xscrnsaver.*
	rm -rf $(IMAGEDIR)/xlibs-xscrnsaver_*
	rm -rf $(XLIBS_XSCRNSAVER_DIR)

# vim: syntax=make
