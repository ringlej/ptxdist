# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

KERNEL_VERSION		:= $(call remove_quotes,$(PTXCONF_KERNEL_VERSION))
KERNEL_VERSION_MAJOR	:= $(shell echo $(KERNEL_VERSION) | sed -e "s/\([0-9]*\).\([0-9]*\).\([0-9]*\).*/\1/")
KERNEL_VERSION_MINOR	:= $(shell echo $(KERNEL_VERSION) | sed -e "s/\([0-9]*\).\([0-9]*\).\([0-9]*\).*/\2/")

GCC_VERSION_MAJOR	:= $(shell echo $(PTXCONF_GCC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1/")
GCC_VERSION_MINOR	:= $(shell echo $(PTXCONF_GCC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\2/")
GCC_VERSION_MICRO	:= $(shell echo $(PTXCONF_GCC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\3/")
GCC_VERSION		:= $(call remove_quotes,$(PTXCONF_GCC_VERSION))

GLIBC_VERSION_MAJOR	:= $(shell echo $(PTXCONF_GLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1/")
GLIBC_VERSION_MINOR	:= $(shell echo $(PTXCONF_GLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\2/")
GLIBC_VERSION_MICRO	:= $(shell echo $(PTXCONF_GLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\3/")
GLIBC_VERSION		:= $(call remove_quotes,$(PTXCONF_GLIBC_VERSION))

PTXDIST_FULLVERSION	:= $(call remove_quotes,ptxdist-$(FULLVERSION)$(PTXCONF_PROJECT_VERSION))
