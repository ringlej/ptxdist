# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCPDUMP) += tcpdump

#
# Paths and names
#
TCPDUMP_VERSION		= 3.9.1
TCPDUMP			= tcpdump-$(TCPDUMP_VERSION)
TCPDUMP_SUFFIX		= tar.gz
TCPDUMP_URL		= ftp://ftp.gwdg.de/pub/misc/tcpdump/beta/$(TCPDUMP)-096.$(TCPDUMP_SUFFIX)
TCPDUMP_SOURCE		= $(SRCDIR)/$(TCPDUMP)-096.$(TCPDUMP_SUFFIX)
TCPDUMP_DIR		= $(BUILDDIR)/$(TCPDUMP)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tcpdump_get: $(STATEDIR)/tcpdump.get

tcpdump_get_deps = $(TCPDUMP_SOURCE)

$(STATEDIR)/tcpdump.get: $(tcpdump_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(TCPDUMP))
	@$(call touch, $@)

$(TCPDUMP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TCPDUMP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tcpdump_extract: $(STATEDIR)/tcpdump.extract

tcpdump_extract_deps = $(STATEDIR)/tcpdump.get

$(STATEDIR)/tcpdump.extract: $(tcpdump_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TCPDUMP_DIR))
	@$(call extract, $(TCPDUMP_SOURCE), $(BUILDDIR))
	@$(call patchin, $(TCPDUMP))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tcpdump_prepare: $(STATEDIR)/tcpdump.prepare

#
# dependencies
#
tcpdump_prepare_deps = \
	$(STATEDIR)/tcpdump.extract \
	$(STATEDIR)/libpcap.install \
	$(STATEDIR)/virtual-xchain.install

TCPDUMP_PATH	=  PATH=$(CROSS_PATH)
TCPDUMP_ENV 	=  $(CROSS_ENV)
#TCPDUMP_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#TCPDUMP_ENV	+=

#
# autoconf
#
TCPDUMP_AUTOCONF =  $(CROSS_AUTOCONF_USR)

# while cross compiling configure cannot determine kernel version
TCPDUMP_AUTOCONF += ac_cv_linux_vers=$(KERNEL_VERSION_MAJOR)

ifdef PTXCONF_TCPDUMP_DISABLE_CRYPTO
TCPDUMP_AUTOCONF += --without-crypto
endif

$(STATEDIR)/tcpdump.prepare: $(tcpdump_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TCPDUMP_DIR)/config.cache)
	cd $(TCPDUMP_DIR) && \
		$(TCPDUMP_PATH) $(TCPDUMP_ENV) \
		./configure $(TCPDUMP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tcpdump_compile: $(STATEDIR)/tcpdump.compile

tcpdump_compile_deps = $(STATEDIR)/tcpdump.prepare

$(STATEDIR)/tcpdump.compile: $(tcpdump_compile_deps)
	@$(call targetinfo, $@)
	cd $(TCPDUMP_DIR) && $(TCPDUMP_ENV) $(TCPDUMP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tcpdump_install: $(STATEDIR)/tcpdump.install

$(STATEDIR)/tcpdump.install: $(STATEDIR)/tcpdump.compile
	@$(call targetinfo, $@)
	@$(call install, TCPDUMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tcpdump_targetinstall: $(STATEDIR)/tcpdump.targetinstall

tcpdump_targetinstall_deps = $(STATEDIR)/tcpdump.compile \
			     $(STATEDIR)/libpcap.install

$(STATEDIR)/tcpdump.targetinstall: $(tcpdump_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,tcpdump)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(TCPDUMP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(TCPDUMP_DIR)/tcpdump, /usr/sbin/tcpdump)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcpdump_clean:
	rm -rf $(STATEDIR)/tcpdump.*
	rm -rf $(TCPDUMP_DIR)

# vim: syntax=make
