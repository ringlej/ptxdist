# -*-makefile-*-
# $Id: template 3069 2005-08-28 21:49:04Z rsc $
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
ifdef PTXCONF_XLIBS_LIBICE
PACKAGES += xlibs-libice
endif

#
# Paths and names
#
XLIBS_LIBICE_VERSION	= 0.99.0
XLIBS_LIBICE		= libICE-$(XLIBS_LIBICE_VERSION)
XLIBS_LIBICE_SUFFIX	= tar.bz2
XLIBS_LIBICE_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_LIBICE).$(XLIBS_LIBICE_SUFFIX)
XLIBS_LIBICE_SOURCE	= $(SRCDIR)/$(XLIBS_LIBICE).$(XLIBS_LIBICE_SUFFIX)
XLIBS_LIBICE_DIR	= $(BUILDDIR)/$(XLIBS_LIBICE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-libice_get: $(STATEDIR)/xlibs-libice.get

xlibs-libice_get_deps = $(XLIBS_LIBICE_SOURCE)

$(STATEDIR)/xlibs-libice.get: $(xlibs-libice_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_LIBICE))
	$(call touch, $@)

$(XLIBS_LIBICE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_LIBICE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-libice_extract: $(STATEDIR)/xlibs-libice.extract

xlibs-libice_extract_deps = $(STATEDIR)/xlibs-libice.get

$(STATEDIR)/xlibs-libice.extract: $(xlibs-libice_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_LIBICE_DIR))
	@$(call extract, $(XLIBS_LIBICE_SOURCE))
	@$(call patchin, $(XLIBS_LIBICE))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-libice_prepare: $(STATEDIR)/xlibs-libice.prepare

#
# dependencies
#
xlibs-libice_prepare_deps = \
	$(STATEDIR)/xlibs-libice.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/xlibs-xtrans.install \
	$(STATEDIR)/xlibs-xproto.install

XLIBS_LIBICE_PATH	=  PATH=$(CROSS_PATH)
XLIBS_LIBICE_ENV 	=  $(CROSS_ENV)
XLIBS_LIBICE_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_LIBICE_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_LIBICE_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-libice.prepare: $(xlibs-libice_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_LIBICE_DIR)/config.cache)
	cd $(XLIBS_LIBICE_DIR) && \
		$(XLIBS_LIBICE_PATH) $(XLIBS_LIBICE_ENV) \
		./configure $(XLIBS_LIBICE_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-libice_compile: $(STATEDIR)/xlibs-libice.compile

xlibs-libice_compile_deps = $(STATEDIR)/xlibs-libice.prepare

$(STATEDIR)/xlibs-libice.compile: $(xlibs-libice_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_LIBICE_DIR) && $(XLIBS_LIBICE_ENV) $(XLIBS_LIBICE_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-libice_install: $(STATEDIR)/xlibs-libice.install

$(STATEDIR)/xlibs-libice.install: $(STATEDIR)/xlibs-libice.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_LIBICE_DIR) && $(XLIBS_LIBICE_ENV) $(XLIBS_LIBICE_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-libice_targetinstall: $(STATEDIR)/xlibs-libice.targetinstall

xlibs-libice_targetinstall_deps = \
	$(STATEDIR)/xlibs-libice.compile \
	$(STATEDIR)/xlibs-xtrans.targetinstall \
	$(STATEDIR)/xlibs-xproto.targetinstall

$(STATEDIR)/xlibs-libice.targetinstall: $(xlibs-libice_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-libice)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_LIBICE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_LIBICE_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-libice_clean:
	rm -rf $(STATEDIR)/xlibs-libice.*
	rm -rf $(IMAGEDIR)/xlibs-libice_*
	rm -rf $(XLIBS_LIBICE_DIR)

# vim: syntax=make
