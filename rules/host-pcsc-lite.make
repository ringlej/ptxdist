# -*-makefile-*-
#
# Copyright (C) 2016 by Steffen Trumtrar <s.trumtrar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PCSC_LITE) += host-pcsc-lite

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PCSC_LITE_CONF_TOOL := autoconf
HOST_PCSC_LITE_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--disable-libusb \
	--disable-libudev

# vim: syntax=make
