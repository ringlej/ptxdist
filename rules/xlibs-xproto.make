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
PACKAGES-$(PTXCONF_XLIBS-XPROTO) += xlibs-xproto

#
# Paths and names
#
XLIBS-XPROTO_VERSION	= 20041103-1
XLIBS-XPROTO		= Xproto-$(XLIBS-XPROTO_VERSION)
XLIBS-XPROTO_SUFFIX	= tar.bz2
XLIBS-XPROTO_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-XPROTO).$(XLIBS-XPROTO_SUFFIX)
XLIBS-XPROTO_SOURCE	= $(SRCDIR)/$(XLIBS-XPROTO).$(XLIBS-XPROTO_SUFFIX)
XLIBS-XPROTO_DIR	= $(BUILDDIR)/$(XLIBS-XPROTO)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xproto_get: $(STATEDIR)/xlibs-xproto.get

xlibs-xproto_get_deps = $(XLIBS-XPROTO_SOURCE)

$(STATEDIR)/xlibs-xproto.get: $(xlibs-xproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-XPROTO))
	@$(call touch, $@)

$(XLIBS-XPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xproto_extract: $(STATEDIR)/xlibs-xproto.extract

xlibs-xproto_extract_deps = $(STATEDIR)/xlibs-xproto.get

$(STATEDIR)/xlibs-xproto.extract: $(xlibs-xproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XPROTO_DIR))
	@$(call extract, $(XLIBS-XPROTO_SOURCE))
	@$(call patchin, $(XLIBS-XPROTO))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xproto_prepare: $(STATEDIR)/xlibs-xproto.prepare

#
# dependencies
#
xlibs-xproto_prepare_deps =  $(STATEDIR)/xlibs-xproto.extract
xlibs-xproto_prepare_deps += $(STATEDIR)/virtual-xchain.install

XLIBS-XPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XPROTO_ENV 	=  $(CROSS_ENV)
XLIBS-XPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XPROTO_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/xlibs-xproto.prepare: $(xlibs-xproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XPROTO_DIR)/config.cache)
	chmod a+x $(XLIBS-XPROTO_DIR)/configure
	cd $(XLIBS-XPROTO_DIR) && \
		$(XLIBS-XPROTO_PATH) $(XLIBS-XPROTO_ENV) \
		./configure $(XLIBS-XPROTO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xproto_compile: $(STATEDIR)/xlibs-xproto.compile

xlibs-xproto_compile_deps = $(STATEDIR)/xlibs-xproto.prepare

$(STATEDIR)/xlibs-xproto.compile: $(xlibs-xproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XPROTO_DIR) && $(XLIBS-XPROTO_ENV) $(XLIBS-XPROTO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xproto_install: $(STATEDIR)/xlibs-xproto.install

$(STATEDIR)/xlibs-xproto.install: $(STATEDIR)/xlibs-xproto.compile
	@$(call targetinfo, $@)
	@$(call install, XLIBS-XPROTO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xproto_targetinstall: $(STATEDIR)/xlibs-xproto.targetinstall

xlibs-xproto_targetinstall_deps = $(STATEDIR)/xlibs-xproto.compile

$(STATEDIR)/xlibs-xproto.targetinstall: $(xlibs-xproto_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xproto_clean:
	rm -rf $(STATEDIR)/xlibs-xproto.*
	rm -rf $(XLIBS-XPROTO_DIR)

# vim: syntax=make
