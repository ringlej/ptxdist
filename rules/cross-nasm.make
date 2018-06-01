# -*-makefile-*-
#
# Copyright (C) 2003 by Dan Kegel http://kegel.com
#               2006-2009 by Marc Kleine-Bude <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_CROSS_NASM) += cross-nasm

ifdef PTXCONF_ARCH_X86

#
# Paths and names
#
CROSS_NASM_VERSION	:= 2.11.08
CROSS_NASM_MD5		:= 0d461a085b088a14dd6628c53be1ce28
CROSS_NASM		:= nasm-$(CROSS_NASM_VERSION)
CROSS_NASM_SUFFIX	:= tar.xz
CROSS_NASM_URL		:= http://www.nasm.us/pub/nasm/releasebuilds/$(CROSS_NASM_VERSION)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_SOURCE	:= $(SRCDIR)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_DIR		:= $(CROSS_BUILDDIR)/$(CROSS_NASM)
CROSS_NASM_LICENSE	:= BSD-2-Clause
CROSS_NASM_LICENSE_FILES := \
	file://LICENSE;md5=90904486f8fbf1861cf42752e1a39efe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CROSS_NASM_CONF_TOOL := autoconf
CROSS_NASM_INSTALL_OPT := INSTALLROOT="$(CROSS_NASM_PKGDIR)" install

endif

# vim: syntax=make
