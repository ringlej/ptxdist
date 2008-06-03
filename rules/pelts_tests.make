# -*-makefile-*-
# $Id: template 5709 2006-06-09 13:55:00Z mkl $
#
# Copyright (C) 2006 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PELTS_TESTS) += pelts-tests

#
# Paths and names
#
PELTS_TESTS_VERSION	:= 0.0.1
PELTS_TESTS		:= pelts_tests-$(PELTS_TESTS_VERSION)
PELTS_TESTS_SUFFIX	:= tar.bz2
PELTS_TESTS_URL		:= http://www.pengutronix.de/software/pelts/download/utils/$(PELTS_TESTS).$(PELTS_TESTS_SUFFIX)
PELTS_TESTS_SOURCE	:= $(SRCDIR)/$(PELTS_TESTS).$(PELTS_TESTS_SUFFIX)
PELTS_TESTS_DIR		:= $(BUILDDIR)/$(PELTS_TESTS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pelts-tests_get: $(STATEDIR)/pelts-tests.get

$(STATEDIR)/pelts-tests.get: $(pelts-tests_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PELTS_TESTS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PELTS_TESTS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pelts-tests_extract: $(STATEDIR)/pelts-tests.extract

$(STATEDIR)/pelts-tests.extract: $(pelts-tests_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PELTS_TESTS_DIR))
	@$(call extract, PELTS_TESTS)
	@$(call patchin, PELTS_TESTS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pelts-tests_prepare: $(STATEDIR)/pelts-tests.prepare

PELTS_TESTS_PATH	:=  PATH=$(CROSS_PATH)
PELTS_TESTS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
PELTS_TESTS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/pelts-tests.prepare: $(pelts-tests_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PELTS_TESTS_DIR)/config.cache)
	cd $(PELTS_TESTS_DIR) && \
		$(PELTS_TESTS_PATH) $(PELTS_TESTS_ENV) \
		./configure $(PELTS_TESTS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pelts-tests_compile: $(STATEDIR)/pelts-tests.compile

$(STATEDIR)/pelts-tests.compile: $(pelts-tests_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PELTS_TESTS_DIR) && $(PELTS_TESTS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pelts-tests_install: $(STATEDIR)/pelts-tests.install

$(STATEDIR)/pelts-tests.install: $(pelts-tests_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pelts-tests_targetinstall: $(STATEDIR)/pelts-tests.targetinstall

$(STATEDIR)/pelts-tests.targetinstall: $(pelts-tests_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pelts-tests)
	@$(call install_fixup,pelts-tests,PACKAGE,pelts-tests)
	@$(call install_fixup,pelts-tests,PRIORITY,optional)
	@$(call install_fixup,pelts-tests,VERSION,$(PELTS_TESTS_VERSION))
	@$(call install_fixup,pelts-tests,SECTION,base)
	@$(call install_fixup,pelts-tests,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pelts-tests,DEPENDS,)
	@$(call install_fixup,pelts-tests,DESCRIPTION,missing)

	@$(call install_copy, pelts-tests, 0, 0, 0755, $(PELTS_TESTS_DIR)/src/floattest, /usr/bin/floattest)

	@$(call install_finish,pelts-tests)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pelts-tests_clean:
	rm -rf $(STATEDIR)/pelts-tests.*
	rm -rf $(PKGDIR)/pelts-tests_*
	rm -rf $(PELTS_TESTS_DIR)

# vim: syntax=make
