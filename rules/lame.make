# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LAME) += lame

#
# Paths and names
#
LAME_VERSION	:= 3.99.5
LAME_MD5	:= 84835b313d4a8b68f5349816d33e07ce
LAME		:= lame-$(LAME_VERSION)
LAME_SUFFIX	:= tar.gz
LAME_URL	:= $(call ptx/mirror, SF, lame/$(LAME).$(LAME_SUFFIX))
LAME_SOURCE	:= $(SRCDIR)/$(LAME).$(LAME_SUFFIX)
LAME_DIR	:= $(BUILDDIR)/$(LAME)
LAME_LICENSE	:= LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LAME_CONF_ENV := $(CROSS_ENV)
ifneq ($(PTXCONF_ARCH_X86_I386)$(PTXCONF_ARCH_X86_I486)$(PTXCONF_ARCH_X86_I586)$(PTXCONF_ARCH_X86_I686)$(PTXCONF_ARCH_X86_P2),)
LAME_CONF_ENV += ac_cv_header_xmmintrin_h=no
endif

#
# autoconf
#
LAME_CONF_TOOL	:= autoconf
LAME_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-nasm \
	--disable-rpath \
	--disable-cpml \
	--disable-gtktest \
	--disable-efence \
	--disable-analyzer-hooks \
	--enable-decoder \
	--$(call ptx/endis, PTXCONF_LAME_FRONTEND)-frontend \
	--disable-mp3x \
	--enable-mp3rtp \
	--enable-expopt \
	--disable-debug \
	--without-dmalloc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lame.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lame)
	@$(call install_fixup, lame,PRIORITY,optional)
	@$(call install_fixup, lame,SECTION,base)
	@$(call install_fixup, lame,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, lame,DESCRIPTION,missing)

	@$(call install_lib, lame, 0, 0, 0644, libmp3lame)
ifdef PTXCONF_LAME_FRONTEND
	@$(call install_copy, lame, 0, 0, 0755, -, /usr/bin/lame)
endif

	@$(call install_finish, lame)

	@$(call touch)

# vim: syntax=make
