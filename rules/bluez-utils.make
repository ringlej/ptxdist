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
BLUEZ_UTILS_VERSION	= 2.24
BLUEZ_UTILS		= bluez-utils-$(BLUEZ_UTILS_VERSION)
BLUEZ_UTILS_SUFFIX	= tar.gz
BLUEZ_UTILS_URL		= http://bluez.sf.net/download/$(BLUEZ_UTILS).$(BLUEZ_UTILS_SUFFIX)
BLUEZ_UTILS_SOURCE	= $(SRCDIR)/$(BLUEZ_UTILS).$(BLUEZ_UTILS_SUFFIX)
BLUEZ_UTILS_DIR		= $(BUILDDIR)/$(BLUEZ_UTILS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bluez-utils_get: $(STATEDIR)/bluez-utils.get

$(STATEDIR)/bluez-utils.get: $(bluez-utils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BLUEZ_UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BLUEZ_UTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bluez-utils_extract: $(STATEDIR)/bluez-utils.extract

$(STATEDIR)/bluez-utils.extract: $(bluez-utils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BLUEZ_UTILS_DIR))
	@$(call extract, $(BLUEZ_UTILS_SOURCE))
	@$(call patchin, $(BLUEZ_UTILS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bluez-utils_prepare: $(STATEDIR)/bluez-utils.prepare

BLUEZ_UTILS_PATH	=  PATH=$(CROSS_PATH)
BLUEZ_UTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
BLUEZ_UTILS_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
BLUEZ_UTILS_AUTOCONF	+= --with-bluez=$(BLUEZ_LIBS_DIR)

# FIXME: these incorrectly pull in /usr/include if selected
# Discuss with mkl what the right upstream solution is and make a patch
BLUEZ_UTILS_AUTOCONF	+= --without-alsa
BLUEZ_UTILS_AUTOCONF	+= --without-fuse
BLUEZ_UTILS_AUTOCONF	+= --without-openobex
BLUEZ_UTILS_AUTOCONF	+= --without-usb

$(STATEDIR)/bluez-utils.prepare: $(bluez-utils_prepare_deps_default)
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

$(STATEDIR)/bluez-utils.compile: $(bluez-utils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BLUEZ_UTILS_DIR) && $(BLUEZ_UTILS_ENV) $(BLUEZ_UTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bluez-utils_install: $(STATEDIR)/bluez-utils.install

$(STATEDIR)/bluez-utils.install: $(bluez-utils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, BLUEZ_UTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bluez-utils_targetinstall: $(STATEDIR)/bluez-utils.targetinstall

$(STATEDIR)/bluez-utils.targetinstall: $(bluez-utils_targetinstall_deps_default)
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
