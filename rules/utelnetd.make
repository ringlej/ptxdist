# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_UTELNETD
PACKAGES += utelnetd
endif

#
# Paths and names 
#
UTELNETD_VERSION		= 0.1.6
UTELNETD			= utelnetd-$(UTELNETD_VERSION)
UTELNETD_URL			= http://www.pengutronix.de/software/utelnetd/$(UTELNETD).tar.gz
UTELNETD_SOURCE			= $(SRCDIR)/$(UTELNETD).tar.gz
UTELNETD_DIR			= $(BUILDDIR)/$(UTELNETD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

utelnetd_get: $(STATEDIR)/utelnetd.get

$(STATEDIR)/utelnetd.get: $(UTELNETD_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(UTELNETD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(UTELNETD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

utelnetd_extract: $(STATEDIR)/utelnetd.extract

$(STATEDIR)/utelnetd.extract: $(STATEDIR)/utelnetd.get
	@$(call targetinfo, $@)
	@$(call clean, $(UTELNETS_DIR))
	@$(call extract, $(UTELNETD_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

utelnetd_prepare: $(STATEDIR)/utelnetd.prepare

utelnetd_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/utelnetd.extract

$(STATEDIR)/utelnetd.prepare: $(utelnetd_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

utelnetd_compile: $(STATEDIR)/utelnetd.compile

UTELNETD_ENVIRONMENT += PATH=$(CROSS_PATH)
UTELNETD_MAKEVARS    += CROSS=$(COMPILER_PREFIX)

$(STATEDIR)/utelnetd.compile: $(STATEDIR)/utelnetd.prepare 
	@$(call targetinfo, $@)
	$(UTELNETD_ENVIRONMENT) make -C $(UTELNETD_DIR) $(UTELNETD_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

utelnetd_install: $(STATEDIR)/utelnetd.install

$(STATEDIR)/utelnetd.install: $(STATEDIR)/utelnetd.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

utelnetd_targetinstall: $(STATEDIR)/utelnetd.targetinstall

$(STATEDIR)/utelnetd.targetinstall: $(STATEDIR)/utelnetd.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,utelnetd)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(UTELNETD_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(UTELNETD_DIR)/utelnetd, /sbin/utelnetd)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

utelnetd_clean: 
	rm -rf $(STATEDIR)/utelnetd.* $(UTELNETD_DIR)

# vim: syntax=make
