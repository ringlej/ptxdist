# -*-makefile-*-
#
# Copyright (C) 2004-2009 by Robert Schwebel
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
TCPDUMP_VERSION	:= 4.1.1
TCPDUMP		:= tcpdump-$(TCPDUMP_VERSION)
TCPDUMP_SUFFIX	:= tar.gz
TCPDUMP_URL	:= http://www.tcpdump.org/release/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_SOURCE	:= $(SRCDIR)/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_DIR	:= $(BUILDDIR)/$(TCPDUMP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TCPDUMP_SOURCE):
	@$(call targetinfo)
	@$(call get, TCPDUMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TCPDUMP_PATH	:= PATH=$(CROSS_PATH)
TCPDUMP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
TCPDUMP_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	ac_cv_linux_vers=$(KERNEL_VERSION_MAJOR) \
	td_cv_buggygetaddrinfo=no

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

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcpdump.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tcpdump)
	@$(call install_fixup, tcpdump,PACKAGE,tcpdump)
	@$(call install_fixup, tcpdump,PRIORITY,optional)
	@$(call install_fixup, tcpdump,VERSION,$(TCPDUMP_VERSION))
	@$(call install_fixup, tcpdump,SECTION,base)
	@$(call install_fixup, tcpdump,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, tcpdump,DEPENDS,)
	@$(call install_fixup, tcpdump,DESCRIPTION,missing)

	@$(call install_copy, tcpdump, 0, 0, 0755, -, /usr/sbin/tcpdump)

	@$(call install_finish, tcpdump)

	@$(call touch)

# vim: syntax=make
