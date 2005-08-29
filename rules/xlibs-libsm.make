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
ifdef PTXCONF_XLIBS_LIBSM
PACKAGES += xlibs-libsm
endif

#
# Paths and names
#
XLIBS_LIBSM_VERSION	= 0.99.0
XLIBS_LIBSM		= libSM-$(XLIBS_LIBSM_VERSION)
XLIBS_LIBSM_SUFFIX	= tar.bz2
XLIBS_LIBSM_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_LIBSM).$(XLIBS_LIBSM_SUFFIX)
XLIBS_LIBSM_SOURCE	= $(SRCDIR)/$(XLIBS_LIBSM).$(XLIBS_LIBSM_SUFFIX)
XLIBS_LIBSM_DIR		= $(BUILDDIR)/$(XLIBS_LIBSM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-libsm_get: $(STATEDIR)/xlibs-libsm.get

xlibs-libsm_get_deps = $(XLIBS_LIBSM_SOURCE)

$(STATEDIR)/xlibs-libsm.get: $(xlibs-libsm_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_LIBSM))
	$(call touch, $@)

$(XLIBS_LIBSM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_LIBSM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-libsm_extract: $(STATEDIR)/xlibs-libsm.extract

xlibs-libsm_extract_deps = $(STATEDIR)/xlibs-libsm.get

$(STATEDIR)/xlibs-libsm.extract: $(xlibs-libsm_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_LIBSM_DIR))
	@$(call extract, $(XLIBS_LIBSM_SOURCE))
	@$(call patchin, $(XLIBS_LIBSM))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-libsm_prepare: $(STATEDIR)/xlibs-libsm.prepare

#
# dependencies
#
xlibs-libsm_prepare_deps = \
	$(STATEDIR)/xlibs-libsm.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/xlibs-xproto.install \
	$(STATEDIR)/xlibs-libice.install

XLIBS_LIBSM_PATH	=  PATH=$(CROSS_PATH)
XLIBS_LIBSM_ENV 	=  $(CROSS_ENV)
XLIBS_LIBSM_ENV		+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_LIBSM_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_LIBSM_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-libsm.prepare: $(xlibs-libsm_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_LIBSM_DIR)/config.cache)
	cd $(XLIBS_LIBSM_DIR) && \
		$(XLIBS_LIBSM_PATH) $(XLIBS_LIBSM_ENV) \
		./configure $(XLIBS_LIBSM_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-libsm_compile: $(STATEDIR)/xlibs-libsm.compile

xlibs-libsm_compile_deps = $(STATEDIR)/xlibs-libsm.prepare

$(STATEDIR)/xlibs-libsm.compile: $(xlibs-libsm_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_LIBSM_DIR) && $(XLIBS_LIBSM_ENV) $(XLIBS_LIBSM_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-libsm_install: $(STATEDIR)/xlibs-libsm.install

$(STATEDIR)/xlibs-libsm.install: $(STATEDIR)/xlibs-libsm.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_LIBSM_DIR) && $(XLIBS_LIBSM_ENV) $(XLIBS_LIBSM_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-libsm_targetinstall: $(STATEDIR)/xlibs-libsm.targetinstall

xlibs-libsm_targetinstall_deps = \
	$(STATEDIR)/xlibs-libsm.compile \
	$(STATEDIR)/xlibs-xproto.targetinstall \
	$(STATEDIR)/xlibs-libice.targetinstall

$(STATEDIR)/xlibs-libsm.targetinstall: $(xlibs-libsm_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-libsm)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_LIBSM_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_LIBSM_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-libsm_clean:
	rm -rf $(STATEDIR)/xlibs-libsm.*
	rm -rf $(IMAGEDIR)/xlibs-libsm_*
	rm -rf $(XLIBS_LIBSM_DIR)

# vim: syntax=make
