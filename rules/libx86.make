# -*-makefile-*-
#
# Copyright (C) 2008 by mol@pengutronix.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_LIBX86) += libx86

#
# Paths and names
#
LIBX86_VERSION		:= 1.1
LIBX86_MD5		:= 41bee1f8e22b82d82b5f7d7ba51abc2a
LIBX86			:= libx86-$(LIBX86_VERSION)
LIBX86_SUFFIX		:= tar.gz
LIBX86_URL		:= http://www.codon.org.uk/~mjg59/libx86/downloads/$(LIBX86).$(LIBX86_SUFFIX)
LIBX86_SOURCE		:= $(SRCDIR)/$(LIBX86).$(LIBX86_SUFFIX)
LIBX86_DIR		:= $(BUILDDIR)/$(LIBX86)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBX86_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBX86)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

LIBX86_PATH	:= PATH=$(CROSS_PATH)
LIBX86_MAKE_ENV	:= $(CROSS_ENV)

# use emulator on non x86 architectures
ifndef PTXCONF_ARCH_X86
LIBX86_MAKE_ENV += BACKEND=x86emu
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libx86)
	@$(call install_fixup, libx86,PRIORITY,optional)
	@$(call install_fixup, libx86,SECTION,base)
	@$(call install_fixup, libx86,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libx86,DESCRIPTION,missing)

	@$(call install_lib, libx86, 0, 0, 0644, libx86)

	@$(call install_finish, libx86)

	@$(call touch)

# vim: syntax=make
