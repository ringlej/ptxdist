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
HOSTAPD_VERSION	:= 2.5
HOSTAPD_MD5	:= 69f9cec3f76d74f402864a43e4f8624f
HOSTAPD		:= $(HOSTAPD_NAME)-$(HOSTAPD_VERSION)
HOSTAPD_SUFFIX	:= tar.gz
HOSTAPD_URL	:= http://w1.fi/releases/$(HOSTAPD).$(HOSTAPD_SUFFIX)
HOSTAPD_SOURCE	:= $(SRCDIR)/$(HOSTAPD).$(HOSTAPD_SUFFIX)
HOSTAPD_DIR	:= $(BUILDDIR)/$(HOSTAPD)
HOSTAPD_SUBDIR	:= $(HOSTAPD_NAME)
HOSTAPD_DEFCONF	:= $(shell ptxd_get_alternative config/hostapd defconfig && echo $$ptxd_reply)
HOSTAPD_CONFIG	:= $(BUILDDIR)/$(HOSTAPD)/$(HOSTAPD_SUBDIR)/.config
HOSTAPD_LICENSE	:= BSD-3-Clause
HOSTAPD_LICENSE_FILES := \
	file://COPYING;md5=36b27801447e0662ee0138d17fe93880 \
	file://README;md5=7f393579f8b109fe91f3b9765d26c7d3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOSTAPD_MAKE_ENV := \
	$(CROSS_ENV) \
	BINDIR=/usr/sbin
HOSTAPD_INSTALL_ENV := \
	$(HOSTAPD_MAKE_ENV)

$(STATEDIR)/hostapd.prepare:
	@$(call targetinfo)
#	# run 'make clean' as hostapd's build system does not recognize config changes
	@-$(HOSTAPD_MAKE_ENV) $(MAKE) -C $(HOSTAPD_DIR)/$(HOSTAPD_SUBDIR) clean
	@cp $(HOSTAPD_DEFCONF) $(HOSTAPD_CONFIG)
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

	@$(call install_finish, hostapd)

	@$(call touch)

# vim: syntax=make
