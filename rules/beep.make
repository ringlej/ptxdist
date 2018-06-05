# -*-makefile-*-
#
# Copyright (C) 2017 by Bastian Stender <bst@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BEEP) += beep

#
# Paths and names
#
BEEP_VERSION	:= 1.3
BEEP_MD5	:= 49c340ceb95dbda3f97b2daafac7892a
BEEP		:= beep-$(BEEP_VERSION)
BEEP_SUFFIX	:= tar.gz
BEEP_URL	:= http://www.johnath.com/beep/$(BEEP).$(BEEP_SUFFIX)
BEEP_SOURCE	:= $(SRCDIR)/$(BEEP).$(BEEP_SUFFIX)
BEEP_DIR	:= $(BUILDDIR)/$(BEEP)
BEEP_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BEEP_CONF_TOOL	:= NO
BEEP_MAKE_OPT	:= CC=$(CROSS_CC)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/beep.targetinstall:
	@$(call targetinfo)

	@$(call install_init, beep)
	@$(call install_fixup, beep,PRIORITY,optional)
	@$(call install_fixup, beep,SECTION,base)
	@$(call install_fixup, beep,AUTHOR,"Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, beep,DESCRIPTION,missing)

	@$(call install_copy, beep, 0, 0, 0755, -, /usr/bin/beep)

	@$(call install_finish, beep)

	@$(call touch)

# vim: syntax=make
