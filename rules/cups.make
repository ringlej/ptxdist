# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CUPS) += cups

#
# Paths and names
#
CUPS_VERSION	:= 2.2.5
CUPS		:= cups-$(CUPS_VERSION)
CUPS_MD5	:= 76294dff74c3baf3fdf7c626cd48b873
CUPS_SUFFIX	:= tar.gz
CUPS_URL	:= https://github.com/apple/cups/releases/download/v$(CUPS_VERSION)/$(CUPS)-source.$(CUPS_SUFFIX)
CUPS_SOURCE	:= $(SRCDIR)/$(CUPS)-source.$(CUPS_SUFFIX)
CUPS_DIR	:= $(BUILDDIR)/cups-$(CUPS_VERSION)
CUPS_LICENSE	:= LGPL-2.0-only AND GPL-2.0-only
CUPS_LICENSE_FILES	:= file://LICENSE.txt;md5=f212b4338db0da8cb892e94bf2949460

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CUPS_CONF_ENV	:= \
	$(CROSS_ENV) \
	DSTROOT=$(CUPS_PKGDIR)

#
# autoconf
#
# The --with-* options are only used to specify strings, --without-* does
# mostly nothing. So we're omitting them here.
#
# --enable-mallinfo is currently broken, see
#  https://github.com/apple/cups/issues/5051
#
# libtool support is unsupported upstream. Don't enable it, it will break
# things, until https://github.com/apple/cups/pull/5062 is merged.
#
# --disable-dnssd only refers to Apple's mDNSResponder, not Avahi.
#
# Java, PHP, Perl and Python support for the webinterface is only a runtime
# option, there are no real bindings for it except calling the interpreters.
#
CUPS_CONF_TOOL	:= autoconf
CUPS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-mallinfo \
	--$(call ptx/endis,PTXCONF_CUPS_LIBPAPER)-libpaper \
	--$(call ptx/endis,PTXCONF_CUPS_LIBUSB)-libusb \
	--disable-tcp-wrappers \
	--disable-acl \
	--$(call ptx/endis,PTXCONF_CUPS_DBUS)-dbus \
	--enable-shared \
	--disable-libtool-unsupported \
	--disable-debug \
	--disable-debug-guards \
	--disable-debug-printfs \
	--disable-unit-tests \
	--$(call ptx/endis,PTXCONF_TARGET_HARDEN_RELRO)-relro \
	--disable-gssapi \
	--enable-threads \
	--$(call ptx/endis,PTXCONF_CUPS_SSL)-ssl \
	--disable-cdsassl \
	--$(call ptx/endis,PTXCONF_CUPS_SSL)-gnutls \
	--disable-pam \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis,PTXCONF_CUPS_AVAHI)-avahi \
	--disable-dnssd \
	--disable-launchd \
	--$(call ptx/endis,PTXCONF_CUPS_SYSTEMD_UNIT)-systemd \
	--disable-upstart

# Default config file settings (probably overwritten via projectroot anyways...)
CUPS_CONF_OPT	+= \
	--disable-page-logging \
	--disable-browsing \
	--disable-default-shared \
	--disable-raw-printing \
	--$(call ptx/endis,PTXCONF_CUPS_WEBINTERFACE)-webif \
	--with-components=all \
	--with-cachedir=/var/cache \
	--with-logdir=/var/log \
	--with-rundir=/run \
	--with-rcdir=/etc \
	--with-languages=none \
	--with-cups-user=daemon \
	--with-cups-group=lp

# Scripting languages integrations
CUPS_PHP_PATH	:= \
	$(if PTXCONF_CUPS_PHP5_CLI,/usr/bin/php, \
	$(if PTXCONF_CUPS_PHP5_CGI,/usr/bin/php-cgi))
CUPS_PYTHON_PATH	:= \
	$(if PTXCONF_CUPS_PYTHON2,/usr/bin/python2, \
	$(if PTXCONF_CUPS_PYTHON3,/usr/bin/python3))

CUPS_CONF_OPT	+= \
	$(call ptx/ifdef,PTXCONF_CUPS_JAVA,--with-java=$(PTXCONF_CUPS_JAVA_PATH),--without-java) \
	$(call ptx/ifdef,PTXCONF_CUPS_PERL,--with-perl=/usr/bin/perl,--without-perl) \
	$(call ptx/ifdef,PTXCONF_CUPS_PHP,--with-php=$(CUPS_PHP_PATH),--without-php) \
	$(call ptx/ifdef,PTXCONF_CUPS_PYTHON,--with-python=$(CUPS_PYTHON_PATH),--without-python)

# ----------------------------------------------------------------------------
# Compile & Install
# ----------------------------------------------------------------------------

CUPS_MAKE_ENV	:= \
	DSTROOT=$(CUPS_PKGDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

# CUPS drops many files into its PKGDIR, but instead of patching the build
# system, be explicitly picky about what to install.

$(STATEDIR)/cups.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cups)
	@$(call install_fixup, cups,PRIORITY,optional)
	@$(call install_fixup, cups,SECTION,base)
	@$(call install_fixup, cups,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, cups,DESCRIPTION,missing)

# ----- config files, install as daemon:lp
	@$(call install_copy, cups, daemon, lp, 750, /etc/cups)
	@$(call install_alternative, cups, daemon, lp, 0640, /etc/cups/cups-files.conf)
	@$(call install_alternative, cups, daemon, lp, 0640, /etc/cups/cupsd.conf)
	@$(call install_alternative, cups, daemon, lp, 0600, /etc/cups/classes.conf)
	@$(call install_alternative, cups, daemon, lp, 0600, /etc/cups/client.conf)
	@$(call install_alternative, cups, daemon, lp, 0640, /etc/cups/mailto.conf)
	@$(call install_copy, cups, daemon, lp, 0750, /etc/cups/ppd/)
	@$(call install_alternative_tree, cups, daemon, lp,  /etc/cups/ppd/)
	@$(call install_alternative, cups, daemon, lp, 0600, /etc/cups/printers.conf)
	@$(call install_alternative, cups, daemon, lp, 0640, /etc/cups/snmp.conf)
	@$(call install_alternative, cups, daemon, lp, 0640, /etc/printcap)
	@$(call install_alternative, cups, root, root, 0644, /usr/share/cups/mime/mime.convs)
	@$(call install_alternative, cups, root, root, 0644, /usr/share/cups/mime/mime.types)

ifdef PTXCONF_CUPS_SSL
	@$(call install_copy, cups, daemon, lp, 0750, /etc/cups/ssl/)
	@$(call install_alternative_tree, cups, daemon, lp, /etc/cups/ssl/)
endif

ifdef PTXCONF_CUPS_DBUS
	@$(call install_alternative, cups, root, root, 0644, /etc/dbus-1/system.d/cups.conf)
endif

# ----- libraries
	@$(call install_lib, cups, root, root, 0644, libcups)
	@$(call install_lib, cups, root, root, 0644, libcupsimage)
	@$(call install_lib, cups, root, root, 0644, libcupsmime)
	@$(call install_lib, cups, root, root, 0644, libcupsppdc)

# ----- user and system binaries, with the correct access rights
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/cancel)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/cups-config)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/ipptool)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/lp)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/lpoptions)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/lpq)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/lpr)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/lprm)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/lpstat)

	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/cupsaccept)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/cupsaddsmb)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/cupsctl)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/cupsd)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/cupsfilter)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/lpadmin)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/lpc)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/lpinfo)
	@$(call install_copy, cups, root, root, 0755, -, /usr/sbin/lpmove)

	@$(call install_link, cups, cupsaccept, /usr/sbin/accept)
	@$(call install_link, cups, cupsaccept, /usr/sbin/cupsdisable)
	@$(call install_link, cups, cupsaccept, /usr/sbin/cupsenable)
	@$(call install_link, cups, cupsaccept, /usr/sbin/cupsreject)
	@$(call install_link, cups, cupsaccept, /usr/sbin/reject)

ifdef PTXCONF_CUPS_TEST_TOOLS
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/cupstestdsc)
	@$(call install_copy, cups, root, root, 0755, -, /usr/bin/cupstestppd)
endif

# ----- backends, filters, cgi-bin (if enabled), etc.
	@$(call install_tree, cups, root, root, -, /usr/lib/cups/backend)
	@$(call install_tree, cups, root, root, -, /usr/lib/cups/daemon)
	@$(call install_tree, cups, root, root, -, /usr/lib/cups/filter)
	@$(call install_tree, cups, root, root, -, /usr/lib/cups/monitor)
	@$(call install_tree, cups, root, root, -, /usr/lib/cups/notifier)

ifdef PTXCONF_CUPS_LIBUSB
	@$(call install_alternative, cups, root, root, 0644, \
		/usr/share/cups/usb/org.cups.usb-quirks)
endif

ifdef PTXCONF_CUPS_WEBINTERFACE
	@$(call install_lib, cups, root, root, 0644, libcupscgi)
	@$(call install_tree, cups, root, root, -, /usr/lib/cups/cgi-bin)
	@$(call install_tree, cups, root, root, -, /usr/share/cups/templates)
	@$(call install_tree, cups, root, root, -, /usr/share/doc/cups)
endif

# ----- startup files
ifdef PTXCONF_CUPS_SYSTEMD_UNIT
	@$(call install_alternative, cups, root, root, 0644, \
		/usr/lib/tmpfiles.d/cups.conf)
	@$(call install_alternative, cups, root, root, 0644, \
		/usr/lib/systemd/system/cups.service)
	@$(call install_alternative, cups, root, root, 0644, \
		/usr/lib/systemd/system/cups.socket)
	@$(call install_link, cups, ../cups.service, \
		/usr/lib/systemd/system/printer.target.wants/cups.service)
	@$(call install_link, cups, ../cups.socket, \
		/usr/lib/systemd/system/sockets.target.wants/cups.socket)
endif

ifdef PTXCONF_CUPS_STARTSCRIPT
	@$(call install_alternative, cups, root, root, 0755, /etc/init.d/cups)
	@$(call install_link, cups, ../init.d/cups, \
		/etc/rc.d/$(PTXCONF_CUPS_BBINIT_LINK))
endif

	@$(call install_finish, cups)

	@$(call touch)

# vim: ft=make ts=8 tw=80
