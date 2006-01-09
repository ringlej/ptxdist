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
TINYLOGIN_URL		= http://tinylogin.busybox.net/downloads/$(TINYLOGIN).tar.bz2
TINYLOGIN_SOURCE	= $(SRCDIR)/$(TINYLOGIN).tar.bz2
TINYLOGIN_DIR		= $(BUILDDIR)/$(TINYLOGIN)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tinylogin_get: $(STATEDIR)/tinylogin.get

tinylogin_get_deps =  $(TINYLOGIN_SOURCE)

$(STATEDIR)/tinylogin.get: $(tinylogin_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TINYLOGIN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TINYLOGIN_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tinylogin_extract: $(STATEDIR)/tinylogin.extract

$(STATEDIR)/tinylogin.extract: $(STATEDIR)/tinylogin.get
	@$(call targetinfo, $@)
	@$(call clean, $(TINYLOGIN_DIR))
	@$(call extract, $(TINYLOGIN_SOURCE))
	@$(call patchin, $(TINYLOGIN))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tinylogin_prepare: $(STATEDIR)/tinylogin.prepare

TINYLOGIN_PATH	 = PATH=$(CROSS_PATH)
TINYLOGIN_MAKEVARS = CROSS=$(PTXCONF_GNU_TARGET)-

#
# dependencies
#
tinylogin_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/tinylogin.extract

$(STATEDIR)/tinylogin.prepare: $(tinylogin_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tinylogin_compile: $(STATEDIR)/tinylogin.compile

tinylogin_compile_deps =  $(STATEDIR)/tinylogin.prepare

$(STATEDIR)/tinylogin.compile: $(tinylogin_compile_deps) 
	@$(call targetinfo, $@)
	cd $(TINYLOGIN_DIR) && $(TINYLOGIN_PATH) make $(TINYLOGIN_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tinylogin_install: $(STATEDIR)/tinylogin.install

$(STATEDIR)/tinylogin.install: $(STATEDIR)/tinylogin.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tinylogin_targetinstall: $(STATEDIR)/tinylogin.targetinstall

$(STATEDIR)/tinylogin.targetinstall: $(STATEDIR)/tinylogin.install
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
