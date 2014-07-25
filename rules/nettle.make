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
NETTLE_VERSION	:= 2.7.1
NETTLE_MD5	:= 003d5147911317931dd453520eb234a5
NETTLE		:= nettle-$(NETTLE_VERSION)
NETTLE_SUFFIX	:= tar.gz
NETTLE_URL	:= http://www.lysator.liu.se/~nisse/archive/$(NETTLE).$(NETTLE_SUFFIX)
NETTLE_SOURCE	:= $(SRCDIR)/$(NETTLE).$(NETTLE_SUFFIX)
NETTLE_DIR	:= $(BUILDDIR)/$(NETTLE)
NETTLE_LICENSE	:= unknown
NETTLE_MAKE_PAR := NO

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
	--enable-assembler \
	--disable-openssl \
	--disable-gcov \
	--disable-documentation \
	--$(call ptx/endis,PTXCONF_ARCH_ARM_NEON)-arm-neon

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
	@$(call install_lib, nettle, 0, 0, 0644, libhogweed)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/nettle-hash)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/sexp-conv)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/nettle-lfib-stream)

	@$(call install_finish, nettle)

	@$(call touch)

# vim: syntax=make
