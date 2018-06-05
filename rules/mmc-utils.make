# -*-makefile-*-
#
# Copyright (C) 2016 by Matthias Klein <matthias.klein@optimeas.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MMC_UTILS) += mmc-utils

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
MMC_UTILS_VERSION	:= 2016-06-07-g0ca049f25191
MMC_UTILS_MD5		:= da395e908be7e11bd8417cc02485be31
MMC_UTILS		:= mmc-utils-$(MMC_UTILS_VERSION)
MMC_UTILS_SUFFIX	:= tar.gz
MMC_UTILS_URL		:= git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git;tag=$(MMC_UTILS_VERSION)
MMC_UTILS_SOURCE	:= $(SRCDIR)/$(MMC_UTILS).$(MMC_UTILS_SUFFIX)
MMC_UTILS_DIR		:= $(BUILDDIR)/$(MMC_UTILS)
MMC_UTILS_LICENSE	:= GPL-2.0-only AND BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MMC_UTILS_CONF_TOOL	:= NO
MMC_UTILS_MAKE_ENV	:= $(CROSS_ENV) prefix=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mmc-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mmc-utils)
	@$(call install_fixup, mmc-utils,PRIORITY,optional)
	@$(call install_fixup, mmc-utils,SECTION,base)
	@$(call install_fixup, mmc-utils,AUTHOR,"Matthias Klein <matthias.klein@optimeas.de>")
	@$(call install_fixup, mmc-utils,DESCRIPTION,missing)

	@$(call install_copy, mmc-utils, 0, 0, 0755, -, /usr/bin/mmc)

	@$(call install_finish, mmc-utils)

	@$(call touch)

# vim: syntax=make
