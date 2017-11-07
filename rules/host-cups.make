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
HOST_PACKAGES-$(PTXCONF_HOST_CUPS) += host-cups

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
# The --with-* options are only used to specify strings, --without-* does
# nothing. So we're omitting them here. The only exception is
# --with-components=core, which we are setting to only builds libcups* (which is
# needed by ppdc).
#
# --libdir has to end with a /, otherwise due to broken autoconf magic, the libs
# end up in ${prefix}/lib64, which is not what we want.
#
HOST_CUPS_CONF_TOOL	:= autoconf
HOST_CUPS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--libdir=/lib/ \
	--disable-mallinfo \
	--disable-libpaper \
	--disable-libusb \
	--disable-tcp-wrappers \
	--disable-acl \
	--disable-dbus \
	--disable-libtool-unsupported \
	--disable-debug \
	--disable-debug-guards \
	--disable-debug-printfs \
	--disable-unit-tests \
	--disable-relro \
	--disable-gssapi \
	--enable-threads \
	--disable-ssl \
	--disable-cdsassl \
	--disable-gnutls \
	--disable-pam \
	--disable-largefile \
	--disable-avahi \
	--disable-dnssd \
	--disable-launchd \
	--disable-systemd \
	--disable-upstart \
	--disable-page-logging \
	--disable-browsing \
	--disable-default-shared \
	--disable-raw-printing \
	--disable-webif \
	--with-components=core

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-cups.compile:
	@$(call targetinfo)
	@$(call world/compile, HOST_CUPS)
	@# ppdc isn't built by --with-components=core
	@$(call compile, HOST_CUPS, -C ${HOST_CUPS_DIR}/ppdc)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_CUPS_MAKE_ENV := \
	DSTROOT=$(HOST_CUPS_PKGDIR)

$(STATEDIR)/host-cups.install:
	@$(call targetinfo)
	@$(call world/install, HOST_CUPS)
	@# ppdc isn't included in --with-components=core
	@$(call compile, HOST_CUPS, -C ${HOST_CUPS_DIR}/ppdc install)
	@$(call touch)

CROSS_PPDC := $(PTXDIST_SYSROOT_CROSS)/bin/ppdc

$(STATEDIR)/host-cups.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_CUPS)

	@( \
		echo '#!/bin/sh'; \
		echo 'CUPS_DATADIR=$(PTXDIST_SYSROOT_HOST)/share/cups $(PTXDIST_SYSROOT_HOST)/bin/ppdc "$$@"'; \
	) > $(CROSS_PPDC)
	@chmod +x $(CROSS_PPDC)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/host-cups.clean:
	@$(call targetinfo)
	@$(call clean_pkg, HOST_CUPS)
	@rm -vf $(CROSS_PPDC)

# vim: ft=make ts=8 tw=80
