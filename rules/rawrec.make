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


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rawrec_get: $(STATEDIR)/rawrec.get

$(STATEDIR)/rawrec.get: $(rawrec_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(RAWREC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, RAWREC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rawrec_extract: $(STATEDIR)/rawrec.extract

$(STATEDIR)/rawrec.extract: $(rawrec_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(RAWREC_DIR))
	@$(call extract, RAWREC)
	@$(call patchin, RAWREC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rawrec_prepare: $(STATEDIR)/rawrec.prepare

RAWREC_PATH	=  PATH=$(CROSS_PATH)
RAWREC_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
RAWREC_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/rawrec.prepare: $(rawrec_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rawrec_compile: $(STATEDIR)/rawrec.compile

# CC=$(CROSS_CC) to override Makefile's "CC = gcc"
$(STATEDIR)/rawrec.compile: $(rawrec_compile_deps_default)
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

$(STATEDIR)/rawrec.install: $(rawrec_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rawrec_targetinstall: $(STATEDIR)/rawrec.targetinstall

$(STATEDIR)/rawrec.targetinstall: $(rawrec_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, rawrec)
	@$(call install_fixup, rawrec,PACKAGE,rawrec)
	@$(call install_fixup, rawrec,PRIORITY,optional)
	@$(call install_fixup, rawrec,VERSION,$(RAWREC_VERSION))
	@$(call install_fixup, rawrec,SECTION,base)
	@$(call install_fixup, rawrec,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, rawrec,DEPENDS,)
	@$(call install_fixup, rawrec,DESCRIPTION,missing)

ifdef PTXCONF_RAWREC_RAWREC
	@$(call install_copy, rawrec, 0, 0, 0755, $(RAWREC_DIR)/src/rawrec, /usr/bin/rawrec)
endif
ifdef PTXCONF_RAWREC_RAWPLAY
	@$(call install_copy, rawrec, 0, 0, 0755, $(RAWREC_DIR)/src/rawplay, /usr/bin/rawplay)
endif
	@$(call install_finish, rawrec)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rawrec_clean:
	rm -rf $(STATEDIR)/rawrec.*
	rm -rf $(PKGDIR)/rawrec_*
	rm -rf $(RAWREC_DIR)

# vim: syntax=make
