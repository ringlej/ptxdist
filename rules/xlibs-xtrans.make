# -*-makefile-*-
#
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: do something on targetinstall

#
# We provide this package
#
ifdef PTXCONF_XLIBS-XTRANS
PACKAGES += xlibs-xtrans
endif

#
# Paths and names
#
XLIBS-XTRANS_VERSION	= 0.99.0
XLIBS-XTRANS		= xtrans-$(XLIBS-XTRANS_VERSION)
XLIBS-XTRANS_SUFFIX	= tar.bz2
XLIBS-XTRANS_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS-XTRANS).$(XLIBS-XTRANS_SUFFIX)
XLIBS-XTRANS_SOURCE	= $(SRCDIR)/$(XLIBS-XTRANS).$(XLIBS-XTRANS_SUFFIX)
XLIBS-XTRANS_DIR	= $(BUILDDIR)/$(XLIBS-XTRANS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xtrans_get: $(STATEDIR)/xlibs-xtrans.get

xlibs-xtrans_get_deps = $(XLIBS-XTRANS_SOURCE)

$(STATEDIR)/xlibs-xtrans.get: $(xlibs-xtrans_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-XTRANS))
	$(call touch, $@)

$(XLIBS-XTRANS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XTRANS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xtrans_extract: $(STATEDIR)/xlibs-xtrans.extract

xlibs-xtrans_extract_deps = $(STATEDIR)/xlibs-xtrans.get

$(STATEDIR)/xlibs-xtrans.extract: $(xlibs-xtrans_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XTRANS_DIR))
	@$(call extract, $(XLIBS-XTRANS_SOURCE))
	@$(call patchin, $(XLIBS-XTRANS))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xtrans_prepare: $(STATEDIR)/xlibs-xtrans.prepare

#
# dependencies
#
xlibs-xtrans_prepare_deps = \
	$(STATEDIR)/xlibs-xtrans.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS-XTRANS_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XTRANS_ENV 	=  $(CROSS_ENV)
XLIBS-XTRANS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XTRANS_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xtrans.prepare: $(xlibs-xtrans_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XTRANS_DIR)/config.cache)
	chmod a+x $(XLIBS-XTRANS_DIR)/configure
	cd $(XLIBS-XTRANS_DIR) && \
		$(XLIBS-XTRANS_PATH) $(XLIBS-XTRANS_ENV) \
		./configure $(XLIBS-XTRANS_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xtrans_compile: $(STATEDIR)/xlibs-xtrans.compile

xlibs-xtrans_compile_deps = $(STATEDIR)/xlibs-xtrans.prepare

$(STATEDIR)/xlibs-xtrans.compile: $(xlibs-xtrans_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XTRANS_DIR) && $(XLIBS-XTRANS_ENV) $(XLIBS-XTRANS_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xtrans_install: $(STATEDIR)/xlibs-xtrans.install

$(STATEDIR)/xlibs-xtrans.install: $(STATEDIR)/xlibs-xtrans.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-XTRANS_DIR) && $(XLIBS-XTRANS_ENV) $(XLIBS-XTRANS_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xtrans_targetinstall: $(STATEDIR)/xlibs-xtrans.targetinstall

xlibs-xtrans_targetinstall_deps = $(STATEDIR)/xlibs-xtrans.compile

$(STATEDIR)/xlibs-xtrans.targetinstall: $(xlibs-xtrans_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xtrans_clean:
	rm -rf $(STATEDIR)/xlibs-xtrans.*
	rm -rf $(XLIBS-XTRANS_DIR)

# vim: syntax=make
