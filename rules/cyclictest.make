# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CYCLICTEST) += cyclictest

#
# Paths and names
#
CYCLICTEST_VERSION	= 0.11
CYCLICTEST		= cyclictest-v$(CYCLICTEST_VERSION)
CYCLICTEST_SUFFIX	= tar.bz2
#
# Note: Top of tree at "http://git.kernel.org/?p=linux/kernel/git/tglx/rt-tests.git;a=summary"
# all other at "http://www.tglx.de/projects/misc/cyclictest/archive/"
#
CYCLICTEST_URL		= http://www.tglx.de/projects/misc/cyclictest/archive/$(CYCLICTEST).$(CYCLICTEST_SUFFIX)
CYCLICTEST_SOURCE	= $(SRCDIR)/$(CYCLICTEST).$(CYCLICTEST_SUFFIX)
CYCLICTEST_DIR		= $(BUILDDIR)/$(CYCLICTEST)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cyclictest_get: $(STATEDIR)/cyclictest.get

$(STATEDIR)/cyclictest.get: $(cyclictest_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CYCLICTEST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CYCLICTEST)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cyclictest_extract: $(STATEDIR)/cyclictest.extract

$(STATEDIR)/cyclictest.extract: $(cyclictest_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CYCLICTEST_DIR))
	@$(call extract, CYCLICTEST)
	# Well, we extract to...
	mv $(BUILDDIR)/cyclictest $(CYCLICTEST_DIR)
	@$(call patchin, CYCLICTEST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cyclictest_prepare: $(STATEDIR)/cyclictest.prepare

CYCLICTEST_PATH	=  PATH=$(CROSS_PATH)
CYCLICTEST_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
#CYCLICTEST_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/cyclictest.prepare: $(cyclictest_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CYCLICTEST_DIR)/config.cache)
#	cd $(CYCLICTEST_DIR) && \
#		$(CYCLICTEST_PATH) $(CYCLICTEST_ENV) \
#		./configure $(CYCLICTEST_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cyclictest_compile: $(STATEDIR)/cyclictest.compile

$(STATEDIR)/cyclictest.compile: $(cyclictest_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CYCLICTEST_DIR) && $(CYCLICTEST_ENV) $(CYCLICTEST_PATH) make CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cyclictest_install: $(STATEDIR)/cyclictest.install

$(STATEDIR)/cyclictest.install: $(cyclictest_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cyclictest_targetinstall: $(STATEDIR)/cyclictest.targetinstall

$(STATEDIR)/cyclictest.targetinstall: $(cyclictest_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, cyclictest)
	@$(call install_fixup, cyclictest,PACKAGE,cyclictest)
	@$(call install_fixup, cyclictest,PRIORITY,optional)
	@$(call install_fixup, cyclictest,VERSION,$(CYCLICTEST_VERSION))
	@$(call install_fixup, cyclictest,SECTION,base)
	@$(call install_fixup, cyclictest,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, cyclictest,DEPENDS,)
	@$(call install_fixup, cyclictest,DESCRIPTION,missing)

	@$(call install_copy, cyclictest, 0, 0, 0755, $(CYCLICTEST_DIR)/cyclictest, /usr/bin/cyclictest)

	@$(call install_finish, cyclictest)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cyclictest_clean:
	rm -rf $(STATEDIR)/cyclictest.*
	rm -rf $(PKGDIR)/cyclictest_*
	rm -rf $(CYCLICTEST_DIR)

# vim: syntax=make
