# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SPEEX) += speex

#
# Paths and names
#
SPEEX_VERSION	:= 1.2rc1
SPEEX		:= speex-$(SPEEX_VERSION)
SPEEX_SUFFIX	:= tar.gz
SPEEX_URL	:= http://downloads.xiph.org/releases/speex/$(SPEEX).$(SPEEX_SUFFIX)
SPEEX_SOURCE	:= $(SRCDIR)/$(SPEEX).$(SPEEX_SUFFIX)
SPEEX_DIR	:= $(BUILDDIR)/$(SPEEX)
SPEEX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SPEEX_SOURCE):
	@$(call targetinfo)
	@$(call get, SPEEX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPEEX_FFT-$(PTXCONF_SPEEX_FFT_KISS)			+= kiss
SPEEX_FFT-$(PTXCONF_SPEEX_FFT_SMALLFT)			+= smallft
SPEEX_FFT-$(PTXCONF_SPEEX_FFT_GPL_FFTW3)		+= gpl-fftw3
SPEEX_FFT-$(PTXCONF_SPEEX_FFT_PROPRIETARY_INTL_MKL)	+= proprietary-intel-mkl

#
# autoconf
#
SPEEX_CONF_TOOL := autoconf
SPEEX_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-oggtest \
	--disable-valgrind \
	--disable-fixed-point-debug \
	--enable-fixed-point \
	--disable-float-api \
	--disable-vbr \
	--disable-ti-c55x \
	--with-fft=$(SPEEX_FFT-y) \
	--with-ogg=$(PTXDIST_SYSROOT_TARGET)/usr

ifdef PTXCONF_ARCH_ARM_V4
SPEEX_CONF_OPT += --enable-arm4-asm
else
SPEEX_CONF_OPT += --disable-arm4-asm
endif
ifdef PTXCONF_ARCH_ARM_V5E
SPEEX_CONF_OPT += --enable-arm5e-asm
else
SPEEX_CONF_OPT += --disable-arm5e-asm
endif
ifdef PTXCONF_ARCH_X86
SPEEX_CONF_OPT += --enable-sse
else
SPEEX_CONF_OPT += --disable-sse
endif
ifdef PTXCONF_ARCH_BLACKFIN
SPEEX_CONF_OPT += --enable-blackfin-asm
else
SPEEX_CONF_OPT += --disable-blackfin-asm
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/speex.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  speex)
	@$(call install_fixup, speex,PACKAGE,speex)
	@$(call install_fixup, speex,PRIORITY,optional)
	@$(call install_fixup, speex,VERSION,$(SPEEX_VERSION))
	@$(call install_fixup, speex,SECTION,base)
	@$(call install_fixup, speex,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, speex,DEPENDS,)
	@$(call install_fixup, speex,DESCRIPTION,missing)

ifdef PTXCONF_SPEEX_INSTALL_SPEEXENC
	@$(call install_copy, speex, 0, 0, 0755, -, /usr/bin/speexenc)
endif
ifdef PTXCONF_SPEEX_INSTALL_SPEEXDEC
	@$(call install_copy, speex, 0, 0, 0755, -, /usr/bin/speexdec)
endif

	@$(call install_copy, speex, 0, 0, 0644, -, /usr/lib/libspeexdsp.so.1.5.0)
	@$(call install_link, speex, libspeexdsp.so.1.5.0, /usr/lib/libspeexdsp.so.1)
	@$(call install_link, speex, libspeexdsp.so.1.5.0, /usr/lib/libspeexdsp.so)

	@$(call install_copy, speex, 0, 0, 0644, -, /usr/lib/libspeex.so.1.5.0)
	@$(call install_link, speex, libspeex.so.1.5.0, /usr/lib/libspeex.so.1)
	@$(call install_link, speex, libspeex.so.1.5.0, /usr/lib/libspeex.so)

	@$(call install_finish, speex)

	@$(call touch)

# vim: syntax=make
