# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 Ixia Corporation, by Milan Bobde
#		2005-2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBRN) += librn

#
# Paths and names
#
LIBRN_VERSION	:= 0.5.3
LIBRN		:= librn-$(LIBRN_VERSION)
LIBRN_SUFFIX	:= tar.bz2
LIBRN_URL	:= http://www.pengutronix.de/software/librn/download/$(LIBRN).$(LIBRN_SUFFIX)
LIBRN_SOURCE	:= $(SRCDIR)/$(LIBRN).$(LIBRN_SUFFIX)
LIBRN_DIR	:= $(BUILDDIR)/$(LIBRN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

librn_get: $(STATEDIR)/librn.get

$(STATEDIR)/librn.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBRN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBRN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

librn_extract: $(STATEDIR)/librn.extract

$(STATEDIR)/librn.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBRN_DIR))
	@$(call extract, LIBRN)
	@$(call patchin, LIBRN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

librn_prepare: $(STATEDIR)/librn.prepare

LIBRN_PATH	:= PATH=$(CROSS_PATH)
LIBRN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBRN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

$(STATEDIR)/librn.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBRN_DIR)/config.cache)
	cd $(LIBRN_DIR) && \
		$(LIBRN_PATH) $(LIBRN_ENV) \
		./configure $(LIBRN_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

librn_compile: $(STATEDIR)/librn.compile

$(STATEDIR)/librn.compile:
	@$(call targetinfo, $@)
	cd $(LIBRN_DIR) && $(LIBRN_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

librn_install: $(STATEDIR)/librn.install

$(STATEDIR)/librn.install:
	@$(call targetinfo, $@)
	@$(call install, LIBRN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

librn_targetinstall: $(STATEDIR)/librn.targetinstall

$(STATEDIR)/librn.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, librn)
	@$(call install_fixup, librn,PACKAGE,librn)
	@$(call install_fixup, librn,PRIORITY,optional)
	@$(call install_fixup, librn,VERSION,$(LIBRN_VERSION))
	@$(call install_fixup, librn,SECTION,base)
	@$(call install_fixup, librn,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, librn,DEPENDS,)
	@$(call install_fixup, librn,DESCRIPTION,missing)

	@$(call install_copy, librn, 0, 0, 0644, $(LIBRN_DIR)/src/.libs/librn.so.2.0.0, /usr/lib/librn.so.2.0.0)
	@$(call install_link, librn, librn.so.2.0.0, /usr/lib/librn.so.2)
	@$(call install_link, librn, librn.so.2.0.0, /usr/lib/librn.so)

	@$(call install_finish, librn)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

librn_clean:
	rm -rf $(STATEDIR)/librn.*
	rm -rf $(PKGDIR)/librn_*
	rm -rf $(LIBRN_DIR)

# vim: syntax=make
