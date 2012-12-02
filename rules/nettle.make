# -*-makefile-*-
#
# Copyright (C) 2012 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETTLE) += nettle

#
# Paths and names
#
NETTLE_VERSION	:= 2.5
NETTLE_MD5	:= d66882e6ad31a9f651b73d7a1a93bd4c
NETTLE		:= nettle-$(NETTLE_VERSION)
NETTLE_SUFFIX	:= tar.gz
NETTLE_URL	:= http://www.lysator.liu.se/~nisse/archive/$(NETTLE).$(NETTLE_SUFFIX)
NETTLE_SOURCE	:= $(SRCDIR)/$(NETTLE).$(NETTLE_SUFFIX)
NETTLE_DIR	:= $(BUILDDIR)/$(NETTLE)
NETTLE_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETTLE_CONF_TOOL	:= autoconf
NETTLE_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-public-key \
	--disable-openssl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nettle.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nettle)
	@$(call install_fixup, nettle,PRIORITY,optional)
	@$(call install_fixup, nettle,SECTION,base)
	@$(call install_fixup, nettle,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, nettle,DESCRIPTION,missing)

	@$(call install_lib, nettle, 0, 0, 0644, libnettle)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/nettle-hash)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/sexp-conv)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/nettle-lfib-stream)

	@$(call install_finish, nettle)

	@$(call touch)

# vim: syntax=make
