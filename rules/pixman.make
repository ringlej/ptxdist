# -*-makefile-*-
#
# Copyright (C) 2007,2012 by Michael Olbrich <m.olbrich@pengutronix.de>
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
PIXMAN_VERSION	:= 0.24.2
PIXMAN_MD5	:= 2ce7d12750664d2eebd51bf0a07b6205
PIXMAN		:= pixman-$(PIXMAN_VERSION)
PIXMAN_SUFFIX	:= tar.bz2
PIXMAN_URL	:= $(call ptx/mirror, XORG, individual/lib/$(PIXMAN).$(PIXMAN_SUFFIX))
PIXMAN_SOURCE	:= $(SRCDIR)/$(PIXMAN).$(PIXMAN_SUFFIX)
PIXMAN_DIR	:= $(BUILDDIR)/$(PIXMAN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PIXMAN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-openmp \
	--$(call ptx/endis, PTXCONF_ARCH_X86)-mmx \
	--$(call ptx/endis, PTXCONF_ARCH_X86)-sse2 \
	--disable-vmx \
	--disable-arm-simd \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_NEON)-arm-neon \
	--enable-gcc-inline-asm \
	--disable-timers \
	--disable-gtk

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pixman.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pixman)
	@$(call install_fixup, pixman,PRIORITY,optional)
	@$(call install_fixup, pixman,SECTION,base)
	@$(call install_fixup, pixman,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pixman,DESCRIPTION,missing)

	@$(call install_lib, pixman, 0, 0, 0644, libpixman-1)

	@$(call install_finish, pixman)

	@$(call touch)

# vim: syntax=make
