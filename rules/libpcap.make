# -*-makefile-*-
#
# Copyright (C) 2003-2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCAP) += libpcap

#
# Paths and names
#
LIBPCAP_VERSION	:= 1.5.3
LIBPCAP_MD5	:= 7e7321fb3aff2f2bb05c8229f3795d4a
LIBPCAP		:= libpcap-$(LIBPCAP_VERSION)
LIBPCAP_SUFFIX	:= tar.gz
LIBPCAP_URL	:= http://www.tcpdump.org/release/$(LIBPCAP).$(LIBPCAP_SUFFIX)
LIBPCAP_SOURCE	:= $(SRCDIR)/$(LIBPCAP).$(LIBPCAP_SUFFIX)
LIBPCAP_DIR	:= $(BUILDDIR)/$(LIBPCAP)
LIBPCAP_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPCAP_PATH := PATH=$(CROSS_PATH)
LIBPCAP_ENV  := \
	$(CROSS_ENV) \
	ac_cv_linux_vers=2 \
	ac_cv_lib_nl_nl_socket_alloc=no \
	ac_cv_lib_nl_nl_handle_alloc=no

LIBPCAP_COMPILE_ENV := \
	$(CROSS_ENV_CFLAGS) \
	$(CROSS_ENV_CPPFLAGS) \
	$(CROSS_ENV_LDFLAGS) \
	$(CROSS_ENV_AR)

#
# autoconf
#
LIBPCAP_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--enable-protochain \
	--disable-optimizer-dbg \
	--disable-yydebug \
	--disable-universal \
	--enable-shared \
	--$(call ptx/endis, PTXCONF_LIBPCAP_BLUETOOTH)-bluetooth \
	--disable-canusb \
	--disable-can \
	--disable-dbus \
	--with-libnl=$(SYSROOT)/usr \
	--without-dag \
	--without-septel

ifdef PTXCONF_ARCH_MINGW
LIBPCAP_AUTOCONF += --with-pcap=null
LIBPCAP_ENV += ac_cv_lbl_gcc_fixincludes=yes
else
LIBPCAP_AUTOCONF += --with-pcap=linux
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpcap.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libpcap)
	@$(call install_fixup, libpcap,PRIORITY,optional)
	@$(call install_fixup, libpcap,SECTION,base)
	@$(call install_fixup, libpcap,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libpcap,DESCRIPTION,missing)

	@$(call install_lib, libpcap, 0, 0, 0644, libpcap)

	@$(call install_finish, libpcap)

	@$(call touch)

# vim: syntax=make
