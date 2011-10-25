# -*-makefile-*-
#
# Copyright (C) 2010 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLUEZ) += bluez

#
# Paths and names
#
BLUEZ_VERSION	:= 4.96
BLUEZ_MD5	:= 296111afac49e3f9035085ac14daf518
BLUEZ		:= bluez-$(BLUEZ_VERSION)
BLUEZ_SUFFIX	:= tar.gz
BLUEZ_URL	:= $(PTXCONF_SETUP_KERNELMIRROR)/bluetooth/$(BLUEZ).$(BLUEZ_SUFFIX)
BLUEZ_SOURCE	:= $(SRCDIR)/$(BLUEZ).$(BLUEZ_SUFFIX)
BLUEZ_DIR	:= $(BUILDDIR)/$(BLUEZ)
BLUEZ_LICENSE	:= GPLv2+ LGPLv2.1+

# the tools don't depend on the generated headers
BLUEZ_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#
# autoconf
#
BLUEZ_CONF_TOOL	:= autoconf
BLUEZ_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--enable-audio \
	--enable-bccmd \
	--disable-capng \
	--enable-datafiles \
	--disable-cups \
	--enable-debug \
	--disable-dfutool \
	--disable-dund \
	--disable-fortify \
	--disable-hal \
	--disable-hid2hci \
	--disable-hidd \
	--enable-input \
	--enable-libtool-lock \
	--disable-maemo6 \
	--enable-network \
	--enable-optimization \
	--disable-pand \
	--disable-pcmcia \
	--disable-pie \
	--disable-pnat \
	--enable-serial \
	--enable-service \
	--enable-shared \
	--disable-static \
	--enable-test \
	--disable-tracer \
	--enable-tools \
	--enable-usb

ifdef PTXCONF_BLUEZ_ALSA
BLUEZ_CONF_OPT += --enable-alsa
else
BLUEZ_CONF_OPT += --disable-alsa
endif

ifdef PTXCONF_BLUEZ_GSTREAMER
BLUEZ_CONF_OPT += --enable-gstreamer
else
BLUEZ_CONF_OPT += --disable-gstreamer
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bluez.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  bluez)
	@$(call install_fixup, bluez,PRIORITY,optional)
	@$(call install_fixup, bluez,SECTION,base)
	@$(call install_fixup, bluez,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, bluez,DESCRIPTION,missing)

	@$(foreach lib,libbluetooth.so.3.11.4, \
	$(call install_copy, bluez, 0, 0, 0644, -, /usr/lib/$(lib)); \
	$(call install_link, bluez, $(lib), /usr/lib/$(basename $(lib))); \
	$(call install_link, bluez, $(lib), /usr/lib/$(basename $(basename $(lib)))); \
	)

ifdef PTXCONF_BLUEZ_ALSA
	@$(foreach alsamod,ctl_bluetooth pcm_bluetooth, \
	$(call install_copy, bluez, 0, 0, 0644, -, /usr/lib/alsa-lib/libasound_module_$(alsamod).so); \
	)
endif

ifdef PTXCONF_BLUEZ_GSTREAMER
	@$(call install_copy, bluez, 0, 0, 0644, -, /usr/lib/gstreamer-0.10/libgstbluetooth.so)
endif

ifdef PTXCONF_BLUEZ_UTILS
	@$(foreach binprogram,ciptool l2ping hcitool rctest rfcomm sdptool, \
	$(call install_copy, bluez, 0, 0, 0755, -, /usr/bin/$(binprogram)); \
	)

	@$(foreach sbinprogram,bccmd hciattach hciconfig, \
	$(call install_copy, bluez, 0, 0, 0755, -, /usr/sbin/$(sbinprogram)); \
	)
endif

ifdef PTXCONF_BLUEZ_INSTALL_TESTSCRIPTS
	@$(foreach testprog, simple-agent simple-service test-telephony test-adapter test-audio \
		test-device test-discovery test-input test-manager test-network test-serial \
		test-service test-telephony test-textfile monitor-bluetooth, \
	$(call install_alternative, bluez, 0, 0, 0755, /test/$(testprog), n, /usr/share/doc/bluez/examples/$(testprog)); \
	)
endif

	@$(call install_copy, bluez, 0, 0, 0755, -, /usr/sbin/bluetoothd)

	@$(call install_copy, bluez, 0, 0, 0644, -, /etc/dbus-1/system.d/bluetooth.conf)
	@$(foreach udevrule, $(notdir $(wildcard $(BLUEZ_PKGDIR)/lib/udev/rules.d/*.rules)), \
	$(call install_copy, bluez, 0, 0, 0644, -, /lib/udev/rules.d/$(udevrule)); \
	)

	@$(call install_finish, bluez)
	@$(call touch)

# vim: syntax=make
