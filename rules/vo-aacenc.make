# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VO_AACENC) += vo-aacenc

#
# Paths and names
#
VO_AACENC_VERSION	:= 0.1.3
VO_AACENC_MD5		:= b574da1d92d75fc40b0b75aa16f24ac4
VO_AACENC		:= vo-aacenc-$(VO_AACENC_VERSION)
VO_AACENC_SUFFIX	:= tar.gz
VO_AACENC_URL		:= $(call ptx/mirror, SF, opencore-amr/$(VO_AACENC).$(VO_AACENC_SUFFIX))
VO_AACENC_SOURCE	:= $(SRCDIR)/$(VO_AACENC).$(VO_AACENC_SUFFIX)
VO_AACENC_DIR		:= $(BUILDDIR)/$(VO_AACENC)
VO_AACENC_LICENSE	:= Apache-2.0
VO_AACENC_LICENSE_FILES	:= \
	file://NOTICE;md5=2585210914532b10fe3eba73b74c1544

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
VO_AACENC_CONF_TOOL	:= autoconf
VO_AACENC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-armv5e \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_NEON)-armv7neon \
	--disable-example \
	--disable-static

ifdef PTXCONF_ARCH_ARM
VO_AACENC_CFLAGS := -marm
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vo-aacenc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vo-aacenc)
	@$(call install_fixup, vo-aacenc,PRIORITY,optional)
	@$(call install_fixup, vo-aacenc,SECTION,base)
	@$(call install_fixup, vo-aacenc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, vo-aacenc,DESCRIPTION,missing)

	@$(call install_lib, vo-aacenc, 0, 0, 0644, libvo-aacenc)

	@$(call install_finish, vo-aacenc)

	@$(call touch)

# vim: syntax=make
