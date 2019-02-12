# -*-makefile-*-
#
# Copyright (C) 2018 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NPTH) += npth

#
# Paths and names
#
NPTH_VERSION		:= 1.5
NPTH_MD5		:= 9ba2dc4302d2f32c66737c43ed191b1b
NPTH			:= npth-$(NPTH_VERSION)
NPTH_SUFFIX		:= tar.bz2
NPTH_URL		:= ftp://ftp.gnupg.org/gcrypt/npth/$(NPTH).$(NPTH_SUFFIX)
NPTH_SOURCE		:= $(SRCDIR)/$(NPTH).$(NPTH_SUFFIX)
NPTH_DIR		:= $(BUILDDIR)/$(NPTH)
NPTH_LICENSE		:= LGPL-2.1-only
NPTH_LICENSE_FILES	:= \
	file://COPYING.LIB;md5=2caced0b25dfefd4c601d92bd15116de

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NPTH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-tests \
	--enable-build-timestamp="$(PTXDIST_BUILD_TIMESTAMP)"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/npth.targetinstall:
	@$(call targetinfo)

	@$(call install_init, npth)
	@$(call install_fixup, npth,PRIORITY,optional)
	@$(call install_fixup, npth,SECTION,base)
	@$(call install_fixup, npth,AUTHOR,"Clemens Gruber")
	@$(call install_fixup, npth,DESCRIPTION,"The new GNU portable threads library")

	@$(call install_lib, npth, 0, 0, 0644, libnpth)

	@$(call install_finish, npth)

	@$(call touch)

# vim: syntax=make
