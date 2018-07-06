# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CIFS_UTILS) += cifs-utils

#
# Paths and names
#
CIFS_UTILS_VERSION	:= 6.8
CIFS_UTILS_MD5		:= a385d60293e6f9e4cb0d4ac2093990d8
CIFS_UTILS		:= cifs-utils-$(CIFS_UTILS_VERSION)
CIFS_UTILS_SUFFIX	:= tar.bz2
CIFS_UTILS_URL		:= https://ftp.samba.org/pub/linux-cifs/cifs-utils/$(CIFS_UTILS).$(CIFS_UTILS_SUFFIX)
CIFS_UTILS_SOURCE	:= $(SRCDIR)/$(CIFS_UTILS).$(CIFS_UTILS_SUFFIX)
CIFS_UTILS_DIR		:= $(BUILDDIR)/$(CIFS_UTILS)
CIFS_UTILS_LICENSE	:= GPL-3.0-only

#
# autoconf
#
CIFS_UTILS_CONF_TOOL	:= autoconf
CIFS_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-cifsupcall \
	--disable-cifscreds \
	--disable-cifsidmap \
	--disable-cifsacl \
	--disable-pam \
	--disable-systemd \
	--disable-man \
	--without-libcap

CIFS_UTILS_INSTALL_OPT := \
	root_sbindir=/usr/sbin \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cifs-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cifs-utils)
	@$(call install_fixup, cifs-utils,PRIORITY,optional)
	@$(call install_fixup, cifs-utils,SECTION,base)
	@$(call install_fixup, cifs-utils,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, cifs-utils,DESCRIPTION,missing)

	@$(call install_copy, cifs-utils, 0, 0, 0755, -, /usr/sbin/mount.cifs)

	@$(call install_finish, cifs-utils)

	@$(call touch)

# vim: syntax=make
