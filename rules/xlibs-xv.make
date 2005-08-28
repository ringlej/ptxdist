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
ifdef PTXCONF_XLIBS_XV
PACKAGES += xlibs-xv
endif

#
# Paths and names
#
XLIBS_XV_VERSION	= 0.99.0
XLIBS_XV		= libXv-$(XLIBS_XV_VERSION)
XLIBS_XV_SUFFIX		= tar.bz2
XLIBS_XV_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_XV).$(XLIBS_XV_SUFFIX)
XLIBS_XV_SOURCE		= $(SRCDIR)/$(XLIBS_XV).$(XLIBS_XV_SUFFIX)
XLIBS_XV_DIR		= $(BUILDDIR)/$(XLIBS_XV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xv_get: $(STATEDIR)/xlibs-xv.get

xlibs-xv_get_deps = $(XLIBS_XV_SOURCE)

$(STATEDIR)/xlibs-xv.get: $(xlibs-xv_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XV))
	$(call touch, $@)

$(XLIBS_XV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XV_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xv_extract: $(STATEDIR)/xlibs-xv.extract

xlibs-xv_extract_deps = $(STATEDIR)/xlibs-xv.get

$(STATEDIR)/xlibs-xv.extract: $(xlibs-xv_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XV_DIR))
	@$(call extract, $(XLIBS_XV_SOURCE))
	@$(call patchin, $(XLIBS_XV))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xv_prepare: $(STATEDIR)/xlibs-xv.prepare

#
# dependencies
#
xlibs-xv_prepare_deps = \
	$(STATEDIR)/xlibs-xv.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/xlibs-videoproto.install

XLIBS_XV_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XV_ENV 	=  $(CROSS_ENV)
XLIBS_XV_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XV_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XV_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xv.prepare: $(xlibs-xv_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XV_DIR)/config.cache)
	cd $(XLIBS_XV_DIR) && \
		$(XLIBS_XV_PATH) $(XLIBS_XV_ENV) \
		./configure $(XLIBS_XV_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xv_compile: $(STATEDIR)/xlibs-xv.compile

xlibs-xv_compile_deps = $(STATEDIR)/xlibs-xv.prepare

$(STATEDIR)/xlibs-xv.compile: $(xlibs-xv_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XV_DIR) && $(XLIBS_XV_ENV) $(XLIBS_XV_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xv_install: $(STATEDIR)/xlibs-xv.install

$(STATEDIR)/xlibs-xv.install: $(STATEDIR)/xlibs-xv.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XV_DIR) && $(XLIBS_XV_ENV) $(XLIBS_XV_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xv_targetinstall: $(STATEDIR)/xlibs-xv.targetinstall

xlibs-xv_targetinstall_deps = \
	$(STATEDIR)/xlibs-xv.compile \
	$(STATEDIR)/xlibs-videoproto.targetinstall

$(STATEDIR)/xlibs-xv.targetinstall: $(xlibs-xv_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xv)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_XV_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_XV_DIR)/src/.libs/libXv.so.1.0.0, /usr/X11R6/lib/libXv.so.1.0.0)
	@$(call install_link, libXv.so.1.0.0, /usr/X11R6/lib/libXv.so.1)
	@$(call install_link, libXv.so.1.0.0, /usr/X11R6/lib/libXv.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xv_clean:
	rm -rf $(STATEDIR)/xlibs-xv.*
	rm -rf $(IMAGEDIR)/xlibs-xv_*
	rm -rf $(XLIBS_XV_DIR)

# vim: syntax=make
