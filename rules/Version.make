# -*-makefile-*-
# $Id: Version.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

KERNEL_VERSION_MAJOR	:= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)=y/\1/)
KERNEL_VERSION_MINOR	:= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)=y/\2/)
KERNEL_VERSION_MICRO	:= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)=y/\3/)
KERNEL_VERSION		:= $(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR).$(KERNEL_VERSION_MICRO)

GCC_VERSION_MAJOR	:= $(call get_option, s/^PTXCONF_GCC_\([0-9]\)_\([0-9]*\)_\([0-9]\)=y/\1/)
GCC_VERSION_MINOR	:= $(call get_option, s/^PTXCONF_GCC_\([0-9]\)_\([0-9]*\)_\([0-9]\)=y/\2/)
GCC_VERSION_MICRO	:= $(call get_option, s/^PTXCONF_GCC_\([0-9]\)_\([0-9]*\)_\([0-9]\)=y/\3/)
GCC_VERSION		:= $(GCC_VERSION_MAJOR).$(GCC_VERSION_MINOR).$(GCC_VERSION_MICRO)

GLIBC_VERSION_MAJOR	:= $(call get_option, s/^PTXCONF_GLIBC_\([0-9]\)_\([0-9]\)_\([0-9]\).*/\1/)
GLIBC_VERSION_MINOR	:= $(call get_option, s/^PTXCONF_GLIBC_\([0-9]\)_\([0-9]\)_\([0-9]\).*/\2/)
GLIBC_VERSION_MICRO	:= $(call get_option, s/^PTXCONF_GLIBC_\([0-9]\)_\([0-9]\)_\([0-9]\).*/\3/)
GLIBC_VERSION		:= $(GLIBC_VERSION_MAJOR).$(GLIBC_VERSION_MINOR).$(GLIBC_VERSION_MICRO)

RTAI_VERSION_RELEASE	:= $(call get_option, s/^PTXCONF_RTAI_\([0-9]*\)_\([0-9]\)_\([0-9]*\)=y/\1.\2.\3/, rtai)
RTAI_VERSION_CVS	:= $(call get_option, s/^PTXCONF_RTAI_CVS_\([0-9]*\)_\([0-9]\)_\([0-9]*\)=y/\1.\2.\3/, cvs)
RTAI_TECH		:= $(call get_option, s/^PTXCONF_RTAI_[0-9]*_[0-9]_[0-9]*_[0-9]_[0-9]_[0-9]*_\([a-z0-9-]*\)=y/\1/)
RTAI_TECH_SHORT		:= $(shell echo $(RTAI_TECH) | sed -e 's/adeos.*/adeos/' -e 's/\(rthal[0-9]\).*/\1/' -e 's/allsoft.*/allsoft1a/')


HOST_GCC_VERSION_MAJOR		:= $(shell $(HOSTCC) -v 2>&1 | sed -n -e 's/gcc version \([0-9]\)\.\([0-9]*\)\.\([0-9]\).*/\1/p')
HOST_GCC_VERSION_MINOR		:= $(shell $(HOSTCC) -v 2>&1 | sed -n -e 's/gcc version \([0-9]\)\.\([0-9]*\)\.\([0-9]\).*/\2/p')
HOST_GCC_VERSION_MICRO		:= $(shell $(HOSTCC) -v 2>&1 | sed -n -e 's/gcc version \([0-9]\)\.\([0-9]*\)\.\([0-9]\).*/\3/p')
HOST_GCC_VERSION		:= $(HOST_CC_VERSION_MAJOR).$(HOST_CC_VERSION_MINOR).$(HOST_CC_VERSION_MICRO)

HOST_GCC_OK :=												\
	$(shell												\
	if [ $(HOST_GCC_VERSION_MAJOR) -eq 3 -a $(HOST_GCC_VERSION_MINOR) -ge 2 ]; then			\
		echo yes;										\
	else												\
		echo no;										\
	fi												\
	)


HOST_BINUTILS_VERSION_MAJOR	:= $(shell as --version 2>&1 | sed -n -e 's/GNU assembler.* \([0-9]\)\.\([0-9]*\)\.\([0-9]\).*/\1/p')
HOST_BINUTILS_VERSION_MINOR	:= $(shell as --version 2>&1 | sed -n -e 's/GNU assembler.* \([0-9]\)\.\([0-9]*\)\.\([0-9]\).*/\2/p')
HOST_BINUTILS_VERSION_MICRO	:= $(shell as --version 2>&1 | sed -n -e 's/GNU assembler.* \([0-9]\)\.\([0-9]*\)\.\([0-9]\).*/\3/p')
HOST_BINUTILS_VERSION		:= $(HOST_BINUTILS_VERSION_MAJOR).$(HOST_BINUTILS_VERSION_MINOR).$(HOST_BINUTILS_VERSION_MICRO)

HOST_BINUTILS_OK :=											\
	$(shell												\
	if [ $(HOST_BINUTILS_VERSION_MAJOR) -eq 2 -a $(HOST_BINUTILS_VERSION_MINOR) -ge 13 ]; then	\
		echo yes;										\
	else												\
		echo no;										\
	fi												\
	)
