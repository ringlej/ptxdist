# -*-makefile-*-
#
# Copyright (C) 2015 by Jan Luebbe <jlu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_IMA_EVM_UTILS) += host-ima-evm-utils

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_IMA_EVM_UTILS_CONF_TOOL	:= autoconf

# vim: syntax=make
