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
PACKAGES-$(PTXCONF_CONNMAN) += connman

#
# Paths and names
#
CONNMAN_VERSION	:= 0.10
CONNMAN		:= connman-$(CONNMAN_VERSION)
CONNMAN_SUFFIX	:= tar.gz
CONNMAN_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(CONNMAN).$(CONNMAN_SUFFIX)
CONNMAN_SOURCE	:= $(SRCDIR)/$(CONNMAN).$(CONNMAN_SUFFIX)
CONNMAN_DIR	:= $(BUILDDIR)/$(CONNMAN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CONNMAN_SOURCE):
	@$(call targetinfo)
	@$(call get, CONNMAN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.extract:
	@$(call targetinfo)
	@$(call clean, $(CONNMAN_DIR))
	@$(call extract, CONNMAN)
	@$(call patchin, CONNMAN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CONNMAN_PATH	:= PATH=$(CROSS_PATH)

CONNMAN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CONNMAN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-debug \
	--enable-threads \
	--enable-datafiles

ifdef PTXCONF_CONNMAN_LOOPBACK
CONNMAN_AUTOCONF += --enable-loopback
else
CONNMAN_AUTOCONF += --disable-loopback
endif
ifdef PTXCONF_CONNMAN_ETHERNET
CONNMAN_AUTOCONF += --enable-ethernet
else
CONNMAN_AUTOCONF += --disable-ethernet
endif
ifdef PTXCONF_CONNMAN_WIFI
CONNMAN_AUTOCONF += --enable-wifi
else
CONNMAN_AUTOCONF += --disable-wifi
endif
ifdef PTXCONF_CONNMAN_WIMAX
CONNMAN_AUTOCONF += --enable-wimax
else
CONNMAN_AUTOCONF += --disable-wimax
endif
ifdef PTXCONF_CONNMAN_BLUETOOTH
CONNMAN_AUTOCONF += --enable-bluetooth
else
CONNMAN_AUTOCONF += --disable-bluetooth
endif
ifdef PTXCONF_CONNMAN_UDHCP
CONNMAN_AUTOCONF += --enable-udhcp
else
CONNMAN_AUTOCONF += --disable-udhcp
endif
ifdef PTXCONF_CONNMAN_DHCLIENT
CONNMAN_AUTOCONF += --enable-dhclient
else
CONNMAN_AUTOCONF += --disable-dhclient
endif
ifdef PTXCONF_CONNMAN_RESOLVCONF
CONNMAN_AUTOCONF += --enable-resolvconf
else
CONNMAN_AUTOCONF += --disable-resolvconf
endif
ifdef PTXCONF_CONNMAN_DNSPROXY
CONNMAN_AUTOCONF += --enable-dnsproxy
else
CONNMAN_AUTOCONF += --disable-dnsproxy
endif
ifdef PTXCONF_CONNMAN_NOVATEL
CONNMAN_AUTOCONF += --enable-novatel
else
CONNMAN_AUTOCONF += --disable-novatel
endif
ifdef PTXCONF_CONNMAN_HUAWEI
CONNMAN_AUTOCONF += --enable-huawei
else
CONNMAN_AUTOCONF += --disable-huawei
endif
ifdef PTXCONF_CONNMAN_HSO
CONNMAN_AUTOCONF += --enable-hso
else
CONNMAN_AUTOCONF += --disable-hso
endif
ifdef PTXCONF_CONNMAN_PPP
CONNMAN_AUTOCONF += --enable-ppp
else
CONNMAN_AUTOCONF += --disable-ppp
endif
ifdef PTXCONF_CONNMAN_UDEV
CONNMAN_AUTOCONF += --enable-udev
else
CONNMAN_AUTOCONF += --disable-udev
endif
ifdef PTXCONF_CONNMAN_POLKIT
CONNMAN_AUTOCONF += --enable-polkit
else
CONNMAN_AUTOCONF += --disable-polkit
endif
ifdef PTXCONF_CONNMAN_CLIENT
CONNMAN_AUTOCONF += --enable-client
else
CONNMAN_AUTOCONF += --disable-client
endif
ifdef PTXCONF_CONNMAN_FAKE
CONNMAN_AUTOCONF += --enable-fake
else
CONNMAN_AUTOCONF += --disable-fake
endif

$(STATEDIR)/connman.prepare:
	@$(call targetinfo)
	@$(call clean, $(CONNMAN_DIR)/config.cache)
	cd $(CONNMAN_DIR) && \
		$(CONNMAN_PATH) $(CONNMAN_ENV) \
		./configure $(CONNMAN_AUTOCONF) DBUS_DATADIR=/etc
	# FIXME hack alert: configure.ac determines the sysconfdir, but
	# our pkg-config-wrapper leaks the host path in
	cd $(CONNMAN_DIR) && for i in $$(find . -name "Makefile"); do \
		sed -i -e "s/^DBUS_DATADIR =.*$$/DBUS_DATADIR = \/etc/g" $$i; \
	done
	sed -i -e "s/^dbusdir =.*$$/dbusdir = \/etc\/dbus-1\/system.d/g" $(CONNMAN_DIR)/src/Makefile
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.compile:
	@$(call targetinfo)
	cd $(CONNMAN_DIR) && $(CONNMAN_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.install:
	@$(call targetinfo)
	@$(call install, CONNMAN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.targetinstall:
	@$(call targetinfo)

	@$(call install_init, connman)
	@$(call install_fixup, connman,PACKAGE,connman)
	@$(call install_fixup, connman,PRIORITY,optional)
	@$(call install_fixup, connman,VERSION,$(CONNMAN_VERSION))
	@$(call install_fixup, connman,SECTION,base)
	@$(call install_fixup, connman,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, connman,DEPENDS,)
	@$(call install_fixup, connman,DESCRIPTION,missing)

	# binary
	@$(call install_copy, connman, 0, 0, 0755, -, /usr/sbin/connmand)

	# dirs
	@$(call install_copy, connman, 0, 0, 0755, /usr/lib/connman)
	@$(call install_copy, connman, 0, 0, 0755, /usr/lib/connman/scripts)
	@$(call install_copy, connman, 0, 0, 0755, /usr/lib/connman/plugins)

	# start script
	@$(call install_copy, connman, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/connman, \
		/etc/init.d/connman)

	# dbus config
	@$(call install_copy, connman, 0, 0, 0644, -, /etc/dbus-1/system.d/connman.conf)

	@$(call install_finish, connman)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

connman_clean:
	rm -rf $(STATEDIR)/connman.*
	rm -rf $(PKGDIR)/connman_*
	rm -rf $(CONNMAN_DIR)

# vim: syntax=make
