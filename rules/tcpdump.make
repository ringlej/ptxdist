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
TCPDUMP_VERSION	:= 4.5.1
TCPDUMP_MD5	:= 973a2513d0076e34aa9da7e15ed98e1b
TCPDUMP		:= tcpdump-$(TCPDUMP_VERSION)
TCPDUMP_SUFFIX	:= tar.gz
TCPDUMP_URL	:= http://www.tcpdump.org/release/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_SOURCE	:= $(SRCDIR)/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_DIR	:= $(BUILDDIR)/$(TCPDUMP)
TCPDUMP_LICENSE := BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TCPDUMP_CONF_ENV	= \
	$(CROSS_ENV) \
	ac_cv_linux_vers=$(KERNEL_HEADER_VERSION_MAJOR) \
	td_cv_buggygetaddrinfo=no

#
# autoconf
#
TCPDUMP_CONF_TOOL	:= autoconf
TCPDUMP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis,PTXCONF_TCPDUMP_SMB)-smb \
	$(GLOBAL_IPV6_OPTION) \
	--without-smi \
	--$(call ptx/wwo,PTXCONF_TCPDUMP_ENABLE_CRYPTO)-crypto

# FIXME: Unsupported switches yet
#  --with-user=USERNAME    drop privileges by default to USERNAME
#  --with-chroot=DIRECTORY when dropping privileges, chroot to DIRECTORY

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcpdump.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tcpdump)
	@$(call install_fixup, tcpdump,PRIORITY,optional)
	@$(call install_fixup, tcpdump,SECTION,base)
	@$(call install_fixup, tcpdump,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, tcpdump,DESCRIPTION,missing)

	@$(call install_copy, tcpdump, 0, 0, 0755, -, /usr/sbin/tcpdump)

	@$(call install_finish, tcpdump)

	@$(call touch)

# vim: syntax=make
