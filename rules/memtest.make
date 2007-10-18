# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMTEST) += memtest

#
# Paths and names
#
MEMTEST_VERSION		= 0.0.4
MEMTEST			= memtest-$(MEMTEST_VERSION)
MEMTEST_SUFFIX		= tar.bz2
MEMTEST_URL		= http://carpanta.dc.fi.udc.es/~quintela/memtest/$(MEMTEST).$(MEMTEST_SUFFIX)
MEMTEST_SOURCE		= $(SRCDIR)/$(MEMTEST).$(MEMTEST_SUFFIX)
MEMTEST_DIR		= $(BUILDDIR)/$(MEMTEST)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

memtest_get: $(STATEDIR)/memtest.get

$(STATEDIR)/memtest.get: $(memtest_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MEMTEST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MEMTEST)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

memtest_extract: $(STATEDIR)/memtest.extract

$(STATEDIR)/memtest.extract: $(memtest_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMTEST_DIR))
	@$(call extract, MEMTEST)
	@$(call patchin, MEMTEST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

memtest_prepare: $(STATEDIR)/memtest.prepare

MEMTEST_PATH	=  PATH=$(CROSS_PATH)
MEMTEST_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MEMTEST_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/memtest.prepare: $(memtest_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMTEST_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

memtest_compile: $(STATEDIR)/memtest.compile

$(STATEDIR)/memtest.compile: $(memtest_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MEMTEST_DIR) && $(MEMTEST_ENV) $(MEMTEST_PATH) make mtest
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

memtest_install: $(STATEDIR)/memtest.install

$(STATEDIR)/memtest.install: $(memtest_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

memtest_targetinstall: $(STATEDIR)/memtest.targetinstall

$(STATEDIR)/memtest.targetinstall: $(memtest_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, memtest)
	@$(call install_fixup, memtest,PACKAGE,memtest)
	@$(call install_fixup, memtest,PRIORITY,optional)
	@$(call install_fixup, memtest,VERSION,$(MEMTEST_VERSION))
	@$(call install_fixup, memtest,SECTION,base)
	@$(call install_fixup, memtest,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, memtest,DEPENDS,)
	@$(call install_fixup, memtest,DESCRIPTION,missing)

	@$(call install_copy, memtest, 0, 0, 0755, $(MEMTEST_DIR)/mtest, /usr/sbin/memtest)

	@$(call install_finish, memtest)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

memtest_clean:
	rm -rf $(STATEDIR)/memtest.*
	rm -rf $(IMAGEDIR)/memtest_*
	rm -rf $(MEMTEST_DIR)

# vim: syntax=make
