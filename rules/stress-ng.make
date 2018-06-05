# -*-makefile-*-
#
# Copyright (C) 2018 by Jan Luebbe <jlu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STRESS_NG) += stress-ng

#
# Paths and names
#
STRESS_NG_VERSION	:= 0.09.24
STRESS_NG_MD5		:= 3a0370dbd1bca7f5aa2614bd4fb0b628
STRESS_NG		:= stress-ng-$(STRESS_NG_VERSION)
STRESS_NG_SUFFIX	:= tar.xz
STRESS_NG_URL		:= http://kernel.ubuntu.com/~cking/tarballs/stress-ng/$(STRESS_NG).$(STRESS_NG_SUFFIX)
STRESS_NG_SOURCE	:= $(SRCDIR)/$(STRESS_NG).$(STRESS_NG_SUFFIX)
STRESS_NG_DIR		:= $(BUILDDIR)/$(STRESS_NG)
STRESS_NG_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

STRESS_NG_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

STRESS_NG_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/stress-ng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, stress-ng)
	@$(call install_fixup, stress-ng,PRIORITY,optional)
	@$(call install_fixup, stress-ng,SECTION,base)
	@$(call install_fixup, stress-ng,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, stress-ng,DESCRIPTION,missing)

	@$(call install_copy, stress-ng, 0, 0, 0755, -, /usr/bin/stress-ng)

	@$(call install_finish, stress-ng)

	@$(call touch)

# vim: syntax=make
