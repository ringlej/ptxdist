# -*-makefile-*-
#
# Copyright (C) 2011 by Bernhard Walle <walle@corscience.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LPC21ISP) += lpc21isp

#
# Paths and names
#
LPC21ISP_VERSION	:= 1.83
LPC21ISP_MD5		:= 4b437a6d6e718afa6d182f0c18f5363f
LPC21ISP_STRIP_LEVEL	:= 0
LPC21ISP		:= lpc21isp_$(subst .,,$(LPC21ISP_VERSION))
LPC21ISP_SUFFIX		:= tar.gz
LPC21ISP_URL		:= $(call ptx/mirror, SF, lpc21isp/$(LPC21ISP_VERSION)/$(LPC21ISP).$(LPC21ISP_SUFFIX))
LPC21ISP_SOURCE		:= $(SRCDIR)/$(LPC21ISP).$(LPC21ISP_SUFFIX)
LPC21ISP_DIR		:= $(BUILDDIR)/$(LPC21ISP)
LPC21ISP_LICENSE	:= GPLv3+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LPC21ISP_CONF_TOOL	:= NO
LPC21ISP_MAKE_ENV	:= $(CROSS_ENV)
LPC21ISP_MAKEVARS	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lpc21isp.install:
	@$(call targetinfo)
	mkdir -p $(LPC21ISP_PKGDIR)/usr/sbin
	install -m0755 $(LPC21ISP_DIR)/lpc21isp $(LPC21ISP_PKGDIR)/usr/sbin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lpc21isp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lpc21isp)
	@$(call install_fixup, lpc21isp,PRIORITY,optional)
	@$(call install_fixup, lpc21isp,SECTION,base)
	@$(call install_fixup, lpc21isp,AUTHOR,"Bernhard Walle <walle@corscience.de>")
	@$(call install_fixup, lpc21isp,DESCRIPTION,missing)

	@$(call install_copy, lpc21isp, 0, 0, 0755, -, /usr/sbin/lpc21isp)

	@$(call install_finish, lpc21isp)

	@$(call touch)

# vim: syntax=make
