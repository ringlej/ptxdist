# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PIXMAN) += pixman

#
# Paths and names
#
PIXMAN_VERSION	:= 0.16.0
PIXMAN		:= pixman-$(PIXMAN_VERSION)
PIXMAN_SUFFIX	:= tar.bz2
PIXMAN_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(PIXMAN).$(PIXMAN_SUFFIX)
PIXMAN_SOURCE	:= $(SRCDIR)/$(PIXMAN).$(PIXMAN_SUFFIX)
PIXMAN_DIR	:= $(BUILDDIR)/$(PIXMAN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PIXMAN_SOURCE):
	@$(call targetinfo)
	@$(call get, PIXMAN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PIXMAN_PATH	:= PATH=$(CROSS_PATH)
PIXMAN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PIXMAN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-timers \
	--disable-gtk \
	--disable-vmx \
	--disable-arm-simd \
	--disable-arm-neon \
	--disable-gcc-inline-asm

ifdef PTXCONF_ARCH_X86
PIXMAN_AUTOCONF += --enable-mmx --enable-sse2
else
PIXMAN_AUTOCONF += --disable-mmx --disable-sse2
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pixman.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pixman)
	@$(call install_fixup, pixman,PACKAGE,pixman)
	@$(call install_fixup, pixman,PRIORITY,optional)
	@$(call install_fixup, pixman,VERSION,$(PIXMAN_VERSION))
	@$(call install_fixup, pixman,SECTION,base)
	@$(call install_fixup, pixman,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pixman,DEPENDS,)
	@$(call install_fixup, pixman,DESCRIPTION,missing)

	@$(call install_copy, pixman, 0, 0, 0644, -, /usr/lib/libpixman-1.so.0.16.0)
	@$(call install_link, pixman, libpixman-1.so.0.16.0, /usr/lib/libpixman-1.so.0)
	@$(call install_link, pixman, libpixman-1.so.0.16.0, /usr/lib/libpixman-1.so)

	@$(call install_finish, pixman)

	@$(call touch)

# vim: syntax=make
