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
ifdef PTXCONF_XLIBS_BIGREQSPROTO
PACKAGES += xlibs-bigreqsproto
endif

#
# Paths and names
#
XLIBS_BIGREQSPROTO_VERSION	= 1.0
XLIBS_BIGREQSPROTO		= bigreqsproto-$(XLIBS_BIGREQSPROTO_VERSION)
XLIBS_BIGREQSPROTO_SUFFIX	= tar.bz2
XLIBS_BIGREQSPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_BIGREQSPROTO).$(XLIBS_BIGREQSPROTO_SUFFIX)
XLIBS_BIGREQSPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_BIGREQSPROTO).$(XLIBS_BIGREQSPROTO_SUFFIX)
XLIBS_BIGREQSPROTO_DIR		= $(BUILDDIR)/$(XLIBS_BIGREQSPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-bigreqsproto_get: $(STATEDIR)/xlibs-bigreqsproto.get

xlibs-bigreqsproto_get_deps = $(XLIBS_BIGREQSPROTO_SOURCE)

$(STATEDIR)/xlibs-bigreqsproto.get: $(xlibs-bigreqsproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_BIGREQSPROTO))
	touch $@

$(XLIBS_BIGREQSPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_BIGREQSPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-bigreqsproto_extract: $(STATEDIR)/xlibs-bigreqsproto.extract

xlibs-bigreqsproto_extract_deps = $(STATEDIR)/xlibs-bigreqsproto.get

$(STATEDIR)/xlibs-bigreqsproto.extract: $(xlibs-bigreqsproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_BIGREQSPROTO_DIR))
	@$(call extract, $(XLIBS_BIGREQSPROTO_SOURCE))
	@$(call patchin, $(XLIBS_BIGREQSPROTO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-bigreqsproto_prepare: $(STATEDIR)/xlibs-bigreqsproto.prepare

#
# dependencies
#
xlibs-bigreqsproto_prepare_deps = \
	$(STATEDIR)/xlibs-bigreqsproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_BIGREQSPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_BIGREQSPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_BIGREQSPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_BIGREQSPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_BIGREQSPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-bigreqsproto.prepare: $(xlibs-bigreqsproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_BIGREQSPROTO_DIR)/config.cache)
	cd $(XLIBS_BIGREQSPROTO_DIR) && \
		$(XLIBS_BIGREQSPROTO_PATH) $(XLIBS_BIGREQSPROTO_ENV) \
		./configure $(XLIBS_BIGREQSPROTO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-bigreqsproto_compile: $(STATEDIR)/xlibs-bigreqsproto.compile

xlibs-bigreqsproto_compile_deps = $(STATEDIR)/xlibs-bigreqsproto.prepare

$(STATEDIR)/xlibs-bigreqsproto.compile: $(xlibs-bigreqsproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_BIGREQSPROTO_DIR) && $(XLIBS_BIGREQSPROTO_ENV) $(XLIBS_BIGREQSPROTO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-bigreqsproto_install: $(STATEDIR)/xlibs-bigreqsproto.install

$(STATEDIR)/xlibs-bigreqsproto.install: $(STATEDIR)/xlibs-bigreqsproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_BIGREQSPROTO_DIR) && $(XLIBS_BIGREQSPROTO_ENV) $(XLIBS_BIGREQSPROTO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-bigreqsproto_targetinstall: $(STATEDIR)/xlibs-bigreqsproto.targetinstall

xlibs-bigreqsproto_targetinstall_deps = $(STATEDIR)/xlibs-bigreqsproto.compile

$(STATEDIR)/xlibs-bigreqsproto.targetinstall: $(xlibs-bigreqsproto_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-bigreqsproto)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_BIGREQSPROTO_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_BIGREQSPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-bigreqsproto_clean:
	rm -rf $(STATEDIR)/xlibs-bigreqsproto.*
	rm -rf $(IMAGEDIR)/xlibs-bigreqsproto_*
	rm -rf $(XLIBS_BIGREQSPROTO_DIR)

# vim: syntax=make
