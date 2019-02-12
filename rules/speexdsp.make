# -*-makefile-*-
#
# Copyright (C) 2018 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SPEEXDSP) += speexdsp

#
# Paths and names
#
SPEEXDSP_VERSION	:= 1.2rc3
SPEEXDSP_MD5		:= 70d9d31184f7eb761192fd1ef0b73333
SPEEXDSP		:= speexdsp-$(SPEEXDSP_VERSION)
SPEEXDSP_SUFFIX		:= tar.gz
SPEEXDSP_URL		:= http://downloads.xiph.org/releases/speex//$(SPEEXDSP).$(SPEEXDSP_SUFFIX)
SPEEXDSP_SOURCE		:= $(SRCDIR)/$(SPEEXDSP).$(SPEEXDSP_SUFFIX)
SPEEXDSP_DIR		:= $(BUILDDIR)/$(SPEEXDSP)
SPEEXDSP_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPEEXDSP_FFT-$(PTXCONF_SPEEXDSP_FFT_KISS)		+= kiss
SPEEXDSP_FFT-$(PTXCONF_SPEEXDSP_FFT_SMALLFT)		+= smallft

#
# autoconf
#
SPEEXDSP_CONF_TOOL	:= autoconf
SPEEXDSP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-valgrind \
	--$(call ptx/endis, PTXCONF_ARCH_X86)-sse \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_NEON)-neon \
	--$(call ptx/endis, PTXCONF_SPEEXDSP_FIXED_POINT)-fixed-point \
	--$(call ptx/endis, PTXCONF_SPEEXDSP_FLOAT_API)-float-api \
	--disable-examples \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_V4)-arm4-asm \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_V5E)-arm5e-asm \
	--$(call ptx/endis, PTXCONF_ARCH_BLACKFIN)-blackfin-asm \
	--disable-fixed-point-debug \
	--enable-resample-full-sinc-table \
	--disable-ti-c55x \
	--with-fft=$(SPEEXDSP_FFT-y)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/speexdsp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, speexdsp)
	@$(call install_fixup, speexdsp,PRIORITY,optional)
	@$(call install_fixup, speexdsp,SECTION,base)
	@$(call install_fixup, speexdsp,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, speexdsp,DESCRIPTION,missing)

	@$(call install_lib, speexdsp, 0, 0, 0644, libspeexdsp)

	@$(call install_finish, speexdsp)

	@$(call touch)

# vim: syntax=make
