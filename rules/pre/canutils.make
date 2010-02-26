# -*-makefile-*-
#
# Copyright (C) 2003, 2010 by Marc Kleine-Budde <kleine-budde@gmx.de>
#           (C) 2008 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

CANUTILS_VERSION	:= $(call remove_quotes,$(PTXCONF_CANUTILS_VERSION))
_version_temp		:= $(subst ., ,$(CANUTILS_VERSION))
CANUTILS_VERSION_MAJOR	:= $(word 1,$(_version_temp))
CANUTILS_VERSION_MINOR	:= $(word 2,$(_version_temp))
CANUTILS_VERSION_MICRO	:= $(word 3,$(_version_temp))

_version_temp		:=

# vim: syntax=make
