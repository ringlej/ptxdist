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
TCPDUMP_VERSION	:= 3.9.5
TCPDUMP		:= tcpdump-$(TCPDUMP_VERSION)
TCPDUMP_SUFFIX	:= tar.gz
TCPDUMP_URL	:= http://www.tcpdump.org/release/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_SOURCE	:= $(SRCDIR)/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_DIR	:= $(BUILDDIR)/$(TCPDUMP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tcpdump_get: $(STATEDIR)/tcpdump.get

$(STATEDIR)/tcpdump.get: $(tcpdump_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TCPDUMP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TCPDUMP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tcpdump_extract: $(STATEDIR)/tcpdump.extract

$(STATEDIR)/tcpdump.extract: $(tcpdump_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TCPDUMP_DIR))
	@$(call extract, TCPDUMP, $(BUILDDIR))
	@$(call patchin, TCPDUMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tcpdump_prepare: $(STATEDIR)/tcpdump.prepare

TCPDUMP_PATH	:= PATH=$(CROSS_PATH)
TCPDUMP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
TCPDUMP_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	ac_cv_linux_vers=$(KERNEL_VERSION_MAJOR)

# FIXME: Unsupported switches yet
#  --with-user=USERNAME    drop privileges by default to USERNAME
#  --with-chroot=DIRECTORY when dropping privileges, chroot to DIRECTORY

ifndef PTXCONF_TCPDUMP_ENABLE_CRYPTO
TCPDUMP_AUTOCONF += --without-crypto
endif

ifdef PTXCONF_TCPDUMP_SMB
TCPDUMP_AUTOCONF += --enable-smb
else
TCPDUMP_AUTOCONF += --disable-smb
endif

ifdef PTXCONF_TCPDUMP_IPV6
TCPDUMP_AUTOCONF += --enable-ipv6
else
TCPDUMP_AUTOCONF += --disable-ipv6
endif

$(STATEDIR)/tcpdump.prepare: $(tcpdump_prepare_deps_default)
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

$(STATEDIR)/tcpdump.compile: $(tcpdump_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(TCPDUMP_DIR) && $(TCPDUMP_PATH) $(TCPDUMP_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tcpdump_install: $(STATEDIR)/tcpdump.install

$(STATEDIR)/tcpdump.install: $(tcpdump_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, TCPDUMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tcpdump_targetinstall: $(STATEDIR)/tcpdump.targetinstall

$(STATEDIR)/tcpdump.targetinstall: $(tcpdump_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, tcpdump)
	@$(call install_fixup, tcpdump,PACKAGE,tcpdump)
	@$(call install_fixup, tcpdump,PRIORITY,optional)
	@$(call install_fixup, tcpdump,VERSION,$(TCPDUMP_VERSION))
	@$(call install_fixup, tcpdump,SECTION,base)
	@$(call install_fixup, tcpdump,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, tcpdump,DEPENDS,)
	@$(call install_fixup, tcpdump,DESCRIPTION,missing)

	@$(call install_copy, tcpdump, 0, 0, 0755, $(TCPDUMP_DIR)/tcpdump, /usr/sbin/tcpdump)

	@$(call install_finish, tcpdump)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcpdump_clean:
	rm -rf $(STATEDIR)/tcpdump.*
	rm -rf $(TCPDUMP_DIR)

# vim: syntax=make
