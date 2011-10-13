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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_XKBCOMP) += host-xorg-app-xkbcomp

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#HOST_XORG_APP_XKBCOMP_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_APP_XKBCOMP_CONF_TOOL	:= autoconf
#HOST_XORG_APP_XKBCOMP_CONF_OPT	:= $(HOST_AUTOCONF)

#$(STATEDIR)/host-xorg-app-xkbcomp.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(HOST_XORG_APP_XKBCOMP_DIR)/config.cache)
#	cd $(HOST_XORG_APP_XKBCOMP_DIR) && \
#		$(HOST_XORG_APP_XKBCOMP_PATH) $(HOST_XORG_APP_XKBCOMP_ENV) \
#		./configure $(HOST_XORG_APP_XKBCOMP_CONF_OPT)
#	@$(call touch)


# vim: syntax=make
