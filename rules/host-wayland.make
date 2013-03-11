# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_WAYLAND) += host-wayland

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_WAYLAND_CONF_TOOL	:= autoconf
HOST_WAYLAND_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--enable-scanner \
	--disable-documentation

# vim: syntax=make
