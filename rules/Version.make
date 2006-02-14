# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_USE_EXTERNAL_KERNEL
KERNEL_VERSION_MAJOR	:= $(shell sed -ne "s/^VERSION[ ]=[ ]//gp"      $(PTXCONF_KERNEL_DIR)/Makefile)
KERNEL_VERSION_MINOR	:= $(shell sed -ne "s/^PATCHLEVEL[ ]=[ ]//gp"   $(PTXCONF_KERNEL_DIR)/Makefile)
KERNEL_VERSION_MICRO	:= $(shell sed -ne "s/^SUBLEVEL[ ]=[ ]//gp"     $(PTXCONF_KERNEL_DIR)/Makefile)
KERNEL_VERSION_EXTRA	:= $(shell sed -ne "s/^EXTRAVERSION[ ]=[ ]//gp" $(PTXCONF_KERNEL_DIR)/Makefile)
#FIXME: extraversion
KERNEL_VERSION		:= $(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR).$(KERNEL_VERSION_MICRO)
else
KERNEL_VERSION_MAJOR	:= $(shell echo $(PTXCONF_KERNEL_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1/")
KERNEL_VERSION_MINOR	:= $(shell echo $(PTXCONF_KERNEL_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\2/")
KERNEL_VERSION_MICRO	:= $(shell echo $(PTXCONF_KERNEL_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\3/")
KERNEL_VERSION		:= $(call remove_quotes,$(PTXCONF_KERNEL_VERSION))
endif

KERNEL_NATIVE_VERSION_MAJOR	:= $(shell echo $(PTXCONF_KERNEL_NATIVE_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1/")
KERNEL_NATIVE_VERSION_MINOR	:= $(shell echo $(PTXCONF_KERNEL_NATIVE_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\2/")
KERNEL_NATIVE_VERSION_MICRO	:= $(shell echo $(PTXCONF_KERNEL_NATIVE_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\3/")

KERNEL_NATIVE_VERSION		:= $(KERNEL_NATIVE_VERSION_MAJOR).$(KERNEL_NATIVE_VERSION_MINOR).$(KERNEL_NATIVE_VERSION_MICRO)$(KERNEL_NATIVE_VERSION_EXTRA)

GCC_VERSION_MAJOR	:= $(shell echo $(PTXCONF_GCC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1/")
GCC_VERSION_MINOR	:= $(shell echo $(PTXCONF_GCC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\2/")
GCC_VERSION_MICRO	:= $(shell echo $(PTXCONF_GCC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\3/")
GCC_VERSION		:= $(call remove_quotes,$(PTXCONF_GCC_VERSION))

GLIBC_VERSION_MAJOR	:= $(shell echo $(PTXCONF_GLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1/")
GLIBC_VERSION_MINOR	:= $(shell echo $(PTXCONF_GLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\2/")
GLIBC_VERSION_MICRO	:= $(shell echo $(PTXCONF_GLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\3/")
GLIBC_VERSION		:= $(call remove_quotes,$(PTXCONF_GLIBC_VERSION))

UCLIBC_VERSION_MAJOR	:= $(shell echo $(PTXCONF_UCLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1/")
UCLIBC_VERSION_MINOR	:= $(shell echo $(PTXCONF_UCLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\2/")
UCLIBC_VERSION_MICRO	:= $(shell echo $(PTXCONF_UCLIBC_VERSION) | sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\3/")
UCLIBC_VERSION		:= $(call remove_quotes,$(PTXCONF_UCLIBC_VERSION))

BINUTILS_VERSION	:= $(call remove_quotes,$(PTXCONF_BINUTILS_VERSION))

PTXDIST_FULLVERSION	:= $(call remove_quotes,ptxdist-$(FULLVERSION)$(PTXCONF_PROJECT_VERSION))

