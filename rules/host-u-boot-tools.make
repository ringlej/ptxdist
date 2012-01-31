# -*-makefile-*-
#
# Copyright (C) 2012 by Andreas Bießmann <andreas@biessmann.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_U_BOOT_TOOLS) += host-u-boot-tools


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_U_BOOT_TOOLS_CONF_TOOL	:= NO
HOST_U_BOOT_TOOLS_MAKE_OPT	:= tools

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-u-boot-tools.install:
	@$(call targetinfo)
	install -D $(HOST_U_BOOT_TOOLS_DIR)/tools/mkimage \
		$(HOST_U_BOOT_TOOLS_PKGDIR)/bin/mkimage

	@$(call touch)

# vim: syntax=make
