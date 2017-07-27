# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RADVD) += radvd

#
# Paths and names
#
RADVD_VERSION	:= 2.16
RADVD		:= radvd-$(RADVD_VERSION)
RADVD_SUFFIX	:= tar.xz
RADVD_MD5	:= d2de8237538b23574ba3a8e495bd9c20
RADVD_URL	:= http://www.litech.org/radvd/dist/$(RADVD).$(RADVD_SUFFIX)
RADVD_DIR	:= $(BUILDDIR)/$(RADVD)
RADVD_SOURCE	:= $(SRCDIR)/$(RADVD).$(RADVD_SUFFIX)
RADVD_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
RADVD_CONF_TOOL	:= autoconf
RADVD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--without-check \
	--with-systemdsystemunitdir=/usr/lib/systemd/system

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/radvd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, radvd)
	@$(call install_fixup, radvd, PRIORITY, optional)
	@$(call install_fixup, radvd, SECTION, base)
	@$(call install_fixup, radvd, AUTHOR, "Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, radvd, DESCRIPTION, missing)

	@$(call install_copy, radvd, 0, 0, 0755, -, /usr/sbin/radvd)
	@$(call install_copy, radvd, 0, 0, 0755, -, /usr/sbin/radvdump)
	@$(call install_alternative, radvd, 0, 0, 0644, /etc/radvd.conf)

ifdef PTXCONF_RADVD_SYSTEMD_SERVICE
	@$(call install_alternative, radvd, 0, 0, 0644, /usr/lib/systemd/system/radvd.service)
	@$(call install_link, radvd, ../radvd.service, /usr/lib/systemd/system/network.target.wants/radvd.service)
endif

	@$(call install_finish, radvd)

	@$(call touch)

# vim: syntax=make
