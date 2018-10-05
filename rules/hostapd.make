# -*-makefile-*-
#
# Copyright (C) 2013 by Matthias Fend <matthias.fend@wolfvision.com>
#               2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HOSTAPD) += hostapd

#
# Paths and names
#
HOSTAPD_NAME	:= hostapd
HOSTAPD_VERSION	:= 2.6
HOSTAPD_MD5	:= eaa56dce9bd8f1d195eb62596eab34c7
HOSTAPD		:= $(HOSTAPD_NAME)-$(HOSTAPD_VERSION)
HOSTAPD_SUFFIX	:= tar.gz
HOSTAPD_URL	:= http://w1.fi/releases/$(HOSTAPD).$(HOSTAPD_SUFFIX)
HOSTAPD_SOURCE	:= $(SRCDIR)/$(HOSTAPD).$(HOSTAPD_SUFFIX)
HOSTAPD_DIR	:= $(BUILDDIR)/$(HOSTAPD)
HOSTAPD_SUBDIR	:= $(HOSTAPD_NAME)
# Use '=' to delay $(shell ...) calls until this is needed
HOSTAPD_CONFIG	 = $(call ptx/get-alternative, config/hostapd, defconfig)
HOSTAPD_DOTCONFIG := $(BUILDDIR)/$(HOSTAPD)/$(HOSTAPD_SUBDIR)/.config
HOSTAPD_LICENSE	:= BSD-3-Clause
HOSTAPD_LICENSE_FILES := \
	file://COPYING;md5=292eece3f2ebbaa25608eed8464018a3 \
	file://README;md5=3f01d778be8f953962388307ee38ed2b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOSTAPD_MAKE_ENV := \
	$(CROSS_ENV) \
	BINDIR=/usr/sbin

$(STATEDIR)/hostapd.prepare:
	@$(call targetinfo)
#	# run 'make clean' as hostapd's build system does not recognize config changes
	@-$(HOSTAPD_MAKE_ENV) $(MAKE) -C $(HOSTAPD_DIR)/$(HOSTAPD_SUBDIR) clean
	@cp $(HOSTAPD_CONFIG) $(HOSTAPD_DOTCONFIG)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hostapd.install:
	@$(call targetinfo)
	@$(call world/install, HOSTAPD)
	@install -v -m644 -D $(HOSTAPD_DIR)/hostapd/hostapd.conf \
		$(HOSTAPD_PKGDIR)/etc/hostapd/hostapd.conf
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hostapd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hostapd)
	@$(call install_fixup, hostapd,PRIORITY,optional)
	@$(call install_fixup, hostapd,SECTION,base)
	@$(call install_fixup, hostapd,AUTHOR,"Matthias Fend <matthias.fend@wolfvision.com>")
	@$(call install_fixup, hostapd,DESCRIPTION,missing)

	@$(call install_copy, hostapd, 0, 0, 0755, -, /usr/sbin/hostapd)
	@$(call install_alternative, hostapd, 0, 0, 0644, /etc/hostapd/hostapd.conf)

	@$(call install_finish, hostapd)

	@$(call touch)

# vim: syntax=make
