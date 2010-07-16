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

$(STATEDIR)/berlios-can-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  berlios-can-utils)
	@$(call install_fixup, berlios-can-utils,PRIORITY,optional)
	@$(call install_fixup, berlios-can-utils,SECTION,base)
	@$(call install_fixup, berlios-can-utils,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, berlios-can-utils,DESCRIPTION,missing)

ifdef PTXCONF_BERLIOS_CAN_UTILS_ASC2LOG 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/asc2log)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_BCMSERVER 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/bcmserver)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANBUSLOAD 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/canbusload)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANDUMP 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/candump)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANFDTEST 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/canfdtest)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANGEN 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/cangen)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANLOGSERVER 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/canlogserver)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANPLAYER 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/canplayer)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANSEND 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/cansend)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_CANSNIFFER 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/cansniffer)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_LOG2ASC 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/log2asc)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_LOG2LONG 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/log2long)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_SLCAN_ATTACH 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/slcan_attach)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_SLCAND 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/slcand)
endif

ifdef PTXCONF_BERLIOS_CAN_UTILS_SLCANPTY 
	@$(call install_copy, berlios-can-utils, 0, 0, 0755, -, /usr/bin/slcanpty)
endif

	@$(call install_finish, berlios-can-utils)

	@$(call touch)

# vim: syntax=make
