# $Id$
#
# Copyright (C) 2005 by Alessio Igor Bogani
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CGICC) += cgicc

#
# Paths and names
#
CGICC_VERSION		= 3.2.3
CGICC			= cgicc-$(CGICC_VERSION)
CGICC_SUFFIX		= tar.gz
CGICC_URL		= http://www.cgicc.org/files/$(CGICC).$(CGICC_SUFFIX)
CGICC_SOURCE		= $(SRCDIR)/$(CGICC).$(CGICC_SUFFIX)
CGICC_DIR		= $(BUILDDIR)/$(CGICC)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cgicc_get: $(STATEDIR)/cgicc.get

cgicc_get_deps = $(CGICC_SOURCE)

$(STATEDIR)/cgicc.get: $(cgicc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(CGICC))
	@$(call touch, $@)

$(CGICC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CGICC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cgicc_extract: $(STATEDIR)/cgicc.extract

cgicc_extract_deps = $(STATEDIR)/cgicc.get

$(STATEDIR)/cgicc.extract: $(cgicc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CGICC_DIR))
	@$(call extract, $(CGICC_SOURCE))
	@$(call patchin, $(CGICC))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cgicc_prepare: $(STATEDIR)/cgicc.prepare

#
# dependencies
#
cgicc_prepare_deps = \
	$(STATEDIR)/cgicc.extract \
	$(STATEDIR)/virtual-xchain.install

CGICC_PATH	=  PATH=$(CROSS_PATH)
CGICC_ENV 	=  $(CROSS_ENV)
CGICC_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
CGICC_ENV	+=

#
# autoconf
#
CGICC_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/cgicc.prepare: $(cgicc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CGICC_DIR)/config.cache)
	cd $(CGICC_DIR) && \
		$(CGICC_PATH) $(CGICC_ENV) \
		./configure $(CGICC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cgicc_compile: $(STATEDIR)/cgicc.compile

cgicc_compile_deps = $(STATEDIR)/cgicc.prepare

$(STATEDIR)/cgicc.compile: $(cgicc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CGICC_DIR) && $(CGICC_ENV) $(CGICC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cgicc_install: $(STATEDIR)/cgicc.install

$(STATEDIR)/cgicc.install: $(STATEDIR)/cgicc.compile
	@$(call targetinfo, $@)
	#@$(call install, CGICC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cgicc_targetinstall: $(STATEDIR)/cgicc.targetinstall

cgicc_targetinstall_deps = $(STATEDIR)/cgicc.compile

$(STATEDIR)/cgicc.targetinstall: $(cgicc_targetinstall_deps_default)

	@$(call targetinfo, $@)
	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,cgicc)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CGICC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call copy_lib_root, libcgicc.so.1, /usr/lib)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cgicc_clean:
	rm -rf $(STATEDIR)/cgicc.*
	rm -rf $(CGICC_DIR)

# vim: syntax=make
