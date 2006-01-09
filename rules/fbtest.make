# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBTEST) += fbtest

#
# Paths and names
#
FBTEST_VERSION	= 20041102-1
FBTEST		= fbtest-$(FBTEST_VERSION)
FBTEST_SUFFIX	= tar.gz
FBTEST_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FBTEST).$(FBTEST_SUFFIX)
FBTEST_SOURCE	= $(SRCDIR)/$(FBTEST).$(FBTEST_SUFFIX)
FBTEST_DIR	= $(BUILDDIR)/$(FBTEST)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fbtest_get: $(STATEDIR)/fbtest.get

fbtest_get_deps = $(FBTEST_SOURCE)

$(STATEDIR)/fbtest.get: $(fbtest_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(FBTEST))
	@$(call touch, $@)

$(FBTEST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FBTEST_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fbtest_extract: $(STATEDIR)/fbtest.extract

fbtest_extract_deps = $(STATEDIR)/fbtest.get

$(STATEDIR)/fbtest.extract: $(fbtest_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FBTEST_DIR))
	@$(call extract, $(FBTEST_SOURCE))
	@$(call patchin, $(FBTEST))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fbtest_prepare: $(STATEDIR)/fbtest.prepare

#
# dependencies
#
fbtest_prepare_deps = \
	$(STATEDIR)/fbtest.extract \
	$(STATEDIR)/libnetpbm.install \
	$(STATEDIR)/virtual-xchain.install

FBTEST_PATH	=  PATH=$(CROSS_PATH)
FBTEST_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/fbtest.prepare: $(fbtest_prepare_deps)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fbtest_compile: $(STATEDIR)/fbtest.compile

fbtest_compile_deps = $(STATEDIR)/fbtest.prepare

$(STATEDIR)/fbtest.compile: $(fbtest_compile_deps)
	@$(call targetinfo, $@)
	cd $(FBTEST_DIR) && $(FBTEST_ENV) $(FBTEST_PATH) \
		CROSS_COMPILE=$(COMPILER_PREFIX) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fbtest_install: $(STATEDIR)/fbtest.install

$(STATEDIR)/fbtest.install: $(STATEDIR)/fbtest.compile
	@$(call targetinfo, $@)
	# FIXME
	#$(call install, FBTEST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fbtest_targetinstall: $(STATEDIR)/fbtest.targetinstall

fbtest_targetinstall_deps = \
	$(STATEDIR)/fbtest.compile \
	$(STATEDIR)/libnetpbm.targetinstall

$(STATEDIR)/fbtest.targetinstall: $(fbtest_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,fbtest)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(FBTEST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(FBTEST_DIR)/$(COMPILER_PREFIX)fbtest, /sbin/fbtest)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fbtest_clean:
	rm -rf $(STATEDIR)/fbtest.*
	rm -rf $(IMAGEDIR)/fbtest_*
	rm -rf $(FBTEST_DIR)

# vim: syntax=make
