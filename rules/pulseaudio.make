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
PULSEAUDIO_VERSION	:= 6.0
PULSEAUDIO_MD5		:= b691e83b7434c678dffacfa3a027750e
PULSEAUDIO		:= pulseaudio-$(PULSEAUDIO_VERSION)
PULSEAUDIO_SUFFIX	:= tar.xz
PULSEAUDIO_URL		:= http://freedesktop.org/software/pulseaudio/releases/$(PULSEAUDIO).$(PULSEAUDIO_SUFFIX)
PULSEAUDIO_SOURCE	:= $(SRCDIR)/$(PULSEAUDIO).$(PULSEAUDIO_SUFFIX)
PULSEAUDIO_DIR		:= $(BUILDDIR)/$(PULSEAUDIO)
PULSEAUDIO_LICENSE	:= unknown

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
	--with-systemduserunitdir=/usr/lib/systemd/user

PULSEAUDIO_LDFLAGS	:= -Wl,-rpath,/usr/lib/pulseaudio:/usr/lib/pulse-6.0/modules

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
