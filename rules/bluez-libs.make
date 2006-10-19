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
PACKAGES-$(PTXCONF_BLUEZ_LIBS) += bluez-libs

#
# Paths and names
#
BLUEZ_LIBS_VERSION	= 3.7
BLUEZ_LIBS		= bluez-libs-$(BLUEZ_LIBS_VERSION)
BLUEZ_LIBS_SUFFIX	= tar.gz
BLUEZ_LIBS_URL		= http://bluez.sf.net/download/$(BLUEZ_LIBS).$(BLUEZ_LIBS_SUFFIX)
BLUEZ_LIBS_SOURCE	= $(SRCDIR)/$(BLUEZ_LIBS).$(BLUEZ_LIBS_SUFFIX)
BLUEZ_LIBS_DIR		= $(BUILDDIR)/$(BLUEZ_LIBS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bluez-libs_get: $(STATEDIR)/bluez-libs.get

$(STATEDIR)/bluez-libs.get: $(bluez-libs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BLUEZ_LIBS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BLUEZ_LIBS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bluez-libs_extract: $(STATEDIR)/bluez-libs.extract

$(STATEDIR)/bluez-libs.extract: $(bluez-libs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BLUEZ_LIBS_DIR))
	@$(call extract, BLUEZ_LIBS)
	@$(call patchin, BLUEZ_LIBS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bluez-libs_prepare: $(STATEDIR)/bluez-libs.prepare

BLUEZ_LIBS_PATH	=  PATH=$(CROSS_PATH)
BLUEZ_LIBS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
BLUEZ_LIBS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/bluez-libs.prepare: $(bluez-libs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BLUEZ_LIBS_DIR)/config.cache)
	cd $(BLUEZ_LIBS_DIR) && \
		$(BLUEZ_LIBS_PATH) $(BLUEZ_LIBS_ENV) \
		./configure $(BLUEZ_LIBS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bluez-libs_compile: $(STATEDIR)/bluez-libs.compile

$(STATEDIR)/bluez-libs.compile: $(bluez-libs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BLUEZ_LIBS_DIR) && $(BLUEZ_LIBS_ENV) $(BLUEZ_LIBS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bluez-libs_install: $(STATEDIR)/bluez-libs.install

$(STATEDIR)/bluez-libs.install: $(bluez-libs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, BLUEZ_LIBS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bluez-libs_targetinstall: $(STATEDIR)/bluez-libs.targetinstall

$(STATEDIR)/bluez-libs.targetinstall: $(bluez-libs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, bluez-libs)
	@$(call install_fixup, bluez-libs,PACKAGE,bluez-libs)
	@$(call install_fixup, bluez-libs,PRIORITY,optional)
	@$(call install_fixup, bluez-libs,VERSION,$(BLUEZ_LIBS_VERSION))
	@$(call install_fixup, bluez-libs,SECTION,base)
	@$(call install_fixup, bluez-libs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, bluez-libs,DEPENDS,)
	@$(call install_fixup, bluez-libs,DESCRIPTION,missing)

	# FIXME: wait for patch from Sandro Noel
#	@$(call install_copy, bluez-libs, 0, 0, 0755, $(BLUEZ_LIBS_DIR)/foobar, /dev/null)

	@$(call install_finish, bluez-libs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bluez-libs_clean:
	rm -rf $(STATEDIR)/bluez-libs.*
	rm -rf $(IMAGEDIR)/bluez-libs_*
	rm -rf $(BLUEZ_LIBS_DIR)

# vim: syntax=make
