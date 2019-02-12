# -*-makefile-*-
#
# Copyright (C) 2018 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IMX_KOBS) += imx-kobs

#
# Paths and names
#
IMX_KOBS_VERSION	:= 5.5
IMX_KOBS_SUFFIX		:= tar.gz
IMX_KOBS_MD5		:= 48ed9e69e9527d2e98b5cfcbf133d75b
IMX_KOBS		:= imx-kobs-$(IMX_KOBS_VERSION)
IMX_KOBS_URL		:= https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/$(IMX_KOBS).$(IMX_KOBS_SUFFIX)
IMX_KOBS_DIR		:= $(BUILDDIR)/$(IMX_KOBS)
IMX_KOBS_SOURCE		:= $(SRCDIR)/$(IMX_KOBS).$(IMX_KOBS_SUFFIX)
IMX_KOBS_LICENSE	:= GPL-2.0-or-later
IMX_KOBS_LICENSE_FILES	:= file://COPYING;md5=393a5ca445f6965873eca0259a17f833

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IMX_KOBS_CONF_TOOL	:= autoconf
IMX_KOBS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/imx-kobs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, imx-kobs)
	@$(call install_fixup, imx-kobs, PRIORITY, optional)
	@$(call install_fixup, imx-kobs, SECTION, base)
	@$(call install_fixup, imx-kobs, AUTHOR, "Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, imx-kobs, DESCRIPTION, missing)

	@$(call install_copy, imx-kobs, 0, 0, 0755, -, /usr/bin/kobs-ng)

	@$(call install_finish, imx-kobs)

	@$(call touch)
	
# vim: syntax=make	
