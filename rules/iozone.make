# -*-makefile-*-
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IOZONE) += iozone

#
# Paths and names
#
IOZONE_VERSION	:= 327
IOZONE		:= iozone3_$(IOZONE_VERSION)
IOZONE_SUFFIX	:= tar
IOZONE_URL	:= http://www.iozone.org/src/current/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_SOURCE	:= $(SRCDIR)/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_DIR	:= $(BUILDDIR)/$(IOZONE)
IOZONE_LICENSE	:= Freeware

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(IOZONE_SOURCE):
	@$(call targetinfo)
	@$(call get, IOZONE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IOZONE_CONF_TOOL	:= autoconf

$(STATEDIR)/iozone.prepare:
	@$(call targetinfo)
	@chmod +x $(IOZONE_DIR)/configure
	@$(call world/prepare, IOZONE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iozone)
	@$(call install_fixup, iozone,PRIORITY,optional)
	@$(call install_fixup, iozone,SECTION,base)
	@$(call install_fixup, iozone,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, iozone,DESCRIPTION,missing)

	@$(call install_copy, iozone, 0, 0, 0755, -, /usr/bin/iozone)
	@$(call install_copy, iozone, 0, 0, 0755, -, /usr/bin/fileop)

	@$(call install_finish, iozone)

	@$(call touch)

# vim: syntax=make
