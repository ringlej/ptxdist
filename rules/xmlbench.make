# -*-makefile-*-
# $Id: template 3288 2005-11-02 06:10:51Z rsc $
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

#
# FIXME: Broken Package
#
ifdef PTXCONF_XMLBENCH
PACKAGES-$(PTXCONF_XMLBENCH) += xmlbench
endif

#
# Paths and names
#
XMLBENCH_VERSION	= 1.3.0
XMLBENCH		= xmlbench-$(XMLBENCH_VERSION)
XMLBENCH_SUFFIX		= tar.bz2
XMLBENCH_URL		= $(PTXCONF_SETUP_SFMIRROR)/xmlbench/$(XMLBENCH).$(XMLBENCH_SUFFIX)
XMLBENCH_SOURCE		= $(SRCDIR)/$(XMLBENCH).$(XMLBENCH_SUFFIX)
XMLBENCH_DIR		= $(BUILDDIR)/$(XMLBENCH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xmlbench_get: $(STATEDIR)/xmlbench.get

$(STATEDIR)/xmlbench.get: $(xmlbench_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XMLBENCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XMLBENCH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xmlbench_extract: $(STATEDIR)/xmlbench.extract

$(STATEDIR)/xmlbench.extract: $(xmlbench_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLBENCH_DIR))
	@$(call extract, XMLBENCH)
	mv $(BUILDDIR)/xmlbench $(XMLBENCH_DIR)
	@$(call patchin, XMLBENCH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xmlbench_prepare: $(STATEDIR)/xmlbench.prepare

XMLBENCH_PATH	=  PATH=$(CROSS_PATH)
XMLBENCH_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
XMLBENCH_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xmlbench.prepare: $(xmlbench_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLBENCH_DIR)/config.cache)
	cd $(XMLBENCH_DIR) && \
		$(XMLBENCH_PATH) $(XMLBENCH_ENV) \
		./configure $(XMLBENCH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xmlbench_compile: $(STATEDIR)/xmlbench.compile

$(STATEDIR)/xmlbench.compile: $(xmlbench_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XMLBENCH_DIR) && $(XMLBENCH_ENV) $(XMLBENCH_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xmlbench_install: $(STATEDIR)/xmlbench.install

$(STATEDIR)/xmlbench.install: $(xmlbench_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XMLBENCH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xmlbench_targetinstall: $(STATEDIR)/xmlbench.targetinstall

$(STATEDIR)/xmlbench.targetinstall: $(xmlbench_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xmlbench)
	@$(call install_fixup, xmlbench,PACKAGE,xmlbench)
	@$(call install_fixup, xmlbench,PRIORITY,optional)
	@$(call install_fixup, xmlbench,VERSION,$(XMLBENCH_VERSION))
	@$(call install_fixup, xmlbench,SECTION,base)
	@$(call install_fixup, xmlbench,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xmlbench,DEPENDS,)
	@$(call install_fixup, xmlbench,DESCRIPTION,missing)

	@$(call install_copy, xmlbench, 0, 0, 0755, $(XMLBENCH_DIR)/foobar, /dev/null)

	@$(call install_finish, xmlbench)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xmlbench_clean:
	rm -rf $(STATEDIR)/xmlbench.*
	rm -rf $(PKGDIR)/xmlbench_*
	rm -rf $(XMLBENCH_DIR)

# vim: syntax=make
