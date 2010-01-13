# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETWORKMANAGER) += networkmanager

#
# Paths and names
#
NETWORKMANAGER_VERSION	:= 0.7.0
NETWORKMANAGER		:= NetworkManager-$(NETWORKMANAGER_VERSION)
NETWORKMANAGER_SUFFIX	:= tar.gz
NETWORKMANAGER_URL	:= http://ftp.gnome.org/pub/GNOME/sources/NetworkManager/0.7/$(NETWORKMANAGER).$(NETWORKMANAGER_SUFFIX)
NETWORKMANAGER_SOURCE	:= $(SRCDIR)/$(NETWORKMANAGER).$(NETWORKMANAGER_SUFFIX)
NETWORKMANAGER_DIR	:= $(BUILDDIR)/$(NETWORKMANAGER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NETWORKMANAGER_SOURCE):
	@$(call targetinfo)
	@$(call get, NETWORKMANAGER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager.extract:
	@$(call targetinfo)
	@$(call clean, $(NETWORKMANAGER_DIR))
	@$(call extract, NETWORKMANAGER)
	@$(call patchin, NETWORKMANAGER)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NETWORKMANAGER_PATH	:= PATH=$(CROSS_PATH)
NETWORKMANAGER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
NETWORKMANAGER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--enable-more-warnings \
	--disable-gtk-doc \
	--with-gnu-ld \
	--without-docs \
	--with-distro=debian

#  --with-tags[=TAGS]      include additional configurations [automatic]
#  --with-distro=DISTRO    Specify the Linux distribution to target: One of
#                          redhat, suse, gentoo, debian, arch, slackware, paldo
#                          or mandriva
#  --with-crypto=nss | gnutls
#                          Cryptography library to use for certificate and key
#                          operations
#  --with-dbus-sys-dir=DIR where D-BUS system.d directory is
#  --with-pppd-plugin-dir=DIR
#                          path to the pppd plugins directory
#  --with-dhcp-client=dhcpcd|dhclient
#                          path to the chosen dhcp client
#  --with-resolvconf=yes|no|path
#                          Enable resolvconf support
#  --with-system-ca-path=/path/to/ssl/certs
#                          path to system CA certificates
#  --with-html-dir=PATH    path to installed docs

$(STATEDIR)/networkmanager.prepare:
	@$(call targetinfo)
	@$(call clean, $(NETWORKMANAGER_DIR)/config.cache)
	cd $(NETWORKMANAGER_DIR) && \
		$(NETWORKMANAGER_PATH) $(NETWORKMANAGER_ENV) \
		./configure $(NETWORKMANAGER_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager.compile:
	@$(call targetinfo)
	cd $(NETWORKMANAGER_DIR) && $(NETWORKMANAGER_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager.install:
	@$(call targetinfo)
	@$(call install, NETWORKMANAGER)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager.targetinstall:
	@$(call targetinfo)

	@$(call install_init, networkmanager)
	@$(call install_fixup, networkmanager,PACKAGE,networkmanager)
	@$(call install_fixup, networkmanager,PRIORITY,optional)
	@$(call install_fixup, networkmanager,VERSION,$(NETWORKMANAGER_VERSION))
	@$(call install_fixup, networkmanager,SECTION,base)
	@$(call install_fixup, networkmanager,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, networkmanager,DEPENDS,)
	@$(call install_fixup, networkmanager,DESCRIPTION,missing)

	@$(call install_copy, networkmanager, 0, 0, 0755, $(NETWORKMANAGER_DIR)/foobar, /dev/null)

	@$(call install_finish, networkmanager)

	@$(call touch)

# vim: syntax=make
