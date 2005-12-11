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
HOST_APACHE2_VERSION	= 2.0.55
HOST_APACHE2		= httpd-$(HOST_APACHE2_VERSION)
HOST_APACHE2_SUFFIX	= tar.bz2
HOST_APACHE2_URL	= http://ftp.plusline.de/ftp.apache.org/httpd/$(HOST_APACHE2).$(HOST_APACHE2_SUFFIX)
HOST_APACHE2_SOURCE	= $(SRCDIR)/$(HOST_APACHE2).$(HOST_APACHE2_SUFFIX)
HOST_APACHE2_DIR	= $(HOST_BUILDDIR)/$(HOST_APACHE2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-apache2_get: $(STATEDIR)/host-apache2.get

host-apache2_get_deps = $(HOST_APACHE2_SOURCE)

$(STATEDIR)/host-apache2.get: $(host-apache2_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-apache2_extract: $(STATEDIR)/host-apache2.extract

host-apache2_extract_deps = $(STATEDIR)/host-apache2.get

$(STATEDIR)/host-apache2.extract: $(host-apache2_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_APACHE2_DIR))
	@$(call extract, $(HOST_APACHE2_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOST_APACHE2), $(HOST_APACHE2_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-apache2_prepare: $(STATEDIR)/host-apache2.prepare

#
# dependencies
#
host-apache2_prepare_deps = \
	$(STATEDIR)/host-apache2.extract

HOST_APACHE2_PATH	=  PATH=$(HOST_PATH)
HOST_APACHE2_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOST_APACHE2_AUTOCONF =  --prefix=$(PTXCONF_PREFIX)
HOST_APACHE2_AUTOCONF += --build=$(GNU_HOST)
HOST_APACHE2_AUTOCONF += --host=$(GNU_HOST)

$(STATEDIR)/host-apache2.prepare: $(host-apache2_prepare_deps)
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

host-apache2_compile_deps = $(STATEDIR)/host-apache2.prepare

$(STATEDIR)/host-apache2.compile: $(host-apache2_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOST_APACHE2_DIR)/srclib/apr-util/uri && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) make
	cd $(HOST_APACHE2_DIR)/srclib/pcre && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) make dftables
	cd $(HOST_APACHE2_DIR)/server && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) make gen_test_char
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-apache2_install: $(STATEDIR)/host-apache2.install

host-apache2_install_deps = $(STATEDIR)/host-apache2.compile

$(STATEDIR)/host-apache2.install: $(host-apache2_install_deps)
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, HOST-APACHE2)
#	cd $(HOST_APACHE2_DIR) && $(HOST_APACHE2_ENV) $(HOST_APACHE2_PATH) $(MAKE_INSTALL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-apache2_clean:
	rm -rf $(STATEDIR)/host-apache2.*
	rm -rf $(HOST_APACHE2_DIR)

# vim: syntax=make
