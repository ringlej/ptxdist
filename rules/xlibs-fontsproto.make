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
ifdef PTXCONF_XLIBS_FONTSPROTO
PACKAGES += xlibs-fontsproto
endif

#
# Paths and names
#
XLIBS_FONTSPROTO_VERSION	= 2.0
XLIBS_FONTSPROTO		= fontsproto-$(XLIBS_FONTSPROTO_VERSION)
XLIBS_FONTSPROTO_SUFFIX		= tar.bz2
XLIBS_FONTSPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_FONTSPROTO).$(XLIBS_FONTSPROTO_SUFFIX)
XLIBS_FONTSPROTO_SOURCE		= $(SRCDIR)/$(XLIBS_FONTSPROTO).$(XLIBS_FONTSPROTO_SUFFIX)
XLIBS_FONTSPROTO_DIR		= $(BUILDDIR)/$(XLIBS_FONTSPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-fontsproto_get: $(STATEDIR)/xlibs-fontsproto.get

xlibs-fontsproto_get_deps = $(XLIBS_FONTSPROTO_SOURCE)

$(STATEDIR)/xlibs-fontsproto.get: $(xlibs-fontsproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_FONTSPROTO))
	touch $@

$(XLIBS_FONTSPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_FONTSPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-fontsproto_extract: $(STATEDIR)/xlibs-fontsproto.extract

xlibs-fontsproto_extract_deps = $(STATEDIR)/xlibs-fontsproto.get

$(STATEDIR)/xlibs-fontsproto.extract: $(xlibs-fontsproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTSPROTO_DIR))
	@$(call extract, $(XLIBS_FONTSPROTO_SOURCE))
	@$(call patchin, $(XLIBS_FONTSPROTO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-fontsproto_prepare: $(STATEDIR)/xlibs-fontsproto.prepare

#
# dependencies
#
xlibs-fontsproto_prepare_deps = \
	$(STATEDIR)/xlibs-fontsproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_FONTSPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_FONTSPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_FONTSPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_FONTSPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_FONTSPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-fontsproto.prepare: $(xlibs-fontsproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FONTSPROTO_DIR)/config.cache)
	cd $(XLIBS_FONTSPROTO_DIR) && \
		$(XLIBS_FONTSPROTO_PATH) $(XLIBS_FONTSPROTO_ENV) \
		./configure $(XLIBS_FONTSPROTO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-fontsproto_compile: $(STATEDIR)/xlibs-fontsproto.compile

xlibs-fontsproto_compile_deps = $(STATEDIR)/xlibs-fontsproto.prepare

$(STATEDIR)/xlibs-fontsproto.compile: $(xlibs-fontsproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTSPROTO_DIR) && $(XLIBS_FONTSPROTO_ENV) $(XLIBS_FONTSPROTO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-fontsproto_install: $(STATEDIR)/xlibs-fontsproto.install

$(STATEDIR)/xlibs-fontsproto.install: $(STATEDIR)/xlibs-fontsproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_FONTSPROTO_DIR) && $(XLIBS_FONTSPROTO_ENV) $(XLIBS_FONTSPROTO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-fontsproto_targetinstall: $(STATEDIR)/xlibs-fontsproto.targetinstall

xlibs-fontsproto_targetinstall_deps = $(STATEDIR)/xlibs-fontsproto.compile

$(STATEDIR)/xlibs-fontsproto.targetinstall: $(xlibs-fontsproto_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-fontsproto)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_FONTSPROTO_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_FONTSPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-fontsproto_clean:
	rm -rf $(STATEDIR)/xlibs-fontsproto.*
	rm -rf $(IMAGEDIR)/xlibs-fontsproto_*
	rm -rf $(XLIBS_FONTSPROTO_DIR)

# vim: syntax=make
