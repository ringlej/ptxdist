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
PACKAGES-$(PTXCONF_ED) += ed

#
# Paths and names
#
ED_VERSION	:= 1.14.2
ED_MD5		:= 273d04778b2a51f7c3cbfcd2001876bf
ED		:= ed-$(ED_VERSION)
ED_SUFFIX	:= tar.lz
ED_URL		:= $(call ptx/mirror, GNU, ed/$(ED).$(ED_SUFFIX))
ED_SOURCE	:= $(SRCDIR)/$(ED).$(ED_SUFFIX)
ED_DIR		:= $(BUILDDIR)/$(ED)
ED_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ED_CONF_TOOL	:= autoconf
ED_CONF_OPT	:= $(CROSS_AUTOCONF_USR) $(CROSS_ENV_CC)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ed.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ed)
	@$(call install_fixup, ed,PRIORITY,optional)
	@$(call install_fixup, ed,SECTION,base)
	@$(call install_fixup, ed,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, ed,DESCRIPTION,missing)

	@$(call install_copy, ed, 0, 0, 0755, -, /usr/bin/ed)
	@$(call install_link, ed, ed, /usr/bin/red)

	@$(call install_finish, ed)

	@$(call touch)

# vim: syntax=make
