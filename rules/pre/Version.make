# -*-makefile-*-
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#           (C) 2008 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

KERNEL_VERSION		:= $(call remove_quotes,$(PTXCONF_KERNEL_VERSION))
_version_temp		:= $(subst ., ,$(KERNEL_VERSION))
KERNEL_VERSION_MAJOR	:= $(word 1,$(_version_temp))
KERNEL_VERSION_MINOR	:= $(word 2,$(_version_temp))

GCC_VERSION		:= $(call remove_quotes,$(PTXCONF_CROSSCHAIN_CHECK))
_version_temp		:= $(subst ., ,$(GCC_VERSION))
GCC_VERSION_MAJOR	:= $(word 1,$(_version_temp))
GCC_VERSION_MINOR	:= $(word 2,$(_version_temp))
GCC_VERSION_MICRO	:= $(word 3,$(_version_temp))

GLIBC_VERSION		:= $(call remove_quotes,$(PTXCONF_GLIBC_VERSION))
_version_temp		:= $(subst ., ,$(GLIBC_VERSION))
GLIBC_VERSION_MAJOR	:= $(word 1,$(_version_temp))
GLIBC_VERSION_MINOR	:= $(word 2,$(_version_temp))
GLIBC_VERSION_MICRO	:= $(word 3,$(_version_temp))

PTXDIST_FULLVERSION	:= $(call remove_quotes,ptxdist-$(PTXDIST_VERSION_FULL)$(PTXCONF_PROJECT_VERSION))
_version_temp		:=
