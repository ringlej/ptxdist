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

#
# autoconf
#
LIBNET_CONF_TOOL	:= autoconf

LIBNET_CONF_ENV		:= \
	$(CROSS_ENV) \
	libnet_cv_have_packet_socket=yes

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnet)
	@$(call install_fixup, libnet,PRIORITY,optional)
	@$(call install_fixup, libnet,SECTION,base)
	@$(call install_fixup, libnet,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libnet,DESCRIPTION,missing)

	@$(call install_lib, libnet, 0, 0, 0644, libnet)

	@$(call install_finish, libnet)

	@$(call touch)

# vim: syntax=make
