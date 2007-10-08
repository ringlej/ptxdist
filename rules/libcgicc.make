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
PACKAGES-$(PTXCONF_CGICC) += libcgicc

#
# Paths and names
#
CGICC_VERSION		= 3.2.3
CGICC			= cgicc-$(CGICC_VERSION)
CGICC_SUFFIX		= tar.gz
CGICC_URL		= http://www.cgicc.org/files/$(CGICC).$(CGICC_SUFFIX)
CGICC_SOURCE		= $(SRCDIR)/$(CGICC).$(CGICC_SUFFIX)
CGICC_DIR		= $(BUILDDIR)/$(CGICC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libcgicc_get: $(STATEDIR)/libcgicc.get

$(STATEDIR)/libcgicc.get: $(libcgicc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CGICC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CGICC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libcgicc_extract: $(STATEDIR)/libcgicc.extract

$(STATEDIR)/libcgicc.extract: $(libcgicc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CGICC_DIR))
	@$(call extract, CGICC)
	@$(call patchin, CGICC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libcgicc_prepare: $(STATEDIR)/libcgicc.prepare

CGICC_PATH	=  PATH=$(CROSS_PATH)
CGICC_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
CGICC_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libcgicc.prepare: $(libcgicc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CGICC_DIR)/config.cache)
	cd $(CGICC_DIR) && \
		$(CGICC_PATH) $(CGICC_ENV) \
		./configure $(CGICC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libcgicc_compile: $(STATEDIR)/libcgicc.compile

$(STATEDIR)/libcgicc.compile: $(libcgicc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CGICC_DIR) && $(CGICC_ENV) $(CGICC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libcgicc_install: $(STATEDIR)/libcgicc.install

$(STATEDIR)/libcgicc.install: $(libcgicc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CGICC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libcgicc_targetinstall: $(STATEDIR)/libcgicc.targetinstall

$(STATEDIR)/libcgicc.targetinstall: $(libcgicc_targetinstall_deps_default)

	@$(call targetinfo, $@)
	@$(call install_init, libcgicc)
	@$(call install_fixup, libcgicc,PACKAGE,cgicc)
	@$(call install_fixup, libcgicc,PRIORITY,optional)
	@$(call install_fixup, libcgicc,VERSION,$(CGICC_VERSION))
	@$(call install_fixup, libcgicc,SECTION,base)
	@$(call install_fixup, libcgicc,AUTHOR,"Carsten Schlote <c.schlote\@konzeptpark.de>")
	@$(call install_fixup, libcgicc,DEPENDS,)
	@$(call install_fixup, libcgicc,DESCRIPTION,missing)

	@$(call install_copy, libcgicc, 0,0, 755, $(CGICC_DIR)/cgicc/.libs/libcgicc.so.5.0.1, /usr/lib/libcgicc.so.5.0.1)
	@$(call install_link, libcgicc, libcgicc.so.5.0.1, /usr/lib/libcgicc.so.5)
	@$(call install_link, libcgicc, libcgicc.so.5.0.1, /usr/lib/libcgicc.so)

	@$(call install_finish, libcgicc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libcgicc_clean:
	rm -rf $(STATEDIR)/libcgicc.*
	rm -rf $(CGICC_DIR)

# vim: syntax=make
