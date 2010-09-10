# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BERLIOS_CAN_UTILS) += berlios-can-utils

#
# Paths and names
#
BERLIOS_CAN_UTILS_VERSION	:= r1167
BERLIOS_CAN_UTILS		:= berlios-can-utils-$(BERLIOS_CAN_UTILS_VERSION)
BERLIOS_CAN_UTILS_SUFFIX	:= tar.bz2
BERLIOS_CAN_UTILS_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(BERLIOS_CAN_UTILS).$(BERLIOS_CAN_UTILS_SUFFIX)
BERLIOS_CAN_UTILS_SOURCE	:= $(SRCDIR)/$(BERLIOS_CAN_UTILS).$(BERLIOS_CAN_UTILS_SUFFIX)
BERLIOS_CAN_UTILS_DIR		:= $(BUILDDIR)/$(BERLIOS_CAN_UTILS)
BERLIOS_CAN_UTILS_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BERLIOS_CAN_UTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, BERLIOS_CAN_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BERLIOS_CAN_UTILS_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

BERLIOS_CAN_UTILS_INST-y =
BERLIOS_CAN_UTILS_INST-m =
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ASC2LOG) += /usr/bin/asc2log
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_BCMSERVER) += /usr/bin/bcmserver
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANBUSLOAD) += /usr/bin/canbusload
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANDUMP) += /usr/bin/candump
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANFDTEST) += /usr/bin/canfdtest
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANGEN) += /usr/bin/cangen
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANLOGSERVER) += /usr/bin/canlogserver
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANPLAYER) += /usr/bin/canplayer
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANSEND) += /usr/bin/cansend
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANSNIFFER) += /usr/bin/cansniffer
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_LOG2ASC) += /usr/bin/log2asc
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_LOG2LONG) += /usr/bin/log2long
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_SLCAN_ATTACH) += /usr/bin/slcan_attach
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_SLCAND) += /usr/bin/slcand
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_SLCANPTY) += /usr/bin/slcanpty

$(STATEDIR)/berlios-can-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, berlios-can-utils)
	@$(call install_fixup, berlios-can-utils,PRIORITY,optional)
	@$(call install_fixup, berlios-can-utils,SECTION,base)
	@$(call install_fixup, berlios-can-utils,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, berlios-can-utils,DESCRIPTION,missing)

	@for i in $(BERLIOS_CAN_UTILS_INST-y) $(BERLIOS_CAN_UTILS_INST-m); do \
		$(call install_copy, berlios-can-utils, 0, 0, 0755, -, $$i) \
	done

	@$(call install_finish, berlios-can-utils)

	@$(call touch)

# vim: syntax=make
