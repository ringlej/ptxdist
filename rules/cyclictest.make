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
CYCLICTEST_VERSION	= 0.5
CYCLICTEST		= cyclictest-$(CYCLICTEST_VERSION)
CYCLICTEST_SUFFIX	= tar.bz2
CYCLICTEST_URL		= http://www.tglx.de/projects/misc/cyclictest/$(CYCLICTEST).$(CYCLICTEST_SUFFIX)
CYCLICTEST_SOURCE	= $(SRCDIR)/$(CYCLICTEST).$(CYCLICTEST_SUFFIX)
CYCLICTEST_DIR		= $(BUILDDIR)/$(CYCLICTEST)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cyclictest_get: $(STATEDIR)/cyclictest.get

cyclictest_get_deps = $(CYCLICTEST_SOURCE)

$(STATEDIR)/cyclictest.get: $(cyclictest_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(CYCLICTEST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CYCLICTEST_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cyclictest_extract: $(STATEDIR)/cyclictest.extract

cyclictest_extract_deps = $(STATEDIR)/cyclictest.get

$(STATEDIR)/cyclictest.extract: $(cyclictest_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CYCLICTEST_DIR))
	@$(call extract, $(CYCLICTEST_SOURCE))
	@$(call patchin, $(CYCLICTEST))
	# Well, we extract to...
	mv $(BUILDDIR)/cyclictest $(CYCLICTEST_DIR)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cyclictest_prepare: $(STATEDIR)/cyclictest.prepare

#
# dependencies
#
cyclictest_prepare_deps = \
	$(STATEDIR)/cyclictest.extract \
	$(STATEDIR)/virtual-xchain.install

CYCLICTEST_PATH	=  PATH=$(CROSS_PATH)
CYCLICTEST_ENV 	=  $(CROSS_ENV)
#CYCLICTEST_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
#CYCLICTEST_AUTOCONF =  $(CROSS_AUTOCONF)
#CYCLICTEST_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/cyclictest.prepare: $(cyclictest_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CYCLICTEST_DIR)/config.cache)
#	cd $(CYCLICTEST_DIR) && \
#		$(CYCLICTEST_PATH) $(CYCLICTEST_ENV) \
#		./configure $(CYCLICTEST_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cyclictest_compile: $(STATEDIR)/cyclictest.compile

cyclictest_compile_deps = $(STATEDIR)/cyclictest.prepare

$(STATEDIR)/cyclictest.compile: $(cyclictest_compile_deps)
	@$(call targetinfo, $@)
	cd $(CYCLICTEST_DIR) && $(CYCLICTEST_ENV) $(CYCLICTEST_PATH) make CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cyclictest_install: $(STATEDIR)/cyclictest.install

$(STATEDIR)/cyclictest.install: $(STATEDIR)/cyclictest.compile
	@$(call targetinfo, $@)
	cd $(CYCLICTEST_DIR) && $(CYCLICTEST_ENV) $(CYCLICTEST_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cyclictest_targetinstall: $(STATEDIR)/cyclictest.targetinstall

cyclictest_targetinstall_deps = $(STATEDIR)/cyclictest.compile

$(STATEDIR)/cyclictest.targetinstall: $(cyclictest_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,cyclictest)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CYCLICTEST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(CYCLICTEST_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cyclictest_clean:
	rm -rf $(STATEDIR)/cyclictest.*
	rm -rf $(IMAGEDIR)/cyclictest_*
	rm -rf $(CYCLICTEST_DIR)

# vim: syntax=make
