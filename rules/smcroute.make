# -*-makefile-*-
#
# Copyright (C) 2018 by Ladislav Michl <ladis@linux-mips.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SMCROUTE) += smcroute

#
# Paths and names
#
SMCROUTE_VERSION	:= 2.4.0
SMCROUTE_MD5		:= 6b4cd5ceb0476c0fbe5c1da093234f13
SMCROUTE		:= smcroute-$(SMCROUTE_VERSION)
SMCROUTE_SUFFIX		:= tar.xz
SMCROUTE_URL		:= \
	https://github.com/troglobit/smcroute/releases/download/$(SMCROUTE_VERSION)/$(SMCROUTE).$(SMCROUTE_SUFFIX)
SMCROUTE_SOURCE		:= $(SRCDIR)/$(SMCROUTE).$(SMCROUTE_SUFFIX)
SMCROUTE_DIR		:= $(BUILDDIR)/$(SMCROUTE)
SMCROUTE_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SMCROUTE_CONF_TOOL	:= autoconf
SMCROUTE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-mrdisc \
	$(GLOBAL_IPV6_OPTION) \
	--$(call ptx/endis,PTXCONF_SMCROUTE_CLIENT)-client \
	--$(call ptx/endis,PTXCONF_SMCROUTE_CONFIG)-config \
	--$(call ptx/wwo,PTXCONF_SMCROUTE_LIBCAP)-libcap \
	--with-systemd=/usr/lib/systemd/system

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/smcroute.install:
	@$(call targetinfo)
	@$(call world/install, SMCROUTE)

ifdef PTXCONF_SMCROUTE_CONFIG
	@install -vD -m 644 "$(SMCROUTE_DIR)/smcroute.conf" \
		"$(SMCROUTE_PKGDIR)/etc"
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/smcroute.targetinstall:
	@$(call targetinfo)

	@$(call install_init, smcroute)
	@$(call install_fixup, smcroute,PRIORITY,optional)
	@$(call install_fixup, smcroute,SECTION,base)
	@$(call install_fixup, smcroute,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, smcroute,DESCRIPTION,missing)

ifdef PTXCONF_SMCROUTE_CONFIG
	@$(call install_alternative, smcroute, 0, 0, 0644, /etc/smcroute.conf)
endif
ifdef PTXCONF_SMCROUTE_SYSTEMD_UNIT
	@$(call install_alternative, smcroute, 0, 0, 0644, \
		/usr/lib/systemd/system/smcroute.service)
endif
ifdef PTXCONF_SMCROUTE_CLIENT
	@$(call install_copy, smcroute, 0, 0, 0755, -, /usr/sbin/smcroutectl)
endif
	@$(call install_copy, smcroute, 0, 0, 0755, -, /usr/sbin/smcrouted)

	@$(call install_finish, smcroute)

	@$(call touch)
