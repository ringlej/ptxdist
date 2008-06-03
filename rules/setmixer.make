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


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

setmixer_get: $(STATEDIR)/setmixer.get

$(STATEDIR)/setmixer.get: $(setmixer_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SETMIXER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SETMIXER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

setmixer_extract: $(STATEDIR)/setmixer.extract

$(STATEDIR)/setmixer.extract: $(setmixer_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SETMIXER_DIR))
	@$(call extract, SETMIXER)
	@$(call patchin, SETMIXER,$(SETMIXER_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

setmixer_prepare: $(STATEDIR)/setmixer.prepare

SETMIXER_PATH		=  PATH=$(CROSS_PATH)
SETMIXER_ENV 		=  $(CROSS_ENV)
SETMIXER_MAKEVARS	=  CC=$(COMPILER_PREFIX)gcc 

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

$(STATEDIR)/setmixer.install: $(setmixer_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

setmixer_targetinstall: $(STATEDIR)/setmixer.targetinstall

$(STATEDIR)/setmixer.targetinstall: $(setmixer_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, setmixer)
	@$(call install_fixup, setmixer,PACKAGE,setmixer)
	@$(call install_fixup, setmixer,PRIORITY,optional)
	@$(call install_fixup, setmixer,VERSION,$(SETMIXER_VERSION))
	@$(call install_fixup, setmixer,SECTION,base)
	@$(call install_fixup, setmixer,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, setmixer,DEPENDS,)
	@$(call install_fixup, setmixer,DESCRIPTION,missing)
	
	@$(call install_copy, setmixer, 0, 0, 0755, $(SETMIXER_DIR)/setmixer, /usr/bin/setmixer)

	@$(call install_finish, setmixer)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

setmixer_clean:
	rm -rf $(STATEDIR)/setmixer.*
	rm -rf $(PKGDIR)/setmixer_*
	rm -rf $(SETMIXER_DIR)

# vim: syntax=make
