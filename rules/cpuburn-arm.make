# -*-makefile-*-
#
# Copyright (C) 2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_ARM)-$(PTXCONF_CPUBURN_ARM) += cpuburn-arm

#
# Paths and names
#
CPUBURN_ARM_VERSION	:= 2015.06.0
CPUBURN_ARM_MD5		:= c27745029e34d2eb52a725d9e6669d07
CPUBURN_ARM		:= cpuburn-arm-$(CPUBURN_ARM_VERSION)
CPUBURN_ARM_SUFFIX	:= tar.bz2
CPUBURN_ARM_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(CPUBURN_ARM).$(CPUBURN_ARM_SUFFIX)
CPUBURN_ARM_SOURCE	:= $(SRCDIR)/$(CPUBURN_ARM).$(CPUBURN_ARM_SUFFIX)
CPUBURN_ARM_DIR		:= $(BUILDDIR)/$(CPUBURN_ARM)
CPUBURN_ARM_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPUBURN_ARM_CONF_TOOL := NO
CPUBURN_ARM_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	PREFIX=/usr
CPUBURN_ARM_INSTALL_OPT := \
	$(CPUBURN_ARM_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cpuburn-arm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cpuburn-arm)
	@$(call install_fixup, cpuburn-arm,PRIORITY,optional)
	@$(call install_fixup, cpuburn-arm,SECTION,base)
	@$(call install_fixup, cpuburn-arm,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, cpuburn-arm,DESCRIPTION,missing)

	@$(call install_copy, cpuburn-arm, 0, 0, 0755, -, /usr/bin/cpuburn-a7)
	@$(call install_copy, cpuburn-arm, 0, 0, 0755, -, /usr/bin/cpuburn-a8)
	@$(call install_copy, cpuburn-arm, 0, 0, 0755, -, /usr/bin/cpuburn-a9)

	@$(call install_finish, cpuburn-arm)

	@$(call touch)

# vim: syntax=make
