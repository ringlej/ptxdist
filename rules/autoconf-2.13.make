# -*-makefile-*-
# $Id: autoconf-2.13.make,v 1.4 2003/07/16 20:05:17 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
#PACKAGES += autoconf213

#
# Paths and names 
#
AUTOCONF213			= autoconf-2.13
AUTOCONF213_URL			= ftp://ftp.gnu.org/pub/gnu/autoconf/$(AUTOCONF213).tar.gz
AUTOCONF213_SOURCE		= $(SRCDIR)/$(AUTOCONF213).tar.gz
AUTOCONF213_DIR			= $(BUILDDIR)/$(AUTOCONF213)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

autoconf213_get: $(STATEDIR)/autoconf213.get

$(STATEDIR)/autoconf213.get: $(AUTOCONF213_SOURCE)
	@$(call targetinfo, autoconf213.get)
	touch $@

$(AUTOCONF213_SOURCE):
	@$(call targetinfo, $(AUTOCONF213_SOURCE))
	@$(call get, $(AUTOCONF213_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

autoconf213_extract: $(STATEDIR)/autoconf213.extract

$(STATEDIR)/autoconf213.extract: $(STATEDIR)/autoconf213.get
	@$(call targetinfo, autoconf213.extract)
	@$(call clean, $(AUTOCONF213_DIR))
	@$(call extract, $(AUTOCONF213_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

autoconf213_prepare: $(STATEDIR)/autoconf213.prepare

AUTOCONF213_ENV = $(HOSTCC_ENV)

$(STATEDIR)/autoconf213.prepare: $(STATEDIR)/autoconf213.extract
	@$(call targetinfo, autoconf213.prepare)
	cd $(AUTOCONF213_DIR) && \
		$(AUTOCONF213_ENV) \
		./configure --prefix=$(PTXCONF_PREFIX)/$(AUTOCONF213)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

autoconf213_compile: $(STATEDIR)/autoconf213.compile

$(STATEDIR)/autoconf213.compile: $(STATEDIR)/autoconf213.prepare 
	@$(call targetinfo, autoconf213.compile)
	make -C $(AUTOCONF213_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

autoconf213_install: $(STATEDIR)/autoconf213.install

$(STATEDIR)/autoconf213.install: $(STATEDIR)/autoconf213.compile
	@$(call targetinfo, autoconf213.install)
	make -C $(AUTOCONF213_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

autoconf213_targetinstall: $(STATEDIR)/autoconf213.compile

$(STATEDIR)/autoconf213.targetinstall: $(STATEDIR)/autoconf213.install
	@$(call targetinfo, autoconf213.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

autoconf213_clean: 
	rm -rf $(STATEDIR)/autoconf213.* $(AUTOCONF213_DIR)

# vim: syntax=make
