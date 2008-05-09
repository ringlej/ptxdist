# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#           (C) 2008 by Wolfram Sang <w.sang@pengutronix.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

KERNEL_VERSION		:= $(call remove_quotes,$(PTXCONF_KERNEL_VERSION))
VERSION_TEMP		:= $(subst ., ,$(KERNEL_VERSION))
KERNEL_VERSION_MAJOR	:= $(word 1,$(VERSION_TEMP))
KERNEL_VERSION_MINOR	:= $(word 2,$(VERSION_TEMP))

GCC_VERSION		:= $(call remove_quotes,$(PTXCONF_CROSSCHAIN_CHECK))
VERSION_TEMP		:= $(subst ., ,$(GCC_VERSION))
GCC_VERSION_MAJOR	:= $(word 1,$(VERSION_TEMP))
GCC_VERSION_MINOR	:= $(word 2,$(VERSION_TEMP))
GCC_VERSION_MICRO	:= $(word 3,$(VERSION_TEMP))

GLIBC_VERSION		:= $(call remove_quotes,$(PTXCONF_GLIBC_VERSION))
VERSION_TEMP		:= $(subst ., ,$(GLIBC_VERSION))
GLIBC_VERSION_MAJOR	:= $(word 1,$(VERSION_TEMP))
GLIBC_VERSION_MINOR	:= $(word 2,$(VERSION_TEMP))
GLIBC_VERSION_MICRO	:= $(word 3,$(VERSION_TEMP))

PTXDIST_FULLVERSION	:= $(call remove_quotes,ptxdist-$(FULLVERSION)$(PTXCONF_PROJECT_VERSION))
VERSION_TEMP		:=
