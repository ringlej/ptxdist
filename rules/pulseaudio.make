# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PULSEAUDIO) += pulseaudio

#
# Paths and names
#
PULSEAUDIO_VERSION	:= 7.1
PULSEAUDIO_MD5		:= 9d0a9817b632cac8e3f3834d7eb1c99d
PULSEAUDIO		:= pulseaudio-$(PULSEAUDIO_VERSION)
PULSEAUDIO_SUFFIX	:= tar.xz
PULSEAUDIO_URL		:= http://freedesktop.org/software/pulseaudio/releases/$(PULSEAUDIO).$(PULSEAUDIO_SUFFIX)
PULSEAUDIO_SOURCE	:= $(SRCDIR)/$(PULSEAUDIO).$(PULSEAUDIO_SUFFIX)
PULSEAUDIO_DIR		:= $(BUILDDIR)/$(PULSEAUDIO)
PULSEAUDIO_LICENSE	:= MIT, GPL-2.0+, LGPL-2.1+, Rdisc, ADRIAN
PULSEAUDIO_LICENSE_FILES	:= \
	file://LICENSE;md5=d9ae089c8dc5339f8ac9d8563038a29f \
	file://GPL;md5=4325afd396febcb659c36b49533135d4 \
	file://LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
	file://src/pulsecore/g711.c;startline=2;endline=24;md5=663902612456e1794f328632f8b6a20a \
	file://src/modules/echo-cancel/adrian-license.txt;md5=abbab006a561fbffccedf1c3531f34ab

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PULSEAUDIO_CONF_ENV	:= \
	$(CROSS_ENV) \
	ORCC=orcc

#
# autoconf
#
PULSEAUDIO_CONF_TOOL	:= autoconf
PULSEAUDIO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--enable-atomic-arm-linux-helpers \
	--enable-atomic-arm-memory-barrier \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_NEON)-neon-opt \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-x11 \
	--disable-tests \
	--disable-samplerate \
	--disable-oss-output \
	--disable-oss-wrapper \
	--disable-coreaudio-output \
	--enable-alsa \
	--disable-esound \
	--disable-solaris \
	--disable-waveout \
	--disable-glib2 \
	--disable-gtk3 \
	--disable-gconf \
	--disable-avahi \
	--disable-jack \
	--disable-asyncns \
	--disable-tcpwrap \
	--disable-tcpwrap \
	--disable-dbus \
	--disable-bluez4 \
	--disable-bluez5 \
	--disable-bluez5-ofono-headset \
	--disable-bluez5-native-headset \
	--enable-udev \
	--disable-hal-compat \
	$(GLOBAL_IPV6_OPTION) \
	--disable-openssl \
	--disable-xen \
	--disable-gcov \
	--enable-orc \
	--enable-systemd-daemon \
	--disable-systemd-login \
	--enable-systemd-journal \
	--disable-manpages \
	--disable-per-user-esound-socket \
	--disable-mac-universal \
	--disable-webrtc-aec \
	--enable-adrian-aec \
	--disable-default-build-tests \
	--disable-legacy-database-entry-format \
	--disable-static-bins \
	--disable-force-preopen \
	--with-caps \
	--with-database=simple \
	--without-fftw \
	--without-speex \
	--without-soxr \
	--with-systemduserunitdir=/usr/lib/systemd/user

PULSEAUDIO_LDFLAGS	:= -Wl,-rpath,/usr/lib/pulseaudio:/usr/lib/pulse-$(PULSEAUDIO_VERSION)/modules

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pulseaudio.install:
	@$(call targetinfo)
	@$(call world/install, PULSEAUDIO)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pulseaudio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pulseaudio)
	@$(call install_fixup, pulseaudio,PRIORITY,optional)
	@$(call install_fixup, pulseaudio,SECTION,base)
	@$(call install_fixup, pulseaudio,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, pulseaudio,DESCRIPTION,missing)

	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/client.conf)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/daemon.conf)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/system.pa)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/default.pa)

	@$(call install_alternative, pulseaudio, 0, 0, 0644, \
		/lib/systemd/system/pulseaudio.service)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, \
		/lib/systemd/system/pulseaudio.socket)
	@$(call install_link, pulseaudio, ../pulseaudio.socket, \
		/lib/systemd/system/sockets.target.wants/pulseaudio.socket)

	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pulseaudio)
	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pactl)
	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pacmd)
	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pacat)
	@$(call install_link, pulseaudio, pacat, /usr/bin/pamon)
	@$(call install_link, pulseaudio, pacat, /usr/bin/paplay)
	@$(call install_link, pulseaudio, pacat, /usr/bin/parec)
	@$(call install_link, pulseaudio, pacat, /usr/bin/parecord)

	@$(call install_lib, pulseaudio, 0, 0, 0644, libpulse)
	@$(call install_lib, pulseaudio, 0, 0, 0644, libpulse-simple)
	@$(call install_lib, pulseaudio, 0, 0, 0644, libpulsecore-$(PULSEAUDIO_VERSION))
	@$(call install_lib, pulseaudio, 0, 0, 0644, pulseaudio/libpulsecommon-$(PULSEAUDIO_VERSION))
	@$(call install_tree, pulseaudio, 0, 0, -, /usr/lib/pulse-$(PULSEAUDIO_VERSION)/modules)

	@$(call install_tree, pulseaudio, 0, 0, -, /usr/share/pulseaudio)

	@$(call install_finish, pulseaudio)

	@$(call touch)

# vim: syntax=make
