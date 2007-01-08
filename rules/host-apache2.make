# -*-makefile-*-
# $Id$
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
HOST_PACKAGES-$(PTXCONF_HOST_APACHE2) += host-apache2

#
# Paths and names
#
HOST_APACHE2		= $(APACHE2)
HOST_APACHE2_DIR	= $(HOST_BUILDDIR)/$(HOST_APACHE2)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-apache2_get: $(STATEDIR)/host-apache2.get

$(STATEDIR)/host-apache2.get: $(STATEDIR)/apache2.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-apache2_extract: $(STATEDIR)/host-apache2.extract

$(STATEDIR)/host-apache2.extract: $(host-apache2_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_APACHE2_DIR))
	@$(call extract, APACHE2, $(HOST_BUILDDIR))
	@$(call patchin, APACHE2, $(HOST_APACHE2_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-apache2_prepare: $(STATEDIR)/host-apache2.prepare

HOST_APACHE2_PATH	:= PATH=$(HOST_PATH)
HOST_APACHE2_ENV 	:= $(HOSTCC_ENV)

#
# autoconf
#
HOST_APACHE2_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-apache2.prepare: $(host-apache2_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_APACHE2_DIR)/config.cache)
	cd $(HOST_APACHE2_DIR) && \
		$(HOST_APACHE2_PATH) $(HOST_APACHE2_ENV) \
		./configure $(HOST_APACHE2_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-apache2_compile: $(STATEDIR)/host-apache2.compile

$(STATEDIR)/host-apache2.compile: $(host-apache2_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_APACHE2_DIR)/srclib/apr-util/uri && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) make
	cd $(HOST_APACHE2_DIR)/srclib/pcre && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) make dftables
	cd $(HOST_APACHE2_DIR)/server && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) make gen_test_char
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-apache2_install: $(STATEDIR)/host-apache2.install

$(STATEDIR)/host-apache2.install: $(host-apache2_install_deps_default)
	@$(call targetinfo, $@)
#	cd $(HOST_APACHE2_DIR) && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) $(MAKE_INSTALL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Tagetinstall 
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-apache2_clean:
	rm -rf $(STATEDIR)/host-apache2.*
	rm -rf $(HOST_APACHE2_DIR)

# vim: syntax=make
