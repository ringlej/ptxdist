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
VO_AACENC_VERSION	:= 0.1.2
VO_AACENC_MD5		:= cc862dce14ea5d688506904160c65a02
VO_AACENC		:= vo-aacenc-$(VO_AACENC_VERSION)
VO_AACENC_SUFFIX	:= tar.gz
VO_AACENC_URL		:= $(call ptx/mirror, SF, opencore-amr/$(VO_AACENC).$(VO_AACENC_SUFFIX))
VO_AACENC_SOURCE	:= $(SRCDIR)/$(VO_AACENC).$(VO_AACENC_SUFFIX)
VO_AACENC_DIR		:= $(BUILDDIR)/$(VO_AACENC)
VO_AACENC_LICENSE	:= unknown

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
