# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: do someting on targetinstall 

#
# We provide this package
#
PACKAGES-$(PTXCONF_TINYLOGIN) += tinylogin

#
# Paths and names 
#
TINYLOGIN_VERSION	= 1.4
TINYLOGIN		= tinylogin-$(TINYLOGIN_VERSION).tar.bz2
TINYLOGIN_URL		= http://tinylogin.busybox.net/downloads/$(TINYLOGIN)
TINYLOGIN_SOURCE	= $(SRCDIR)/$(TINYLOGIN).tar.bz2
TINYLOGIN_DIR		= $(BUILDDIR)/$(TINYLOGIN)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tinylogin_get: $(STATEDIR)/tinylogin.get

$(STATEDIR)/tinylogin.get: $(tinylogin_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TINYLOGIN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TINYLOGIN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tinylogin_extract: $(STATEDIR)/tinylogin.extract

$(STATEDIR)/tinylogin.extract: $(tinylogin_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TINYLOGIN_DIR))
	@$(call extract, TINYLOGIN)
	@$(call patchin, TINYLOGIN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tinylogin_prepare: $(STATEDIR)/tinylogin.prepare

TINYLOGIN_PATH	 = PATH=$(CROSS_PATH)
TINYLOGIN_MAKEVARS = CROSS=$(PTXCONF_GNU_TARGET)-

$(STATEDIR)/tinylogin.prepare: $(tinylogin_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tinylogin_compile: $(STATEDIR)/tinylogin.compile

$(STATEDIR)/tinylogin.compile: $(tinylogin_compile_deps_default) 
	@$(call targetinfo, $@)
	cd $(TINYLOGIN_DIR) && $(TINYLOGIN_PATH) make $(TINYLOGIN_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tinylogin_install: $(STATEDIR)/tinylogin.install

$(STATEDIR)/tinylogin.install: $(tinylogin_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tinylogin_targetinstall: $(STATEDIR)/tinylogin.targetinstall

$(STATEDIR)/tinylogin.targetinstall: $(tinylogin_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tinylogin_clean:
	rm -rf $(STATEDIR)/tinylogin.*
	rm -rf $(IMAGEDIR)/tinylogin_*
	rm -rf $(TINYLOGIN_DIR)

# vim: syntax=make
