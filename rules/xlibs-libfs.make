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
ifdef PTXCONF_XLIBS_LIBFS
PACKAGES += xlibs-libfs
endif

#
# Paths and names
#
XLIBS_LIBFS_VERSION	= 0.99.0
XLIBS_LIBFS		= libFS-$(XLIBS_LIBFS_VERSION)
XLIBS_LIBFS_SUFFIX	= tar.bz2
XLIBS_LIBFS_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_LIBFS).$(XLIBS_LIBFS_SUFFIX)
XLIBS_LIBFS_SOURCE	= $(SRCDIR)/$(XLIBS_LIBFS).$(XLIBS_LIBFS_SUFFIX)
XLIBS_LIBFS_DIR		= $(BUILDDIR)/$(XLIBS_LIBFS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-libfs_get: $(STATEDIR)/xlibs-libfs.get

xlibs-libfs_get_deps = $(XLIBS_LIBFS_SOURCE)

$(STATEDIR)/xlibs-libfs.get: $(xlibs-libfs_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_LIBFS))
	$(call touch, $@)

$(XLIBS_LIBFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_LIBFS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-libfs_extract: $(STATEDIR)/xlibs-libfs.extract

xlibs-libfs_extract_deps = $(STATEDIR)/xlibs-libfs.get

$(STATEDIR)/xlibs-libfs.extract: $(xlibs-libfs_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_LIBFS_DIR))
	@$(call extract, $(XLIBS_LIBFS_SOURCE))
	@$(call patchin, $(XLIBS_LIBFS))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-libfs_prepare: $(STATEDIR)/xlibs-libfs.prepare

#
# dependencies
#
xlibs-libfs_prepare_deps = \
	$(STATEDIR)/xlibs-libfs.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/xlibs-xproto.install \
	$(STATEDIR)/xlibs-xtrans.install \
	$(STATEDIR)/xlibs-fontsproto.install

XLIBS_LIBFS_PATH	=  PATH=$(CROSS_PATH)
XLIBS_LIBFS_ENV 	=  $(CROSS_ENV)
XLIBS_LIBFS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_LIBFS_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_LIBFS_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-libfs.prepare: $(xlibs-libfs_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_LIBFS_DIR)/config.cache)
	cd $(XLIBS_LIBFS_DIR) && \
		$(XLIBS_LIBFS_PATH) $(XLIBS_LIBFS_ENV) \
		./configure $(XLIBS_LIBFS_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-libfs_compile: $(STATEDIR)/xlibs-libfs.compile

xlibs-libfs_compile_deps = $(STATEDIR)/xlibs-libfs.prepare

$(STATEDIR)/xlibs-libfs.compile: $(xlibs-libfs_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_LIBFS_DIR) && $(XLIBS_LIBFS_ENV) $(XLIBS_LIBFS_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-libfs_install: $(STATEDIR)/xlibs-libfs.install

$(STATEDIR)/xlibs-libfs.install: $(STATEDIR)/xlibs-libfs.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_LIBFS_DIR) && $(XLIBS_LIBFS_ENV) $(XLIBS_LIBFS_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-libfs_targetinstall: $(STATEDIR)/xlibs-libfs.targetinstall

xlibs-libfs_targetinstall_deps = \
	$(STATEDIR)/xlibs-libfs.compile \
	$(STATEDIR)/xlibs-xproto.targetinstall \
	$(STATEDIR)/xlibs-xtrans.targetinstall \
	$(STATEDIR)/xlibs-fontsproto.targetinstall

$(STATEDIR)/xlibs-libfs.targetinstall: $(xlibs-libfs_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-libfs)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_LIBFS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_LIBFS_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-libfs_clean:
	rm -rf $(STATEDIR)/xlibs-libfs.*
	rm -rf $(IMAGEDIR)/xlibs-libfs_*
	rm -rf $(XLIBS_LIBFS_DIR)

# vim: syntax=make
