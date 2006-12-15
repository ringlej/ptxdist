# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UCSTOANY) += host-ucstoany

#
# Paths and names
#
HOST_UCSTOANY		:= $(XORG_FONT_UTIL)
HOST_UCSTOANY_DIR		:= $(HOST_BUILDDIR)/$(HOST_UCSTOANY)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-ucstoany_get: $(STATEDIR)/host-ucstoany.get

$(STATEDIR)/host-ucstoany.get: $(host-ucstoany_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_UCSTOANY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_UCSTOANY)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-ucstoany_extract: $(STATEDIR)/host-ucstoany.extract

$(STATEDIR)/host-ucstoany.extract: $(host-ucstoany_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_UCSTOANY_DIR))
	@$(call extract, HOST_UCSTOANY, $(HOST_BUILDDIR))
	@$(call patchin, HOST_UCSTOANY, $(HOST_UCSTOANY_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-ucstoany_prepare: $(STATEDIR)/host-ucstoany.prepare

HOST_UCSTOANY_PATH	:= PATH=$(HOST_PATH)
HOST_UCSTOANY_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_UCSTOANY_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-ucstoany.prepare: $(host-ucstoany_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_UCSTOANY_DIR)/config.cache)
	cd $(HOST_UCSTOANY_DIR) && \
		$(HOST_UCSTOANY_PATH) $(HOST_UCSTOANY_ENV) \
		./configure $(HOST_UCSTOANY_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-ucstoany_compile: $(STATEDIR)/host-ucstoany.compile

$(STATEDIR)/host-ucstoany.compile: $(host-ucstoany_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_UCSTOANY_DIR) && $(HOST_UCSTOANY_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-ucstoany_install: $(STATEDIR)/host-ucstoany.install

$(STATEDIR)/host-ucstoany.install: $(host-ucstoany_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_UCSTOANY,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-ucstoany_clean:
	rm -rf $(STATEDIR)/host-ucstoany.*
	rm -rf $(HOST_UCSTOANY_DIR)

# vim: syntax=make
