# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WHICH) += which

#
# Paths and names
#
WHICH_VERSION	:= 2.21
WHICH_MD5	:= 097ff1a324ae02e0a3b0369f07a7544a
WHICH		:= which-$(WHICH_VERSION)
WHICH_SUFFIX	:= tar.gz
WHICH_URL	:= $(call ptx/mirror, GNU, which/$(WHICH).$(WHICH_SUFFIX))
WHICH_SOURCE	:= $(SRCDIR)/$(WHICH).$(WHICH_SUFFIX)
WHICH_DIR	:= $(BUILDDIR)/$(WHICH)
WHICH_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
WHICH_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/which.targetinstall:
	@$(call targetinfo)

	@$(call install_init, which)
	@$(call install_fixup, which,PRIORITY,optional)
	@$(call install_fixup, which,SECTION,base)
	@$(call install_fixup, which,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, which,DESCRIPTION,missing)

	@$(call install_copy, which, 0, 0, 0755, -, /usr/bin/which)

	@$(call install_finish, which)

	@$(call touch)

# vim: syntax=make
