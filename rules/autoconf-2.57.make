# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# RSC: FIXME: make this a hosttool 

#
# We provide this package
#
#PACKAGES += autoconf257

#
# Paths and names 
#
AUTOCONF257			= autoconf-2.57
AUTOCONF257_URL			= $(PTXCONF_SETUP_GNUMIRROR)/autoconf/$(AUTOCONF257).tar.gz
AUTOCONF257_SOURCE		= $(SRCDIR)/$(AUTOCONF257).tar.gz
AUTOCONF257_DIR			= $(BUILDDIR)/$(AUTOCONF257)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

autoconf257_get: $(STATEDIR)/autoconf257.get

$(STATEDIR)/autoconf257.get: $(AUTOCONF257_SOURCE)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(AUTOCONF257_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(AUTOCONF257_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

autoconf257_extract: $(STATEDIR)/autoconf257.extract

$(STATEDIR)/autoconf257.extract: $(STATEDIR)/autoconf257.get
	@$(call targetinfo, $@)
	@$(call clean, $(AUTOCONF257_DIR))
	@$(call extract, $(AUTOCONF257_SOURCE))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

autoconf257_prepare: $(STATEDIR)/autoconf257.prepare

AUTOCONF257_ENV = $(HOSTCC_ENV)

$(STATEDIR)/autoconf257.prepare: $(STATEDIR)/autoconf257.extract
	@$(call targetinfo, $@)
	cd $(AUTOCONF257_DIR) && \
		$(AUTOCONF257_ENV) \
		./configure --prefix=$(PTXCONF_PREFIX)/$(AUTOCONF257)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

autoconf257_compile: $(STATEDIR)/autoconf257.compile

$(STATEDIR)/autoconf257.compile: $(STATEDIR)/autoconf257.prepare 
	@$(call targetinfo, $@)
	make -C $(AUTOCONF257_DIR)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

autoconf257_install: $(STATEDIR)/autoconf257.install

$(STATEDIR)/autoconf257.install: $(STATEDIR)/autoconf257.compile
	@$(call targetinfo, $@)
	make -C $(AUTOCONF257_DIR) install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

autoconf257_targetinstall: $(STATEDIR)/autoconf257.targetinstall

$(STATEDIR)/autoconf257.targetinstall: $(STATEDIR)/autoconf257.install
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

autoconf257_clean: 
	rm -rf $(STATEDIR)/autoconf257.* $(AUTOCONF257_DIR)

# vim: syntax=make
