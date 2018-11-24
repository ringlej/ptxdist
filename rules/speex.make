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
SPEEX_VERSION	:= 1.2.0
SPEEX_MD5	:= 8ab7bb2589110dfaf0ed7fa7757dc49c
SPEEX		:= speex-$(SPEEX_VERSION)
SPEEX_SUFFIX	:= tar.gz
SPEEX_URL	:= http://downloads.xiph.org/releases/speex/$(SPEEX).$(SPEEX_SUFFIX)
SPEEX_SOURCE	:= $(SRCDIR)/$(SPEEX).$(SPEEX_SUFFIX)
SPEEX_DIR	:= $(BUILDDIR)/$(SPEEX)
SPEEX_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPEEX_FFT-$(PTXCONF_SPEEX_FFT_KISS)			+= kiss
SPEEX_FFT-$(PTXCONF_SPEEX_FFT_SMALLFT)			+= smallft

#
# autoconf
#
SPEEX_CONF_TOOL := autoconf
SPEEX_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-valgrind \
	--$(call ptx/endis, PTXCONF_ARCH_X86)-sse \
	--$(call ptx/endis, PTXCONF_SPEEX_FIXED_POINT)-fixed-point \
	--$(call ptx/endis, PTXCONF_SPEEX_FLOAT_API)-float-api \
	--$(call ptx/endis, PTXCONF_SPEEX_BINARIES)-binaries \
	--$(call ptx/endis, PTXCONF_SPEEX_VBR)-vbr \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_V4)-arm4-asm \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_V5E)-arm5e-asm \
	--$(call ptx/endis, PTXCONF_ARCH_BLACKFIN)-blackfin-asm \
	--disable-fixed-point-debug \
	--disable-ti-c55x \
	--$(call ptx/disen, PTXCONF_SPEEX_FIXED_POINT)-vorbis-psy \
	--with-fft=$(SPEEX_FFT-y)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/speex.targetinstall:
	@$(call targetinfo)

	@$(call install_init, speex)
	@$(call install_fixup, speex,PRIORITY,optional)
	@$(call install_fixup, speex,SECTION,base)
	@$(call install_fixup, speex,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, speex,DESCRIPTION,missing)

ifdef PTXCONF_SPEEX_INSTALL_SPEEXENC
	@$(call install_copy, speex, 0, 0, 0755, -, /usr/bin/speexenc)
endif
ifdef PTXCONF_SPEEX_INSTALL_SPEEXDEC
	@$(call install_copy, speex, 0, 0, 0755, -, /usr/bin/speexdec)
endif

	@$(call install_lib, speex, 0, 0, 0644, libspeex)

	@$(call install_finish, speex)

	@$(call touch)

# vim: syntax=make
