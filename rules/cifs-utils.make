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
CIFS_UTILS_VERSION	:= 5.2
CIFS_UTILS_MD5		:= 2ca839553cccd0c3042f7dd8737cc9de
CIFS_UTILS		:= cifs-utils-$(CIFS_UTILS_VERSION)
CIFS_UTILS_SUFFIX	:= tar.bz2
CIFS_UTILS_URL		:= https://ftp.samba.org/pub/linux-cifs/cifs-utils/$(CIFS_UTILS).$(CIFS_UTILS_SUFFIX)
CIFS_UTILS_SOURCE	:= $(SRCDIR)/$(CIFS_UTILS).$(CIFS_UTILS_SUFFIX)
CIFS_UTILS_DIR		:= $(BUILDDIR)/$(CIFS_UTILS)
CIFS_UTILS_LICENSE	:= unknown

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
	--without-libcap

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

	@$(call install_copy, cifs-utils, 0, 0, 0755, -, /sbin/mount.cifs)

	@$(call install_finish, cifs-utils)

	@$(call touch)

# vim: syntax=make
