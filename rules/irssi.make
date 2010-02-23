# -*-makefile-*-
#
# Copyright (C) 2010 by Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IRSSI) += irssi

#
# Paths and names
#
IRSSI_VERSION	:= 0.8.14
IRSSI		:= irssi-$(IRSSI_VERSION)
IRSSI_SUFFIX	:= tar.bz2
IRSSI_URL	:= http://irssi.org/files/$(IRSSI).$(IRSSI_SUFFIX)
IRSSI_SOURCE	:= $(SRCDIR)/$(IRSSI).$(IRSSI_SUFFIX)
IRSSI_DIR	:= $(BUILDDIR)/$(IRSSI)
IRSSI_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(IRSSI_SOURCE):
	@$(call targetinfo)
	@$(call get, IRSSI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IRSSI_CONF_TOOL := autoconf
IRSSI_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-ncurses=$(PTXDIST_SYSROOT_TARGET)/usr \
	--without-perl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/irssi.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  irssi)
	@$(call install_fixup, irssi,PACKAGE,irssi)
	@$(call install_fixup, irssi,PRIORITY,optional)
	@$(call install_fixup, irssi,VERSION,$(IRSSI_VERSION))
	@$(call install_fixup, irssi,SECTION,base)
	@$(call install_fixup, irssi,AUTHOR,"Josef Holzmayr <holzmayr@rsi-elektrotechnik.de")
	@$(call install_fixup, irssi,DEPENDS,)
	@$(call install_fixup, irssi,DESCRIPTION,missing)

	@$(call install_copy, irssi, 0, 0, 0755, -, /usr/bin/irssi)
	@$(call install_alternative, irssi, 0, 0, 0644, /etc/irssi.conf)

	@$(call install_finish, irssi)

	@$(call touch)

# vim: syntax=make
