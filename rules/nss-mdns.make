# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NSS_MDNS) += nss-mdns

#
# Paths and names
#
NSS_MDNS_VERSION	:= 0.10
NSS_MDNS_MD5		:= 03938f17646efbb50aa70ba5f99f51d7
NSS_MDNS		:= nss-mdns-$(NSS_MDNS_VERSION)
NSS_MDNS_SUFFIX		:= tar.gz
NSS_MDNS_URL		:= http://0pointer.de/lennart/projects/nss-mdns/$(NSS_MDNS).$(NSS_MDNS_SUFFIX)
NSS_MDNS_SOURCE		:= $(SRCDIR)/$(NSS_MDNS).$(NSS_MDNS_SUFFIX)
NSS_MDNS_DIR		:= $(BUILDDIR)/$(NSS_MDNS)
NSS_MDNS_LICENSE	:= LGPLv2.1+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NSS_MDNS_CONF_TOOL	:= autoconf
NSS_MDNS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-lynx \
	--enable-avahi \
	--disable-legacy

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nss-mdns.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nss-mdns)
	@$(call install_fixup, nss-mdns,PRIORITY,optional)
	@$(call install_fixup, nss-mdns,SECTION,base)
	@$(call install_fixup, nss-mdns,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, nss-mdns,DESCRIPTION,missing)

	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns4)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns6)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns_minimal)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns4_minimal)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns6_minimal)

	@$(call install_finish, nss-mdns)

	@$(call touch)

# vim: syntax=make
