# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LOCALEDEF) += host-localedef

#
# Paths and names
#
HOST_LOCALEDEF_VERSION	:= eglibc-2.5-ptx2
HOST_LOCALEDEF		:= localedef-$(HOST_LOCALEDEF_VERSION)
HOST_LOCALEDEF_SUFFIX	:= tar.bz2
HOST_LOCALEDEF_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HOST_LOCALEDEF).$(HOST_LOCALEDEF_SUFFIX)
HOST_LOCALEDEF_SOURCE	:= $(SRCDIR)/$(HOST_LOCALEDEF).$(HOST_LOCALEDEF_SUFFIX)
HOST_LOCALEDEF_DIR	:= $(HOST_BUILDDIR)/$(HOST_LOCALEDEF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-localedef_get: $(STATEDIR)/host-localedef.get

$(STATEDIR)/host-localedef.get: $(host-localedef_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_LOCALEDEF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_LOCALEDEF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-localedef_extract: $(STATEDIR)/host-localedef.extract

$(STATEDIR)/host-localedef.extract: $(host-localedef_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LOCALEDEF_DIR))
	@$(call extract, HOST_LOCALEDEF, $(HOST_BUILDDIR))
	@$(call patchin, HOST_LOCALEDEF, $(HOST_LOCALEDEF_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-localedef_prepare: $(STATEDIR)/host-localedef.prepare

HOST_LOCALEDEF_PATH	:= PATH=$(HOST_PATH)
HOST_LOCALEDEF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LOCALEDEF_AUTOCONF	:= --with-glibc=./eglibc-2.5/ --prefix=/usr

$(STATEDIR)/host-localedef.prepare: $(host-localedef_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LOCALEDEF_DIR)/config.cache)
	cd $(HOST_LOCALEDEF_DIR) && \
		$(HOST_LOCALEDEF_PATH) $(HOST_LOCALEDEF_ENV) \
		./configure $(HOST_LOCALEDEF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-localedef_compile: $(STATEDIR)/host-localedef.compile

$(STATEDIR)/host-localedef.compile: $(host-localedef_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LOCALEDEF_DIR) && $(HOST_LOCALEDEF_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-localedef_install: $(STATEDIR)/host-localedef.install

$(STATEDIR)/host-localedef.install: $(host-localedef_install_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LOCALEDEF_DIR) && cp localedef $(PTXCONF_SYSROOT_HOST)/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-localedef_clean:
	rm -rf $(STATEDIR)/host-localedef.*
	rm -rf $(HOST_LOCALEDEF_DIR)

# vim: syntax=make
