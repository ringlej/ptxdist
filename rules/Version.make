# -*-makefile-*-
# $Id: Version.make,v 1.6 2003/11/20 18:54:49 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

KERNEL_VERSION_MAJOR	:= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\1/)
KERNEL_VERSION_MINOR	:= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\2/)
KERNEL_VERSION_MICRO	:= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\3/)
KERNEL_VERSION		:= $(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR).$(KERNEL_VERSION_MICRO)

GCC_VERSION_MAJOR	:= $(call get_option, s/^PTXCONF_GCC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\1/)
GCC_VERSION_MINOR	:= $(call get_option, s/^PTXCONF_GCC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\2/)
GCC_VERSION_MICRO	:= $(call get_option, s/^PTXCONF_GCC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\3/)
GCC_VERSION		:= $(GCC_VERSION_MAJOR).$(GCC_VERSION_MINOR).$(GCC_VERSION_MICRO)

GLIBC_VERSION_MAJOR	:= $(call get_option, s/^PTXCONF_GLIBC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\).*/\1/)
GLIBC_VERSION_MINOR	:= $(call get_option, s/^PTXCONF_GLIBC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\).*/\2/)
GLIBC_VERSION_MICRO	:= $(call get_option, s/^PTXCONF_GLIBC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\).*/\3/)
GLIBC_VERSION		:= $(GLIBC_VERSION_MAJOR).$(GLIBC_VERSION_MINOR).$(GLIBC_VERSION_MICRO)

RTAI_VERSION_RELEASE	:= $(call get_option, s/^PTXCONF_RTAI_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\1.\2.\3/, rtai)
RTAI_VERSION_CVS	:= $(call get_option, s/^PTXCONF_RTAI_CVS_\([0-9]*\)_\([0-9]*\)_\([0-9]*\)=y/\1.\2.\3/, cvs)
RTAI_TECH		:= $(call get_option, s/^PTXCONF_RTAI_[0-9]*_[0-9]*_[0-9]*_[0-9]*_[0-9]*_[0-9]*_\([a-z0-9-]*\)=y/\1/)
RTAI_TECH_SHORT		:= $(shell echo $(RTAI_TECH) | sed -e 's/adeos.*/adeos/' -e 's/\(rthal[0-9]\).*/\1/' -e 's/allsoft.*/allsoft1a/')

UCLIBC_VERSION_MAJOR	:= $(call get_option, s/^PTXCONF_UCLIBC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\).*/\1/)
UCLIBC_VERSION_MINOR	:= $(call get_option, s/^PTXCONF_UCLIBC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\).*/\2/)
UCLIBC_VERSION_MICRO	:= $(call get_option, s/^PTXCONF_UCLIBC_\([0-9]*\)_\([0-9]*\)_\([0-9]*\).*/\3/)
UCLIBC_VERSION		:= $(UCLIBC_VERSION_MAJOR).$(UCLIBC_VERSION_MINOR).$(UCLIBC_VERSION_MICRO)

BINUTILS_VERSION	:= $(call get_option_ext, s/^PTXCONF_BINUTILS_\([0-9]*\)_\([0-9]*\)\(_\([0-9]*\)_\([0-9]*\)\)*=y/\1.\2.\4.\5/, sed -e 's/\([0-9][.0-9]*[0-9]\)\.*/\1/')

