# -*-makefile-*-
#
# Copyright (C) 2003 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNET) += libnet

#
# Paths and names
#
LIBNET_VERSION	:= 1.1.4
LIBNET		:= libnet-$(LIBNET_VERSION)
LIBNET_SUFFIX	:= tar.gz
LIBNET_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libnet-dev/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_SOURCE	:= $(SRCDIR)/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_DIR	:= $(BUILDDIR)/$(LIBNET)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBNET_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBNET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNET_PATH	:= PATH=$(CROSS_PATH)
LIBNET_ENV 	:= \
	$(CROSS_ENV) \
	ac_libnet_have_packet_socket=yes

#
# autoconf
#
LIBNET_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-pf_packet=yes

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnet)
	@$(call install_fixup, libnet,PACKAGE,libnet)
	@$(call install_fixup, libnet,PRIORITY,optional)
	@$(call install_fixup, libnet,VERSION,$(LIBNET_VERSION))
	@$(call install_fixup, libnet,SECTION,base)
	@$(call install_fixup, libnet,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libnet,DEPENDS,)
	@$(call install_fixup, libnet,DESCRIPTION,missing)

	@$(call install_copy, libnet, 0, 0, 0644, -, /usr/lib/libnet.so.1.5.0)
	@$(call install_link, libnet, libnet.so.1.5.0, /usr/lib/libnet.so.1)
	@$(call install_link, libnet, libnet.so.1.5.0, /usr/lib/libnet.so)

	@$(call install_finish, libnet)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libnet_clean:
	rm -rf $(STATEDIR)/libnet.*
	rm -rf $(PKGDIR)/libnet_*
	rm -rf $(LIBNET_DIR)

# vim: syntax=make
