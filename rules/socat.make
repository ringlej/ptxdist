# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_SOCAT) += socat

#
# Paths and names
#

SOCAT_VERSION	:= 1.7.3.2
SOCAT_MD5	:= aec3154f7854580cfab0c2d81e910519
SOCAT		:= socat-$(SOCAT_VERSION)
SOCAT_SUFFIX	:= tar.gz
SOCAT_URL	:= http://www.dest-unreach.org/socat/download/$(SOCAT).$(SOCAT_SUFFIX)
SOCAT_SOURCE	:= $(SRCDIR)/$(SOCAT).$(SOCAT_SUFFIX)
SOCAT_DIR	:= $(BUILDDIR)/$(SOCAT)
SOCAT_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SOCAT_CONF_TOOL	:= autoconf
SOCAT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-help \
	--enable-stdio \
	--enable-fdnum \
	--enable-file \
	--enable-creat \
	--enable-gopen \
	--enable-pipe \
	--enable-termios \
	--enable-unix \
	--enable-abstract-unixsocket \
	--enable-ip4 \
	--$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-ip6 \
	--enable-rawip \
	--enable-genericsocket \
	--enable-interface \
	--enable-tcp \
	--enable-udp \
	--enable-sctp \
	--enable-listen \
	--enable-socks4 \
	--enable-socks4a \
	--enable-proxy \
	--enable-exec \
	--enable-system \
	--enable-pty \
	--enable-ext2 \
	--disable-readline \
	--$(call ptx/endis, PTXCONF_SOCAT_OPENSSL)-openssl \
	--disable-fips \
	--enable-tun \
	--enable-sycls \
	--enable-filan \
	--enable-retry \
	--enable-msglevel=0 \
	--disable-libwrap


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/socat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, socat)
	@$(call install_fixup, socat,PRIORITY,optional)
	@$(call install_fixup, socat,SECTION,base)
	@$(call install_fixup, socat,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, socat,DESCRIPTION,missing)

	@$(call install_copy, socat, 0, 0, 0755, -, /usr/bin/procan)
	@$(call install_copy, socat, 0, 0, 0755, -, /usr/bin/filan)
	@$(call install_copy, socat, 0, 0, 0755, -, /usr/bin/socat)

	@$(call install_finish, socat)

	@$(call touch)

# vim: syntax=make
