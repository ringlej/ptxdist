# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STRESS) += stress

#
# Paths and names
#
STRESS_VERSION	:= 1.0.4
STRESS_MD5	:= 890a4236dd1656792f3ef9a190cf99ef
STRESS		:= stress-$(STRESS_VERSION)
STRESS_SUFFIX	:= tar.gz
STRESS_URL	:= https://people.seas.harvard.edu/~apw/stress/$(STRESS).$(STRESS_SUFFIX)
STRESS_SOURCE	:= $(SRCDIR)/$(STRESS).$(STRESS_SUFFIX)
STRESS_DIR	:= $(BUILDDIR)/$(STRESS)
STRESS_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# prevent errors when building the documentation, which is not installed anyways
STRESS_CONF_ENV	:= \
	$(CROSS_ENV) \
	MAKEINFO=:

#
# autoconf
#
STRESS_CONF_TOOL	:= autoconf
STRESS_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/stress.targetinstall:
	@$(call targetinfo)

	@$(call install_init, stress)
	@$(call install_fixup, stress,PRIORITY,optional)
	@$(call install_fixup, stress,SECTION,base)
	@$(call install_fixup, stress,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, stress,DESCRIPTION,missing)

	@$(call install_copy, stress, 0, 0, 0755, -, /usr/bin/stress)

	@$(call install_finish, stress)

	@$(call touch)

# vim: syntax=make
