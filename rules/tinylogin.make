# -*-makefile-*-
# $Id: tinylogin.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_TINYLOGIN
PACKAGES += tinylogin
endif

#
# Paths and names 
#
TINYLOGIN		= tinylogin-1.4.tar.bz2
TINYLOGIN_URL		= http://tinylogin.busybox.net/downloads/$(TINYLOGIN).tar.bz2
TINYLOGIN_SOURCE	= $(SRCDIR)/$(TINYLOGIN).tar.bz2
TINYLOGIN_DIR		= $(BUILDDIR)/$(TINYLOGIN)
TINYLOGIN_EXTRACT 	= bzip2 -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tinylogin_get: $(STATEDIR)/tinylogin.get

tinylogin_get_deps =  $(TINYLOGIN_SOURCE)

$(STATEDIR)/tinylogin.get: $(tinylogin_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(TINYLOGIN_SOURCE):
	@$(call targetinfo, $@)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(TINYLOGIN_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tinylogin_extract: $(STATEDIR)/tinylogin.extract

$(STATEDIR)/tinylogin.extract: $(STATEDIR)/tinylogin.get
	@$(call targetinfo, $@)
	$(TINYLOGIN_EXTRACT) $(TINYLOGIN_SOURCE) | tar -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tinylogin_prepare: $(STATEDIR)/tinylogin.prepare

TINYLOGIN_PATH	 = PATH=$(CROSS_PATH)
TINYLOGIN_MAKEVARS = CROSS=$(PTXCONF_GNU_TARGET)-

#
# dependencies
#
tinylogin_prepare_deps =  $(STATEDIR)/tinylogin.extract $(STATEDIR)/virtual-xchain.install

$(STATEDIR)/tinylogin.prepare: $(tinylogin_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tinylogin_compile: $(STATEDIR)/tinylogin.compile

tinylogin_compile_deps =  $(STATEDIR)/tinylogin.prepare

$(STATEDIR)/tinylogin.compile: $(tinylogin_compile_deps) 
	@$(call targetinfo, $@)
	$(TINYLOGIN_PATH) make -C $(TINYLOGIN_DIR) $(TINYLOGIN_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tinylogin_install: $(STATEDIR)/tinylogin.install

$(STATEDIR)/tinylogin.install: $(STATEDIR)/tinylogin.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tinylogin_targetinstall: $(STATEDIR)/tinylogin.targetinstall

$(STATEDIR)/tinylogin.targetinstall: $(STATEDIR)/tinylogin.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tinylogin_clean:
	-rm -rf $(STATEDIR)/tinylogin*
	-rm -rf $(TINYLOGIN_DIR)

# vim: syntax=make