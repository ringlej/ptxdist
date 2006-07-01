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
PACKAGES-$(PTXCONF_PELTS_TESTS) += pelts_tests

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

pelts_tests_get: $(STATEDIR)/pelts_tests.get

$(STATEDIR)/pelts_tests.get: $(pelts_tests_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PELTS_TESTS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PELTS_TESTS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pelts_tests_extract: $(STATEDIR)/pelts_tests.extract

$(STATEDIR)/pelts_tests.extract: $(pelts_tests_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PELTS_TESTS_DIR))
	@$(call extract, PELTS_TESTS)
	@$(call patchin, PELTS_TESTS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pelts_tests_prepare: $(STATEDIR)/pelts_tests.prepare

PELTS_TESTS_PATH	:=  PATH=$(CROSS_PATH)
PELTS_TESTS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
PELTS_TESTS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/pelts_tests.prepare: $(pelts_tests_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PELTS_TESTS_DIR)/config.cache)
	cd $(PELTS_TESTS_DIR) && \
		$(PELTS_TESTS_PATH) $(PELTS_TESTS_ENV) \
		./configure $(PELTS_TESTS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pelts_tests_compile: $(STATEDIR)/pelts_tests.compile

$(STATEDIR)/pelts_tests.compile: $(pelts_tests_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PELTS_TESTS_DIR) && $(PELTS_TESTS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pelts_tests_install: $(STATEDIR)/pelts_tests.install

$(STATEDIR)/pelts_tests.install: $(pelts_tests_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pelts_tests_targetinstall: $(STATEDIR)/pelts_tests.targetinstall

$(STATEDIR)/pelts_tests.targetinstall: $(pelts_tests_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pelts_tests)
	@$(call install_fixup,pelts_tests,PACKAGE,pelts-tests)
	@$(call install_fixup,pelts_tests,PRIORITY,optional)
	@$(call install_fixup,pelts_tests,VERSION,$(PELTS_TESTS_VERSION))
	@$(call install_fixup,pelts_tests,SECTION,base)
	@$(call install_fixup,pelts_tests,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pelts_tests,DEPENDS,)
	@$(call install_fixup,pelts_tests,DESCRIPTION,missing)

	@$(call install_copy, pelts_tests, 0, 0, 0755, $(PELTS_TESTS_DIR)/src/floattest, /usr/bin/floattest)

	@$(call install_finish,pelts_tests)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pelts_tests_clean:
	rm -rf $(STATEDIR)/pelts_tests.*
	rm -rf $(IMAGEDIR)/pelts_tests_*
	rm -rf $(PELTS_TESTS_DIR)

# vim: syntax=make
