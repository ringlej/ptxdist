# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
#
# Copyright (C) 2008 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBX86) += libx86

#
# Paths and names
#
LIBX86_VERSION		:= 1.1
LIBX86			:= libx86-$(LIBX86_VERSION)
LIBX86_SUFFIX		:= tar.gz
LIBX86_URL		:= http://www.codon.org.uk/~mjg59/libx86/downloads//$(LIBX86).$(LIBX86_SUFFIX)
LIBX86_SOURCE		:= $(SRCDIR)/$(LIBX86).$(LIBX86_SUFFIX)
LIBX86_DIR		:= $(BUILDDIR)/$(LIBX86)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBX86_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBX86)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBX86_DIR))
	@$(call extract, LIBX86)
	@$(call patchin, LIBX86)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBX86_PATH	:= PATH=$(CROSS_PATH)
LIBX86_ENV 	:= $(CROSS_ENV)

# enable build un supported platforms only
ifdef ARCH_X86
LIBX86_BUILD = 1
else
# use emulator on non x86 architectures
LIBX86_ENV += BACKEND=x86emu

ifdef ARCH_PPC
LIBX86_BUILD = 1
endif
endif

#
# autoconf
#
LIBX86_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libx86.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBX86_DIR)/config.cache)
#	cd $(LIBX86_DIR) && \
#		$(LIBX86_PATH) $(LIBX86_ENV) \
#		./configure $(LIBX86_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.compile:
	@$(call targetinfo, $@)
ifdef LIBX86_BUILD
	cd $(LIBX86_DIR) && $(LIBX86_ENV) $(LIBX86_PATH) $(MAKE) $(PARALLELMFLAGS)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.install:
	@$(call targetinfo, $@)
ifdef LIBX86_BUILD
	@$(call install, LIBX86)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libx86.targetinstall:
	@$(call targetinfo, $@)

ifdef LIBX86_BUILD
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
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libx86_clean:
	rm -rf $(STATEDIR)/libx86.*
	rm -rf $(IMAGEDIR)/libx86_*
	rm -rf $(LIBX86_DIR)

# vim: syntax=make
