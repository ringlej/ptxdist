# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
#
# Copyright (C) 2005 by Christian Gagneraud <chgans@gna.org>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RAWREC) += rawrec

#
# Paths and names
#
RAWREC_VERSION		= 0.9.98
RAWREC			= rawrec-$(RAWREC_VERSION)
RAWREC_SUFFIX		= tar.gz
RAWREC_URL		= $(PTXCONF_SETUP_SFMIRROR)/rawrec/$(RAWREC).$(RAWREC_SUFFIX)
RAWREC_SOURCE		= $(SRCDIR)/$(RAWREC).$(RAWREC_SUFFIX)
RAWREC_DIR		= $(BUILDDIR)/$(RAWREC)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rawrec_get: $(STATEDIR)/rawrec.get

rawrec_get_deps = $(RAWREC_SOURCE)

$(STATEDIR)/rawrec.get: $(rawrec_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(RAWREC))
	@$(call touch, $@)

$(RAWREC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(RAWREC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rawrec_extract: $(STATEDIR)/rawrec.extract

rawrec_extract_deps = $(STATEDIR)/rawrec.get

$(STATEDIR)/rawrec.extract: $(rawrec_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(RAWREC_DIR))
	@$(call extract, $(RAWREC_SOURCE))
	@$(call patchin, $(RAWREC))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rawrec_prepare: $(STATEDIR)/rawrec.prepare

#
# dependencies
#
rawrec_prepare_deps = \
	$(STATEDIR)/rawrec.extract \
	$(STATEDIR)/virtual-xchain.install

RAWREC_PATH	=  PATH=$(CROSS_PATH)
RAWREC_ENV 	=  $(CROSS_ENV)
#RAWREC_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#RAWREC_ENV	+=

#
# autoconf
#
RAWREC_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/rawrec.prepare: $(rawrec_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rawrec_compile: $(STATEDIR)/rawrec.compile

rawrec_compile_deps = $(STATEDIR)/rawrec.prepare

# CC=$(CROSS_CC) to override Makefile's "CC = gcc"
$(STATEDIR)/rawrec.compile: $(rawrec_compile_deps)
	@$(call targetinfo, $@)
ifdef PTXCONF_RAWREC_RAWREC
	cd $(RAWREC_DIR)/src && $(RAWREC_ENV) $(RAWREC_PATH) make CC=$(CROSS_CC) rawrec
endif
ifdef PTXCONF_RAWREC_RAWPLAY
	cd $(RAWREC_DIR)/src && $(RAWREC_ENV) $(RAWREC_PATH) make CC=$(CROSS_CC) rawplay
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rawrec_install: $(STATEDIR)/rawrec.install

$(STATEDIR)/rawrec.install: $(STATEDIR)/rawrec.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rawrec_targetinstall: $(STATEDIR)/rawrec.targetinstall

rawrec_targetinstall_deps = $(STATEDIR)/rawrec.compile

$(STATEDIR)/rawrec.targetinstall: $(rawrec_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,rawrec)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(RAWREC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_RAWREC_RAWREC
	@$(call install_copy, 0, 0, 0755, $(RAWREC_DIR)/src/rawrec, /usr/bin/rawrec)
endif
ifdef PTXCONF_RAWREC_RAWPLAY
	@$(call install_copy, 0, 0, 0755, $(RAWREC_DIR)/src/rawplay, /usr/bin/rawplay)
endif
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rawrec_clean:
	rm -rf $(STATEDIR)/rawrec.*
	rm -rf $(IMAGEDIR)/rawrec_*
	rm -rf $(RAWREC_DIR)

# vim: syntax=make
