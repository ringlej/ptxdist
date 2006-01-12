# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Sascha Hauer <sascha.hauer@gyro-net.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SETMIXER) += setmixer

#
# Paths and names
#
SETMIXER_VERSION	= 27DEC94ds1
SETMIXER		= setmixer_$(SETMIXER_VERSION).orig
SETMIXER_SUFFIX		= tar.gz
SETMIXER_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/s/setmixer/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_SOURCE		= $(SRCDIR)/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_DIR		= $(BUILDDIR)/setmixer-27DEC94ds1.orig

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

setmixer_get: $(STATEDIR)/setmixer.get

$(STATEDIR)/setmixer.get: $(SETMIXER_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SETMIXER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SETMIXER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

setmixer_extract: $(STATEDIR)/setmixer.extract

$(STATEDIR)/setmixer.extract: $(setmixer_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SETMIXER_DIR))
	@$(call extract, $(SETMIXER_SOURCE))
	@$(call patchin, $(SETMIXER),$(SETMIXER_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

setmixer_prepare: $(STATEDIR)/setmixer.prepare

SETMIXER_PATH		=  PATH=$(CROSS_PATH)
SETMIXER_ENV 		=  $(CROSS_ENV)
SETMIXER_MAKEVARS	=  CC=$(PTXCONF_GNU_TARGET)-gcc 

$(STATEDIR)/setmixer.prepare: $(setmixer_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SETMIXER_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

setmixer_compile: $(STATEDIR)/setmixer.compile

$(STATEDIR)/setmixer.compile: $(setmixer_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SETMIXER_DIR) && \
		$(SETMIXER_ENV) $(SETMIXER_PATH) make $(SETMIXER_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

setmixer_install: $(STATEDIR)/setmixer.install

$(STATEDIR)/setmixer.install: $(STATEDIR)/setmixer.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

setmixer_targetinstall: $(STATEDIR)/setmixer.targetinstall

$(STATEDIR)/setmixer.targetinstall: $(setmixer_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,setmixer)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SETMIXER_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(SETMIXER_DIR)/setmixer, /usr/bin/setmixer)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

setmixer_clean:
	rm -rf $(STATEDIR)/setmixer.*
	rm -rf $(IMAGEDIR)/setmixer_*
	rm -rf $(SETMIXER_DIR)

# vim: syntax=make
