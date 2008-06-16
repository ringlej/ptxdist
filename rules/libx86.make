# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
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
# Prepare
# ----------------------------------------------------------------------------

LIBX86_PATH	:= PATH=$(CROSS_PATH)
LIBX86_ENV 	:= $(CROSS_ENV)

# use emulator on non x86 architectures
ifndef PTXCONF_ARCH_X86
LIBX86_ENV += BACKEND=x86emu
endif

$(STATEDIR)/libx86.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.compile:
	@$(call targetinfo)
	cd $(LIBX86_DIR) && $(LIBX86_ENV) $(LIBX86_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.install:
	@$(call targetinfo)
	@$(call install, LIBX86)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libx86)
	@$(call install_fixup, libx86,PACKAGE,libx86)
	@$(call install_fixup, libx86,PRIORITY,optional)
	@$(call install_fixup, libx86,VERSION,$(LIBX86_VERSION))
	@$(call install_fixup, libx86,SECTION,base)
	@$(call install_fixup, libx86,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libx86,DEPENDS,)
	@$(call install_fixup, libx86,DESCRIPTION,missing)

	@$(call install_copy, libx86, 0, 0, 0644, $(LIBX86_DIR)/libx86.so.1, /usr/lib/libx86.so.1)
	@$(call install_link, libx86, libx86.so.1, /usr/lib/libx86.so)

	@$(call install_finish, libx86)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libx86_clean:
	rm -rf $(STATEDIR)/libx86.*
	rm -rf $(IMAGEDIR)/libx86_*
	rm -rf $(LIBX86_DIR)

# vim: syntax=make
