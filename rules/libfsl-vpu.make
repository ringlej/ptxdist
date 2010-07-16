# -*-makefile-*-
#
# Copyright (C) 2008 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_ARM_IMX)-$(PTXCONF_LIBFSL_VPU) += libfsl-vpu

#
# Paths and names
#
LIBFSL_VPU_VERSION	:= 0.1.0
LIBFSL_VPU		:= libfsl-vpu-$(LIBFSL_VPU_VERSION)
LIBFSL_VPU_SUFFIX	:= tar.bz2
LIBFSL_VPU_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBFSL_VPU).$(LIBFSL_VPU_SUFFIX)
LIBFSL_VPU_SOURCE	:= $(SRCDIR)/$(LIBFSL_VPU).$(LIBFSL_VPU_SUFFIX)
LIBFSL_VPU_DIR		:= $(BUILDDIR)/$(LIBFSL_VPU)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBFSL_VPU_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBFSL_VPU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBFSL_VPU_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libfsl-vpu.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libfsl-vpu)
	@$(call install_fixup, libfsl-vpu,PRIORITY,optional)
	@$(call install_fixup, libfsl-vpu,SECTION,base)
	@$(call install_fixup, libfsl-vpu,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup, libfsl-vpu,DESCRIPTION,missing)

	@$(call install_copy, libfsl-vpu, 0, 0, 0644, -, \
		/usr/lib/libfsl-vpu-0.1.0.so.0.0.0)
	@$(call install_link, libfsl-vpu, libfsl-vpu-0.1.0.so.0.0.0, /usr/lib/libfsl-vpu-0.1.0.so.0)
	@$(call install_link, libfsl-vpu, libfsl-vpu-0.1.0.so.0.0.0, /usr/lib/libfsl-vpu.so)

	@$(call install_finish, libfsl-vpu)

	@$(call touch)

# vim: syntax=make
