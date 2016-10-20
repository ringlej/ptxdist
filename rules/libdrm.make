# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDRM) += libdrm

#
# Paths and names
#
LIBDRM_VERSION	:= 2.4.70
LIBDRM_MD5	:= a8c275bce5f3d71a5ca25e8fb60df084
LIBDRM		:= libdrm-$(LIBDRM_VERSION)
LIBDRM_SUFFIX	:= tar.gz
LIBDRM_URL	:= http://dri.freedesktop.org/libdrm/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_SOURCE	:= $(SRCDIR)/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_DIR	:= $(BUILDDIR)/$(LIBDRM)
LIBDRM_LICENSE	:= MIT
LIBDRM_LICENSE_FILES	:= \
	file://xf86drm.c;startline=10;endline=31;md5=30492a61897fb94bd0efd13b4f129d7a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_X86
LIBDRM_BACKENDS-$(PTXCONF_LIBDRM_INTEL) += intel
endif
LIBDRM_BACKENDS-$(PTXCONF_LIBDRM_RADEON) += radeon
LIBDRM_BACKENDS-$(PTXCONF_LIBDRM_AMDGPU) += amdgpu
LIBDRM_BACKENDS-$(PTXCONF_LIBDRM_NOUVEAU) += nouveau
LIBDRM_BACKENDS-$(PTXCONF_LIBDRM_FREEDRENO) += freedreno
LIBDRM_BACKENDSC-$(PTXCONF_LIBDRM_VMWGFX) += vmwgfx
LIBDRM_BACKENDSC-$(PTXCONF_LIBDRM_OMAP) += omap-experimental-api
LIBDRM_BACKENDSL-$(PTXCONF_LIBDRM_OMAP) += omap
LIBDRM_BACKENDSC-$(PTXCONF_LIBDRM_EXYNOS) += exynos-experimental-api
LIBDRM_BACKENDSL-$(PTXCONF_LIBDRM_EXYNOS) += exynos
LIBDRM_BACKENDSC-$(PTXCONF_LIBDRM_TEGRA) += tegra-experimental-api
LIBDRM_BACKENDSL-$(PTXCONF_LIBDRM_TEGRA) += tegra
LIBDRM_BACKENDSC-$(PTXCONF_LIBDRM_VC4) += vc4
# vc4 is a headers only backend

LIBDRM_BACKENDSC-y += $(LIBDRM_BACKENDS-y)
LIBDRM_BACKENDSC- += $(LIBDRM_BACKENDS-)
LIBDRM_BACKENDSL-y += $(LIBDRM_BACKENDS-y)

#
# autoconf
#
LIBDRM_CONF_TOOL := autoconf
LIBDRM_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-udev \
	--$(call ptx/endis, PTXCONF_LIBDRM_LIBKMS)-libkms \
	$(addprefix --enable-,$(LIBDRM_BACKENDSC-y)) \
	$(addprefix --disable-,$(LIBDRM_BACKENDSC-)) \
	--$(call ptx/endis, PTXCONF_LIBDRM_TESTS)-install-test-programs \
	--disable-cairo-tests \
	--disable-manpages \
	--disable-valgrind \
	--without-xsltproc


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdrm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdrm)
	@$(call install_fixup, libdrm,PRIORITY,optional)
	@$(call install_fixup, libdrm,SECTION,base)
	@$(call install_fixup, libdrm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libdrm,DESCRIPTION,missing)

	@$(call install_lib, libdrm, 0, 0, 0644, libdrm)

ifdef PTXCONF_LIBDRM_LIBKMS
	@$(call install_lib, libdrm, 0, 0, 0644, libkms)
endif
	@$(foreach backend,$(LIBDRM_BACKENDSL-y), \
		$(call install_lib, libdrm, 0, 0, 0644, libdrm_$(backend));)

ifdef PTXCONF_LIBDRM_TESTS
ifdef PTXCONF_LIBDRM_LIBKMS
	@$(call install_copy, libdrm, 0, 0, 0755, -, /usr/bin/kmstest)
	@$(call install_copy, libdrm, 0, 0, 0755, -, /usr/bin/modetest)
endif
	@$(call install_copy, libdrm, 0, 0, 0755, -, /usr/bin/modeprint)
	@$(call install_copy, libdrm, 0, 0, 0755, -, /usr/bin/vbltest)
endif
	@$(call install_finish, libdrm)

	@$(call touch)

# vim: syntax=make
