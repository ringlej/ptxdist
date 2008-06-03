# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003, 2004 by Marc Kleine-Budde <kleine-budde@gmx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TERMCAP) += termcap

#
# Paths and names
#
TERMCAP_VERSION	= 1.3.1
TERMCAP		= termcap-$(TERMCAP_VERSION)
TERMCAP_SUFFIX	= tar.gz
TERMCAP_URL	= $(PTXCONF_SETUP_GNUMIRROR)/termcap/$(TERMCAP).$(TERMCAP_SUFFIX)
TERMCAP_SOURCE	= $(SRCDIR)/$(TERMCAP).$(TERMCAP_SUFFIX)
TERMCAP_DIR	= $(BUILDDIR)/$(TERMCAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

termcap_get: $(STATEDIR)/termcap.get

$(STATEDIR)/termcap.get: $(termcap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TERMCAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TERMCAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

termcap_extract: $(STATEDIR)/termcap.extract

$(STATEDIR)/termcap.extract: $(termcap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TERMCAP_DIR))
	@$(call extract, TERMCAP)
	@$(call patchin, TERMCAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

termcap_prepare: $(STATEDIR)/termcap.prepare

TERMCAP_PATH	=  PATH=$(CROSS_PATH)
TERMCAP_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
TERMCAP_AUTOCONF =  $(CROSS_AUTOCONF_BROKEN_USR)

$(STATEDIR)/termcap.prepare: $(termcap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TERMCAP_DIR)/config.cache)
	cd $(TERMCAP_DIR) && \
		$(TERMCAP_PATH) $(TERMCAP_ENV) \
		./configure $(TERMCAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

termcap_compile: $(STATEDIR)/termcap.compile

$(STATEDIR)/termcap.compile: $(termcap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(TERMCAP_DIR) && $(TERMCAP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

termcap_install: $(STATEDIR)/termcap.install

$(STATEDIR)/termcap.install: $(termcap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, TERMCAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

termcap_targetinstall: $(STATEDIR)/termcap.targetinstall

$(STATEDIR)/termcap.targetinstall: $(termcap_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, termcap)
	@$(call install_fixup, termcap,PACKAGE,termcap)
	@$(call install_fixup, termcap,PRIORITY,optional)
	@$(call install_fixup, termcap,VERSION,$(TERMCAP_VERSION))
	@$(call install_fixup, termcap,SECTION,base)
	@$(call install_fixup, termcap,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, termcap,DEPENDS,)
	@$(call install_fixup, termcap,DESCRIPTION,missing)
	
ifdef PTXCONF_TERMCAP_TERMCAP
	@$(call install_copy, termcap, 0, 0, 0755, $(TERMCAP_DIR)/termcap.src, /etc/termcap.src,n)
endif
	@$(call install_finish, termcap)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

termcap_clean:
	rm -rf $(STATEDIR)/termcap.*
	rm -rf $(PKGDIR)/termcap_*
	rm -rf $(TERMCAP_DIR)

# vim: syntax=make
