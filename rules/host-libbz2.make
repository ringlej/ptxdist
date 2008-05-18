# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBBZ2) += host-libbz2

#
# Paths and names
#
HOST_LIBBZ2_VERSION	:= 1.0.4
HOST_LIBBZ2		:= bzip2-$(HOST_LIBBZ2_VERSION)
HOST_LIBBZ2_SUFFIX	:= tar.gz
HOST_LIBBZ2_URL		:= http://www.bzip.org/1.0.4/$(HOST_LIBBZ2).$(HOST_LIBBZ2_SUFFIX)
HOST_LIBBZ2_SOURCE	:= $(SRCDIR)/$(HOST_LIBBZ2).$(HOST_LIBBZ2_SUFFIX)
HOST_LIBBZ2_DIR		:= $(HOST_BUILDDIR)/$(HOST_LIBBZ2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libbz2_get: $(STATEDIR)/host-libbz2.get

$(STATEDIR)/host-libbz2.get: $(host-libbz2_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_LIBBZ2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_LIBBZ2)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libbz2_extract: $(STATEDIR)/host-libbz2.extract

$(STATEDIR)/host-libbz2.extract: $(host-libbz2_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBBZ2_DIR))
	@$(call extract, HOST_LIBBZ2, $(HOST_BUILDDIR))
	@$(call patchin, HOST_LIBBZ2, $(HOST_LIBBZ2_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libbz2_prepare: $(STATEDIR)/host-libbz2.prepare

HOST_LIBBZ2_PATH	:= PATH=$(HOST_PATH)
HOST_LIBBZ2_ENV 	:= $(HOST_ENV)

#
# autoconf
#
# HOST_LIBBZ2_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libbz2.prepare: $(host-libbz2_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBBZ2_DIR)/config.cache)
#	cd $(HOST_LIBBZ2_DIR) && \
#		$(HOST_LIBBZ2_PATH) $(HOST_LIBBZ2_ENV) \
#		./configure $(HOST_LIBBZ2_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libbz2_compile: $(STATEDIR)/host-libbz2.compile

$(STATEDIR)/host-libbz2.compile: $(host-libbz2_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBBZ2_DIR) && $(HOST_LIBBZ2_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libbz2_install: $(STATEDIR)/host-libbz2.install

$(STATEDIR)/host-libbz2.install: $(host-libbz2_install_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBBZ2_DIR) && make install PREFIX=$(PTXCONF_SYSROOT_HOST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libbz2_clean:
	rm -rf $(STATEDIR)/host-libbz2.*
	rm -rf $(HOST_LIBBZ2_DIR)

# vim: syntax=make
