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
PACKAGES-$(PTXCONF_DEVICEKIT) += devicekit

#
# Paths and names
#
DEVICEKIT_VERSION	:= 002
DEVICEKIT		:= DeviceKit-$(DEVICEKIT_VERSION)
DEVICEKIT_SUFFIX	:= tar.gz
DEVICEKIT_URL		:= http://hal.freedesktop.org/releases/$(DEVICEKIT).$(DEVICEKIT_SUFFIX)
DEVICEKIT_SOURCE	:= $(SRCDIR)/$(DEVICEKIT).$(DEVICEKIT_SUFFIX)
DEVICEKIT_DIR		:= $(BUILDDIR)/$(DEVICEKIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DEVICEKIT_SOURCE):
	@$(call targetinfo)
	@$(call get, DEVICEKIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/devicekit.extract:
	@$(call targetinfo)
	@$(call clean, $(DEVICEKIT_DIR))
	@$(call extract, DEVICEKIT)
	@$(call patchin, DEVICEKIT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DEVICEKIT_PATH	:= PATH=$(CROSS_PATH)
DEVICEKIT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DEVICEKIT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--disable-largefile \
	--disable-ansi \
	--disable-man-pages \
	--disable-gtk-doc \
	--with-gnu-ld

$(STATEDIR)/devicekit.prepare:
	@$(call targetinfo)
	@$(call clean, $(DEVICEKIT_DIR)/config.cache)
	cd $(DEVICEKIT_DIR) && \
		$(DEVICEKIT_PATH) $(DEVICEKIT_ENV) \
		./configure $(DEVICEKIT_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/devicekit.compile:
	@$(call targetinfo)
	cd $(DEVICEKIT_DIR) && $(DEVICEKIT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/devicekit.install:
	@$(call targetinfo)
	@$(call install, DEVICEKIT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/devicekit.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  devicekit)
	@$(call install_fixup, devicekit,PACKAGE,devicekit)
	@$(call install_fixup, devicekit,PRIORITY,optional)
	@$(call install_fixup, devicekit,VERSION,$(DEVICEKIT_VERSION))
	@$(call install_fixup, devicekit,SECTION,base)
	@$(call install_fixup, devicekit,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, devicekit,DEPENDS,)
	@$(call install_fixup, devicekit,DESCRIPTION,missing)

	@$(call install_copy, devicekit, 0, 0, 0755, -, /usr/bin/devkit)
	@$(call install_copy, devicekit, 0, 0, 0644, -, /usr/share/dbus-1/interfaces/org.freedesktop.DeviceKit.xml)
	@$(call install_copy, devicekit, 0, 0, 0644, -, /usr/share/dbus-1/system-services/org.freedesktop.DeviceKit.service)
	@$(call install_copy, devicekit, 0, 0, 0644, /usr/var/run/devkit) # FIXME what does this do?
	@$(call install_copy, devicekit, 0, 0, 0644, -, /usr/lib/libdevkit-gobject.so.0.0.0)
	@$(call install_link, devicekit, libdevkit-gobject.so.0.0.0, /usr/lib/libdevkit-gobject.so.0)
	@$(call install_link, devicekit, libdevkit-gobject.so.0.0.0, /usr/lib/libdevkit-gobject.so)
	@$(call install_copy, devicekit, 0, 0, 0644, -, /usr/libexec/devkit-daemon)
	@$(call install_copy, devicekit, 0, 0, 0644, -, /etc/udev/rules.d/98-devkit.rules)
	@$(call install_copy, devicekit, 0, 0, 0644, -, /etc/dbus-1/system.d/org.freedesktop.DeviceKit.conf)

	@$(call install_finish, devicekit)

	@$(call touch)

# vim: syntax=make
