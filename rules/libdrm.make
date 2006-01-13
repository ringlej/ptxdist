# -*-makefile-*-
# $Id: template 3821 2006-01-12 08:09:04Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDRM) += libdrm

#
# Paths and names
#
LIBDRM_VERSION	= 2.0
LIBDRM		= libdrm-$(LIBDRM_VERSION)
LIBDRM_SUFFIX	= tar.gz
LIBDRM_URL	= http://dri.freedesktop.org/libdrm/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_SOURCE	= $(SRCDIR)/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_DIR	= $(BUILDDIR)/$(LIBDRM)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libdrm_get: $(STATEDIR)/libdrm.get

$(STATEDIR)/libdrm.get: $(LIBDRM_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBDRM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBDRM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libdrm_extract: $(STATEDIR)/libdrm.extract

$(STATEDIR)/libdrm.extract: $(libdrm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBDRM_DIR))
	@$(call extract, $(LIBDRM_SOURCE))
	@$(call patchin, $(LIBDRM))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libdrm_prepare: $(STATEDIR)/libdrm.prepare

LIBDRM_PATH	=  PATH=$(CROSS_PATH)
LIBDRM_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBDRM_AUTOCONF =  $(CROSS_AUTOCONF_USR)
LIBDRM_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/libdrm.prepare: $(libdrm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBDRM_DIR)/config.cache)
	cd $(LIBDRM_DIR) && \
		$(LIBDRM_PATH) $(LIBDRM_ENV) \
		./configure $(LIBDRM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libdrm_compile: $(STATEDIR)/libdrm.compile

$(STATEDIR)/libdrm.compile: $(libdrm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBDRM_DIR) && $(LIBDRM_ENV) $(LIBDRM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libdrm_install: $(STATEDIR)/libdrm.install

$(STATEDIR)/libdrm.install: $(STATEDIR)/libdrm.compile
	@$(call targetinfo, $@)
	@$(call install, LIBDRM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libdrm_targetinstall: $(STATEDIR)/libdrm.targetinstall

$(STATEDIR)/libdrm.targetinstall: $(libdrm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libdrm)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBDRM_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(LIBDRM_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libdrm_clean:
	rm -rf $(STATEDIR)/libdrm.*
	rm -rf $(IMAGEDIR)/libdrm_*
	rm -rf $(LIBDRM_DIR)

# vim: syntax=make
