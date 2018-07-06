# -*-makefile-*-
#
# Copyright (C) 2016 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NSS) += nss

#
# Paths and names
#
NSS_VERSION	:= 3.37
NSS_MD5		:= f86a8c5b15aa12a1deb05995726257dd
NSS		:= nss-$(NSS_VERSION)
NSS_SUFFIX	:= tar.gz
NSS_URL		:= https://ftp.mozilla.org/pub/security/nss/releases/NSS_$(subst .,_,$(NSS_VERSION))_RTM/src/$(NSS).$(NSS_SUFFIX)
NSS_SOURCE	:= $(SRCDIR)/$(NSS).$(NSS_SUFFIX)
NSS_DIR		:= $(BUILDDIR)/$(NSS)
NSS_SUBDIR	:= nss
NSS_LICENSE	:= MPL-2.0
NSS_LICENSE_FILES	:= \
	file://$(NSS_SUBDIR)/COPYING;md5=3b1e88e1b9c0b5a4b2881d46cce06a18
# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NSS_CONF_TOOL	:= NO

NSS_ARCH := $(call remove_quotes,$(PTXCONF_ARCH_STRING))
ifdef PTXCONF_ARCH_ARM64
NSS_ARCH := aarch64
endif

NSS_MAKE_ENV := \
	$(CROSS_ENV) \
	CCC=$(CROSS_CXX) \
	CPU_ARCH=$(NSS_ARCH) \
	CROSS_COMPILE=1 \
	NATIVE_CC="gcc" \
	BUILD_OPT=1 \
	MOZILLA_CLIENT=1 \
	NS_USE_GCC=1 \
	NSS_USE_SYSTEM_SQLITE=1 \
	NSS_ENABLE_ECC=1 \
	NSS_DISABLE_GTESTS=1 \
	NSPR_INCLUDE_DIR=$(SYSROOT)/usr/include/nspr \
	USE_64=$(call ptx/ifdef, PTXCONF_ARCH_LP64,1)

NSS_MAKE_PAR := NO
NSS_MAKE_OPT := \
	OS_ARCH=Linux \
	OS_RELEASE=$(PTXCONF_KERNEL_VERSION) \
	OS_TEST=$(NSS_ARCH)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

NSS_INSTALL_OPT := \
	$(NSS_MAKE_OPT) \
	install

NSS_LIBS := \
	libnss3 \
	libnssutil3 \
	libsmime3 \
	libssl3 \
	libfreebl3 \
	libfreeblpriv3 \
	libnssckbi \
	libnssdbm3 \
	libsoftokn3


$(STATEDIR)/nss.install:
	@$(call targetinfo)
	@$(call world/install, NSS)

	@$(foreach lib,$(NSS_LIBS), \
		install -v -m644 -D $(NSS_DIR)/dist/*/lib/$(lib).so \
			$(NSS_PKGDIR)/usr/lib/$(lib).so$(ptx/nl))

	install -d $(NSS_PKGDIR)/usr/lib/pkgconfig/
	VERSION=$(NSS_VERSION) ptxd_replace_magic \
		$(NSS_DIR)/nss/nss.pc.in > $(NSS_PKGDIR)/usr/lib/pkgconfig/nss.pc

	@install -v -d $(NSS_PKGDIR)/usr/include/nss
	@install -v -m 644 -t $(NSS_PKGDIR)/usr/include/nss $(NSS_DIR)/dist/public/nss/*

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nss.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nss)
	@$(call install_fixup, nss,PRIORITY,optional)
	@$(call install_fixup, nss,SECTION,base)
	@$(call install_fixup, nss,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, nss,DESCRIPTION,missing)

	@$(foreach lib,$(NSS_LIBS), \
		$(call install_copy, nss, 0, 0, 0755, -, /usr/lib/$(lib).so)$(ptx/nl))

	@$(call install_finish, nss)

	@$(call touch)

# vim: syntax=make
