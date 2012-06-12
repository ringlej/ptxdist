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
LIBDRM_VERSION	:= 2.4.35
LIBDRM_MD5	:= 77992a226118a55e214f315bf23d4273
LIBDRM		:= libdrm-$(LIBDRM_VERSION)
LIBDRM_SUFFIX	:= tar.gz
LIBDRM_URL	:= http://dri.freedesktop.org/libdrm/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_SOURCE	:= $(SRCDIR)/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_DIR	:= $(BUILDDIR)/$(LIBDRM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBDRM_CONF_TOOL := autoconf
LIBDRM_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-udev \
	--$(call ptx/endis, PTXCONF_LIBDRM_LIBKMS)-libkms \
	--$(call ptx/endis, PTXCONF_LIBDRM_INTEL)-intel \
	--disable-radeon \
	--disable-nouveau

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
ifdef PTXCONF_ARCH_X86
ifdef PTXCONF_LIBDRM_INTEL
	@$(call install_lib, libdrm, 0, 0, 0644, libdrm_intel)
endif
endif
	@$(call install_finish, libdrm)

	@$(call touch)

# vim: syntax=make
