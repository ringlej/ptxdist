# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
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
PACKAGES-$(PTXCONF_AVAHI) += avahi

#
# Paths and names
#
AVAHI_VERSION	:= 0.6.25
AVAHI		:= avahi-$(AVAHI_VERSION)
AVAHI_SUFFIX	:= tar.gz
AVAHI_URL	:= http://avahi.org/download/$(AVAHI).$(AVAHI_SUFFIX)
AVAHI_SOURCE	:= $(SRCDIR)/$(AVAHI).$(AVAHI_SUFFIX)
AVAHI_DIR	:= $(BUILDDIR)/$(AVAHI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(AVAHI_SOURCE):
	@$(call targetinfo)
	@$(call get, AVAHI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

AVAHI_PATH	:= PATH=$(CROSS_PATH)
AVAHI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
AVAHI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-fast-install \
	--disable-nls \
	--disable-dbm \
	--disable-gdbm \
	--disable-libdaemon \
	--disable-python \
	--disable-pygtk \
	--disable-python-dbus \
	--disable-mono \
	--disable-monodoc \
	--disable-autoipd \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--disable-core-docs \
	--disable-manpages \
	--disable-xmltoman \
	--disable-tests \
	--disable-compat-libdns_sd \
	--disable-compat-howl \
	--with-distro=none \
	--with-xml=none \
	--with-avahi-user=avahi \
	--with-avahi-group=avahi \
	--with-avahi-priv-access-group=netdev \
	--with-autoipd-user=avahi-autoipd \
	--with-autoipd-group=avahi-autoipd

#
# FIXME: make these configurable
#

AVAHI_AUTOCONF += \
	--disable-glib \
	--disable-gobject \
	--disable-qt3 \
	--disable-qt4 \
	--disable-gtk \
	--disable-dbus

#
# FIXME:
#
#  --with-dbus-sys=<dir>   Path to D-Bus system.d directory
#  --with-dbus-system-address=<address>
#                          Path to the D-Bus system socket, you probably want
#                          to put unix:path= at the start. Only needed for very
#                          old D-Bus releases

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/avahi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, avahi)
	@$(call install_fixup, avahi,PACKAGE,avahi)
	@$(call install_fixup, avahi,PRIORITY,optional)
	@$(call install_fixup, avahi,VERSION,$(AVAHI_VERSION))
	@$(call install_fixup, avahi,SECTION,base)
	@$(call install_fixup, avahi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, avahi,DEPENDS,)
	@$(call install_fixup, avahi,DESCRIPTION,missing)

	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/share/avahi/service-types)

	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/lib/libavahi-core.so.6.0.1)
	@$(call install_link, avahi, libavahi-core.so.6.0.1, /usr/lib/libavahi-core.so.6)
	@$(call install_link, avahi, libavahi-core.so.6.0.1, /usr/lib/libavahi-core.so)

	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/lib/libavahi-common.so.3.5.1)
	@$(call install_link, avahi, libavahi-common.so.6.0.1, /usr/lib/libavahi-common.so.3)
	@$(call install_link, avahi, libavahi-common.so.6.0.1, /usr/lib/libavahi-common.so)

#	# FIXME: looks like wrong prefix? Untested anyway...
#	#/usr/var/run
#	#/usr/lib/avahi

	@$(call install_finish, avahi)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

avahi_clean:
	rm -rf $(STATEDIR)/avahi.*
	rm -rf $(PKGDIR)/avahi_*
	rm -rf $(AVAHI_DIR)

# vim: syntax=make
