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
HOST_PACKAGES-$(PTXCONF_HOST_TERMCAP) += host-termcap

#
# Paths and names
#
HOST_TERMCAP		= $(TERMCAP)
HOST_TERMCAP_DIR	= $(HOST_BUILDDIR)/$(HOST_TERMCAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-termcap_get: $(STATEDIR)/host-termcap.get

$(STATEDIR)/host-termcap.get: $(STATEDIR)/termcap.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-termcap_extract: $(STATEDIR)/host-termcap.extract

$(STATEDIR)/host-termcap.extract: $(host-termcap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_TERMCAP_DIR))
	@$(call extract, TERMCAP, $(HOST_BUILDDIR))
	@$(call patchin, TERMCAP, $(HOST_TERMCAP_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-termcap_prepare: $(STATEDIR)/host-termcap.prepare

HOST_TERMCAP_PATH	=  PATH=$(HOST_PATH)
HOST_TERMCAP_ENV 	=  $(HOSTCC_ENV)

#
# autoconf without automake :-(
#
HOST_TERMCAP_AUTOCONF =  $(HOST_AUTOCONF)
HOST_TERMCAP_AUTOCONF += --prefix=$(PTXCONF_PREFIX)/usr

$(STATEDIR)/host-termcap.prepare: $(host-termcap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_TERMCAP_DIR)/config.cache)
	cd $(HOST_TERMCAP_DIR) && \
		$(HOST_TERMCAP_PATH) $(HOST_TERMCAP_ENV) \
		./configure $(HOST_TERMCAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-termcap_compile: $(STATEDIR)/host-termcap.compile

$(STATEDIR)/host-termcap.compile: $(host-termcap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_TERMCAP_DIR) && $(HOST_TERMCAP_ENV) $(HOST_TERMCAP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-termcap_install: $(STATEDIR)/host-termcap.install

$(STATEDIR)/host-termcap.install: $(host-termcap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_TERMCAP,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-termcap_clean:
	rm -rf $(STATEDIR)/host-termcap.*
	rm -rf $(HOST_TERMCAP_DIR)

# vim: syntax=make
