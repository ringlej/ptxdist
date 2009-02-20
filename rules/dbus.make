# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Roland Hostettler
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBUS) += dbus

#
# Paths and names
#
DBUS_VERSION	:= 1.2.12
DBUS		:= dbus-$(DBUS_VERSION)
DBUS_SUFFIX	:= tar.gz
DBUS_URL	:= http://dbus.freedesktop.org/releases/dbus/$(DBUS).$(DBUS_SUFFIX)
DBUS_SOURCE	:= $(SRCDIR)/$(DBUS).$(DBUS_SUFFIX)
DBUS_DIR	:= $(BUILDDIR)/$(DBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DBUS_SOURCE):
	@$(call targetinfo)
	@$(call get, DBUS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DBUS_PATH := PATH=$(CROSS_PATH)
DBUS_ENV := $(CROSS_ENV)

#
# autoconf
#
DBUS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dnotify \
	--disable-doxygen-docs \
	--disable-gcov \
	--disable-kqueue \
	--disable-libaudit \
	--disable-tests \
	--disable-xml-docs \
	--enable-abstract-sockets=yes \
	--localstatedir=/var \
	--with-dbus-user=$(PTXCONF_DBUS_USER)

ifdef PTXCONF_DBUS_XML_EXPAT
DBUS_AUTOCONF += --with-xml=expat
endif
ifdef PTXCONF_DBUS_XML_LIBXML2
DBUS_AUTOCONF += --with-xml=libxml
endif
ifdef PTXCONF_DBUS__SELINUX
DBUS_AUTOCONF += --enable-selinux
else
DBUS_AUTOCONF += --disable-selinux
endif

ifdef PTXCONF_DBUS_X
DBUS_AUTOCONF += --with-x=$(SYSROOT)/usr
else
DBUS_AUTOCONF += --without-x
endif


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus)
	@$(call install_fixup,dbus,PACKAGE,dbus)
	@$(call install_fixup,dbus,PRIORITY,optional)
	@$(call install_fixup,dbus,VERSION,$(DBUS_VERSION))
	@$(call install_fixup,dbus,SECTION,base)
	@$(call install_fixup,dbus,AUTHOR,"Roland Hostettler <r.hostettler\@gmx.ch>")
	@$(call install_fixup,dbus,DEPENDS,)
	@$(call install_fixup,dbus,DESCRIPTION,missing)

	@$(call install_copy, dbus, 0, 0, 0755, $(DBUS_DIR)/bus/dbus-daemon, \
		/usr/bin/dbus-daemon)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-cleanup-sockets, \
		/usr/bin/dbus-cleanup-sockets)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-launch, /usr/bin/dbus-launch)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-monitor, /usr/bin/dbus-monitor)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-send, /usr/bin/dbus-send)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-uuidgen, /usr/bin/dbus-uuidgen)

	@$(call install_copy, dbus, 0, 0, 0644, \
		$(DBUS_DIR)/dbus/.libs/libdbus-1.so.3.4.0, \
		/usr/lib/libdbus-1.so.3.4.0)
	@$(call install_link, dbus, libdbus-1.so.3.4.0, /usr/lib/libdbus-1.so.3)
	@$(call install_link, dbus, libdbus-1.so.3.4.0, /usr/lib/libdbus-1.so)

	#
	# create system.d and event.d directories, which are used by the configuration and startup files
	#
	@$(call install_copy, dbus, 0, 0, 0755, /etc/dbus-1/system.d/)
	@$(call install_copy, dbus, 0, 0, 0755, /etc/dbus-1/event.d/)

	#
	# use the default /etc/dbus-1/system.conf config file
	#
ifdef PTXCONF_ROOTFS_GENERIC_DBUS_SYSTEM_CONF
	@$(call install_copy, dbus, 0, 0, 0644, $(DBUS_DIR)/bus/system.conf, \
		/etc/dbus-1/system.conf,n)
endif

	#
	# use the users /etc/dbus-1/system.conf config file from projectroot/etc/dbus-1/system.conf
	#
ifdef PTXCONF_ROOTFS_USER_DBUS_SYSTEM_CONF
	@echo "installing user system config file..."
	@$(call install_copy, dbus, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/dbus-1/system.conf, \
		/etc/dbus-1/system.conf,n)
endif

	#
	# use the default /etc/dbus-1/session.conf config file
	#
ifdef PTXCONF_ROOTFS_GENERIC_DBUS_SESSION_CONF
	@$(call install_copy, dbus, 0, 0, 0644, $(DBUS_DIR)/bus/session.conf, \
		/etc/dbus-1/session.conf,n)
endif

	#
	# use the user's /etc/dbus-1/session.conf config file from projectroot/etc/dbus-1/session.conf
	#
ifdef PTXCONF_ROOTFS_USER_DBUS_SESSION_CONF
	@echo "installing user session config file..."
	@$(call install_copy, dbus, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/dbus-1/session.conf, \
		/etc/dbus-1/session.conf,n)
endif


	#
	# busybox init: start script
	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_DBUS_STARTSCRIPT
	@$(call install_alternative, dbus, 0, 0, 0755, /etc/init.d/dbus, n)
endif
endif

	@$(call install_finish,dbus)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbus_clean:
	rm -rf $(STATEDIR)/dbus.*
	rm -rf $(PKGDIR)/dbus_*
	rm -rf $(DBUS_DIR)

# vim: syntax=make
