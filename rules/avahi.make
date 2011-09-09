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
PACKAGES-$(PTXCONF_AVAHI) += avahi

#
# Paths and names
#
AVAHI_VERSION	:= 0.6.25
AVAHI_MD5	:= a83155a6e29e3988f07e5eea3287b21e
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
AVAHI_CONF_TOOL	:= autoconf
AVAHI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-stack-protector \
	--disable-nls \
	--$(call ptx/endis, PTXCONF_AVAHI_GLIB)-glib \
	--$(call ptx/endis, PTXCONF_AVAHI_GOBJECT)-gobject \
	--disable-introspection \
	--disable-qt3 \
	--$(call ptx/endis, PTXCONF_AVAHI_QT4)-qt4 \
	--$(call ptx/endis, PTXCONF_AVAHI_GTK)-gtk \
	--$(call ptx/endis, PTXCONF_AVAHI_DBUS)-dbus \
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
	--with-dbus-sys=/etc/dbus-1/system.d \
	--with-xml=expat \
	--with-avahi-user=$(PTXCONF_AVAHI_USER) \
	--with-avahi-group=$(PTXCONF_AVAHI_GROUP) \
	--with-avahi-priv-access-group=netdev \
	--with-autoipd-user=$(PTXCONF_AVAHI_AUTOIP_USER) \
	--with-autoipd-group=$(PTXCONF_AVAHI_AUTOIP_GROUP)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/avahi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, avahi)
	@$(call install_fixup, avahi,PRIORITY,optional)
	@$(call install_fixup, avahi,SECTION,base)
	@$(call install_fixup, avahi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, avahi,DESCRIPTION,missing)

	@$(call install_copy, avahi, 0, 0, 0644, -, \
		/usr/share/avahi/service-types)
	@$(call install_copy, avahi, 0, 0, 0644, -, \
		/usr/share/avahi/avahi-service.dtd)

#	avahi core libs
	@$(call install_lib, avahi, 0, 0, 0644, libavahi-core)
	@$(call install_lib, avahi, 0, 0, 0644, libavahi-common)

ifdef PTXCONF_AVAHI_DBUS
	@$(call install_alternative, avahi, 0, 0, 0644, \
		/etc/dbus-1/system.d/avahi-dbus.conf)
endif

ifdef PTXCONF_AVAHI_QT4
	@$(call install_lib, avahi, 0, 0, 0644, libavahi-qt4)
endif

ifdef PTXCONF_AVAHI_LIBAVAHI_CLIENT
	@$(call install_lib, avahi, 0, 0, 0644, libavahi-client)
endif

ifdef PTXCONF_AVAHI_DAEMON
#	avahi daemon (avahi mDNS/DNS-SD Implementation)
#	depends on expat
	@$(call install_copy, avahi, 0, 0, 0755, -, /usr/sbin/avahi-daemon)

	@$(call install_alternative, avahi, 0, 0, 0644, \
		/etc/avahi/avahi-daemon.conf)
	@$(call install_alternative, avahi, 0, 0, 0644, /etc/avahi/hosts)

ifdef PTXCONF_INITMETHOD_BBINIT
	@$(call install_alternative, avahi, 0, 0, 0755, /etc/init.d/avahi-daemon)
	@$(call install_link, avahi, ../init.d/avahi-daemon, \
		/etc/rc.d/S35avahi-daemon)
endif
ifdef PTXCONF_INITMETHOD_UPSTART
	@$(call install_alternative, avahi, 0, 0, 0644, \
		/etc/init/avahi-daemon.conf)
endif
endif

ifdef PTXCONF_AVAHI_SERVICES
#	avahi service descriptions
#	depends on avahi-daemon
	@$(call install_copy, avahi, 0, 0, 0644, -, \
		/etc/avahi/services/sftp-ssh.service)
	@$(call install_copy, avahi, 0, 0, 0644, -, \
		/etc/avahi/services/ssh.service)
endif

ifdef PTXCONF_AVAHI_DNSCONFD
#	avahi dnsconfd (Unicast DNS server from mDNS/DNS-SD configuration daemon)
#	depends on avahi-daemon
	@$(call install_copy, avahi, 0, 0, 0755, -, /usr/sbin/avahi-dnsconfd)
	@$(call install_copy, avahi, 0, 0, 0755, -, \
		/etc/avahi/avahi-dnsconfd.action)
endif

ifdef PTXCONF_AVAHI_AUTOIP
#	avahi autoip daemon (avahi IPv4LL Implementation)
#	this component is needed for rfc3927 style link local adressing
#	depends on libdaemon
#	be shure to set CONFIG_FILE_LOCKING=y in your Kernel Config
	@$(call install_copy, avahi, 0, 0, 0755, -, /usr/sbin/avahi-autoipd)
	@$(call install_copy, avahi, 0, 0, 0755, -, \
		/etc/avahi/avahi-autoipd.action)

ifdef PTXCONF_INITMETHOD_BBINIT
	@$(call install_alternative, avahi, 0, 0, 0755, /etc/init.d/zeroconf)
	@$(call install_link, avahi, ../init.d/zeroconf, /etc/rc.d/S30zeroconf)
endif
endif

	@$(call install_finish, avahi)

	@$(call touch)

# vim: syntax=make
