# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCOAP) += libcoap

#
# Paths and names
#
LIBCOAP_VERSION	:= 4.1.1
LIBCOAP_MD5	:= 2ab6daf1f187f02d25b77c39c2ecc56b
LIBCOAP		:= libcoap-$(LIBCOAP_VERSION)
LIBCOAP_SUFFIX	:= tar.gz
LIBCOAP_URL	:= $(call ptx/mirror, SF, libcoap/$(LIBCOAP).$(LIBCOAP_SUFFIX))
LIBCOAP_SOURCE	:= $(SRCDIR)/$(LIBCOAP).$(LIBCOAP_SUFFIX)
LIBCOAP_DIR	:= $(BUILDDIR)/$(LIBCOAP)
LIBCOAP_LICENSE	:= BSD AND GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCOAP_CONF_TOOL	:= autoconf
LIBCOAP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--enable-async \
	--enable-block \
	--enable-observe \
	--enable-query-filter \
	--with-max-pdu-size=10240

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcoap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcoap)
	@$(call install_fixup, libcoap,PRIORITY,optional)
	@$(call install_fixup, libcoap,SECTION,base)
	@$(call install_fixup, libcoap,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, libcoap,DESCRIPTION,missing)

	@$(call install_lib, libcoap, 0, 0, 0644, libcoap)

	@$(call install_copy, libcoap, 0, 0, 0755, -, /usr/bin/coap-server)
	@$(call install_copy, libcoap, 0, 0, 0755, -, /usr/bin/coap-client)

	@$(call install_finish, libcoap)

	@$(call touch)

# vim: syntax=make
