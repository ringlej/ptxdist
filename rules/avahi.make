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
	--enable-libdaemon \
	--disable-python \
	--disable-pygtk \
	--disable-python-dbus \
	--disable-mono \
	--disable-monodoc \
	--enable-autoipd \
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
	--with-xml=expat \
	--with-avahi-priv-access-group=netdev \
	--localstatedir=/var \
	--disable-stack-protector

ifdef PTXCONF_AVAHI_DAEMON
AVAHI_AUTOCONF += 				\
	--with-avahi-user=$(PTXCONF_AVAHI_USER)	\
	--with-avahi-group=$(PTXCONF_AVAHI_USER)
endif

ifdef PTXCONF_AVAHI_AUTOIP
AVAHI_AUTOCONF += 						\
	--with-autoipd-user=$(PTXCONF_AVAHI_AUTOIP_USER)	\
	--with-autoipd-group=$(PTXCONF_AVAHI_AUTOIP_GROUP)
endif

ifdef PTXCONF_AVAHI_GLIB
AVAHI_AUTOCONF += --enable-glib
else
AVAHI_AUTOCONF += --disable-glib
endif

ifdef PTXCONF_AVAHI_GOBJECT
AVAHI_AUTOCONF += --enable-gobject
else
AVAHI_AUTOCONF += --disable-gobject
endif

ifdef PTXCONF_AVAHI_QT3
AVAHI_AUTOCONF += --enable-qt3
else
AVAHI_AUTOCONF += --disable-qt3
endif

ifdef PTXCONF_AVAHI_QT4
AVAHI_AUTOCONF += --enable-qt4
else
AVAHI_AUTOCONF += --disable-qt4
endif

ifdef PTXCONF_AVAHI_GTK
AVAHI_AUTOCONF += --enable-gtk
else
AVAHI_AUTOCONF += --disable-gtk
endif

ifdef PTXCONF_AVAHI_DBUS
AVAHI_AUTOCONF += 					\
	--enable-dbus					\
	--with-dbus-sys=$(PTXCONF_AVAHI_DBUS_SYS)	\
	--with-dbus-system-address=$(PTXCONF_AVAHI_DBUS_SOCKET)
else
AVAHI_AUTOCONF += --disable-dbus
endif


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
	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/share/avahi/avahi-service.dtd)

#	avahi core libs
	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/lib/libavahi-core.so.6.0.1)
	@$(call install_link, avahi, libavahi-core.so.6.0.1, /usr/lib/libavahi-core.so.6)
	@$(call install_link, avahi, libavahi-core.so.6.0.1, /usr/lib/libavahi-core.so)

	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/lib/libavahi-common.so.3.5.1)
	@$(call install_link, avahi, libavahi-common.so.3.5.1, /usr/lib/libavahi-common.so.3)
	@$(call install_link, avahi, libavahi-common.so.3.5.1, /usr/lib/libavahi-common.so)

ifdef PTXCONF_AVAHI_QT4
	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/lib/libavahi-qt4.so.1.0.2)
	@$(call install_link, avahi, libavahi-qt4.so.1.0.2, /usr/lib/libavahi-qt4.so.1)
	@$(call install_link, avahi, libavahi-qt4.so.1.0.2, /usr/lib/libavahi-qt4.so)
endif

ifdef PTXCONF_AVAHI_LIBAVAHI_CLIENT
	@$(call install_copy, avahi, 0, 0, 0644, -, /usr/lib/libavahi-client.so.3.2.5)
	@$(call install_link, avahi, libavahi-client.so.3.2.5, /usr/lib/libavahi-client.so.3)
	@$(call install_link, avahi, libavahi-client.so.3.2.5, /usr/lib/libavahi-client.so)
endif

ifdef PTXCONF_AVAHI_DAEMON
#	avahi daemon (avahi mDNS/DNS-SD Implementation)
#	depends on expat
	@$(call install_copy, avahi, 0, 0, 0755, -, /usr/sbin/avahi-daemon)
	@$(call install_copy, avahi, 0, 0, 0644, -, /etc/avahi/avahi-daemon.conf)
	@$(call install_copy, avahi, 0, 0, 0644, -, /etc/avahi/hosts)
	@$(call install_alternative, avahi, 0, 0, 0755, /etc/init.d/avahi-daemon)
	@$(call install_link, avahi, ../init.d/avahi-daemon, /etc/rc.d/S35avahi-daemon)
endif

ifdef AVAHI_SERVICES
#	avahi service descriptions
#	depends on avahi-daemon
	@$(call install_copy, avahi, 0, 0, 0644, -, /etc/avahi/services/sftp-ssh.service)
	@$(call install_copy, avahi, 0, 0, 0644, -, /etc/avahi/services/ssh.service)
endif

ifdef AVAHI_DNSCONFD
#	avahi dnsconfd (Unicast DNS server from mDNS/DNS-SD configuration daemon)
#	depends on avahi-daemon
	@$(call install_copy, avahi, 0, 0, 0755, -, /usr/sbin/avahi-dnsconfd)
	@$(call install_copy, avahi, 0, 0, 0755, -, /etc/avahi/avahi-dnsconfd.action)
endif

ifdef PTXCONF_AVAHI_AUTOIP
#	avahi autoip daemon (avahi IPv4LL Implementation)
#	this component is needed for rfc3927 style link local adressing
#	depends on libdaemon
#	be shure to set CONFIG_FILE_LOCKING=y in your Kernel Config
	@$(call install_copy, avahi, 0, 0, 0755, -, /usr/sbin/avahi-autoipd)
	@$(call install_copy, avahi, 0, 0, 0755, -, /etc/avahi/avahi-autoipd.action)
	@$(call install_alternative, avahi, 0, 0, 0755, /etc/init.d/zeroconf)
	@$(call install_link, avahi, ../init.d/zeroconf, /etc/rc.d/S30zeroconf)
endif

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
