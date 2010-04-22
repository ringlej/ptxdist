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

#
# Paths and names
#
CROSS_NASM_VERSION	:= 2.07
CROSS_NASM		:= nasm-$(CROSS_NASM_VERSION)
CROSS_NASM_SUFFIX	:= tar.bz2
CROSS_NASM_URL		:= $(PTXCONF_SETUP_SFMIRROR)/nasm/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_SOURCE	:= $(SRCDIR)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_DIR		:= $(CROSS_BUILDDIR)/$(CROSS_NASM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CROSS_NASM_SOURCE):
	@$(call targetinfo)
	@$(call get, CROSS_NASM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CROSS_NASM_CONFTOOL := autoconf
CROSS_NASM_INSTALL_OPT := INSTALLROOT="$(CROSS_NASM_PKGDIR)" install

# vim: syntax=make
