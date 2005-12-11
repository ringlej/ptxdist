# -*-makefile-*-
# $Id: template 3455 2005-11-29 13:22:09Z rsc $
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
PACKAGES-$(PTXCONF_BLUEZ_UTILS) += bluez-utils

#
# Paths and names
#
BLUEZ_UTILS_VERSION	= 2.22
BLUEZ_UTILS		= bluez-utils-$(BLUEZ_UTILS_VERSION)
BLUEZ_UTILS_SUFFIX	= tar.gz
BLUEZ_UTILS_URL		= http://bluez.sf.net/download/$(BLUEZ_UTILS).$(BLUEZ_UTILS_SUFFIX)
BLUEZ_UTILS_SOURCE	= $(SRCDIR)/$(BLUEZ_UTILS).$(BLUEZ_UTILS_SUFFIX)
BLUEZ_UTILS_DIR		= $(BUILDDIR)/$(BLUEZ_UTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bluez-utils_get: $(STATEDIR)/bluez-utils.get

bluez-utils_get_deps = $(BLUEZ_UTILS_SOURCE)

$(STATEDIR)/bluez-utils.get: $(bluez-utils_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BLUEZ_UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BLUEZ_UTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bluez-utils_extract: $(STATEDIR)/bluez-utils.extract

bluez-utils_extract_deps = $(STATEDIR)/bluez-utils.get

$(STATEDIR)/bluez-utils.extract: $(bluez-utils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BLUEZ_UTILS_DIR))
	@$(call extract, $(BLUEZ_UTILS_SOURCE))
	@$(call patchin, $(BLUEZ_UTILS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bluez-utils_prepare: $(STATEDIR)/bluez-utils.prepare

#
# dependencies
#
bluez-utils_prepare_deps = \
	$(STATEDIR)/bluez-utils.extract \
	$(STATEDIR)/bluez-libs.install \
	$(STATEDIR)/virtual-xchain.install

BLUEZ_UTILS_PATH	=  PATH=$(CROSS_PATH)
BLUEZ_UTILS_ENV 	=  $(CROSS_ENV)
BLUEZ_UTILS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
BLUEZ_UTILS_AUTOCONF =  $(CROSS_AUTOCONF)
BLUEZ_UTILS_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/bluez-utils.prepare: $(bluez-utils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BLUEZ_UTILS_DIR)/config.cache)
	cd $(BLUEZ_UTILS_DIR) && \
		$(BLUEZ_UTILS_PATH) $(BLUEZ_UTILS_ENV) \
		./configure $(BLUEZ_UTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bluez-utils_compile: $(STATEDIR)/bluez-utils.compile

bluez-utils_compile_deps = $(STATEDIR)/bluez-utils.prepare

$(STATEDIR)/bluez-utils.compile: $(bluez-utils_compile_deps)
	@$(call targetinfo, $@)
	cd $(BLUEZ_UTILS_DIR) && $(BLUEZ_UTILS_ENV) $(BLUEZ_UTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bluez-utils_install: $(STATEDIR)/bluez-utils.install

$(STATEDIR)/bluez-utils.install: $(STATEDIR)/bluez-utils.compile
	@$(call targetinfo, $@)
	@$(call install, BLUEZ_UTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bluez-utils_targetinstall: $(STATEDIR)/bluez-utils.targetinstall

bluez-utils_targetinstall_deps = \
	$(STATEDIR)/bluez-utils.compile \
	$(STATEDIR)/bluez-libs.targetinstall

$(STATEDIR)/bluez-utils.targetinstall: $(bluez-utils_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,bluez-utils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(BLUEZ_UTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# FIXME: wait for patch from Sandro Noel
#	@$(call install_copy, 0, 0, 0755, $(BLUEZ_UTILS_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bluez-utils_clean:
	rm -rf $(STATEDIR)/bluez-utils.*
	rm -rf $(IMAGEDIR)/bluez-utils_*
	rm -rf $(BLUEZ_UTILS_DIR)

# vim: syntax=make
