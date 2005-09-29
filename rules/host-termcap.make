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
ifdef PTXCONF_HOST_TERMCAP
HOST_PACKAGES += host-termcap
endif

#
# Paths and names
#
HOST_TERMCAP_VERSION	= 1.3.1
HOST_TERMCAP		= termcap-$(HOST_TERMCAP_VERSION)
HOST_TERMCAP_SUFFIX	= tar.gz
HOST_TERMCAP_URL	= $(PTXCONF_SETUP_GNUMIRROR)/termcap/$(TERMCAP).$(TERMCAP_SUFFIX)
HOST_TERMCAP_DIR	= $(HOST_BUILDDIR)/$(HOST_TERMCAP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-termcap_get: $(STATEDIR)/host-termcap.get

host-termcap_get_deps = $(TERMCAP_SOURCE)

$(STATEDIR)/host-termcap.get: $(host-termcap_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOST_TERMCAP))
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-termcap_extract: $(STATEDIR)/host-termcap.extract

host-termcap_extract_deps = $(STATEDIR)/host-termcap.get

$(STATEDIR)/host-termcap.extract: $(host-termcap_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_TERMCAP_DIR))
	@$(call extract, $(TERMCAP_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOST_TERMCAP), $(HOST_TERMCAP_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-termcap_prepare: $(STATEDIR)/host-termcap.prepare

#
# dependencies
#
host-termcap_prepare_deps = \
	$(STATEDIR)/host-termcap.extract

HOST_TERMCAP_PATH	=  PATH=$(HOST_PATH)
HOST_TERMCAP_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOST_TERMCAP_AUTOCONF =  --prefix=$(PTXCONF_PREFIX)
HOST_TERMCAP_AUTOCONF += --build=$(GNU_HOST)
HOST_TERMCAP_AUTOCONF += --host=$(GNU_HOST)

$(STATEDIR)/host-termcap.prepare: $(host-termcap_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_TERMCAP_DIR)/config.cache)
	cd $(HOST_TERMCAP_DIR) && \
		$(HOST_TERMCAP_PATH) $(HOST_TERMCAP_ENV) \
		./configure $(HOST_TERMCAP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-termcap_compile: $(STATEDIR)/host-termcap.compile

host-termcap_compile_deps = $(STATEDIR)/host-termcap.prepare

$(STATEDIR)/host-termcap.compile: $(host-termcap_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOST_TERMCAP_DIR) && $(HOST_TERMCAP_ENV) $(HOST_TERMCAP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-termcap_install: $(STATEDIR)/host-termcap.install

host-termcap_install_deps = $(STATEDIR)/host-termcap.compile

$(STATEDIR)/host-termcap.install: $(host-termcap_install_deps)
	@$(call targetinfo, $@)
	cd $(HOST_TERMCAP_DIR) && $(HOST_TERMCAP_ENV) $(HOST_TERMCAP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-termcap_clean:
	rm -rf $(STATEDIR)/host-termcap.*
	rm -rf $(HOST_TERMCAP_DIR)

# vim: syntax=make
