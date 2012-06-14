# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GETTEXT_DUMMY) += gettext-dummy

#
# Paths and names
#
GETTEXT_DUMMY_VERSION	:= 1.0.1
GETTEXT_DUMMY_MD5	:= 44d4a2bd104942950ad72d800fa1282e
GETTEXT_DUMMY		:= gettext-dummy-$(GETTEXT_DUMMY_VERSION)
GETTEXT_DUMMY_SUFFIX	:= tar.bz2
GETTEXT_DUMMY_URL	:= http://www.pengutronix.de/software/gettext-dummy/download/$(GETTEXT_DUMMY).$(GETTEXT_DUMMY_SUFFIX)
GETTEXT_DUMMY_SOURCE	:= $(SRCDIR)/$(GETTEXT_DUMMY).$(GETTEXT_DUMMY_SUFFIX)
GETTEXT_DUMMY_DIR	:= $(BUILDDIR)/$(GETTEXT_DUMMY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GETTEXT_DUMMY_PATH	:= PATH=$(CROSS_PATH)
GETTEXT_DUMMY_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GETTEXT_DUMMY_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext-dummy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gettext-dummy)
	@$(call install_fixup, gettext-dummy,PRIORITY,optional)
	@$(call install_fixup, gettext-dummy,SECTION,base)
	@$(call install_fixup, gettext-dummy,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gettext-dummy,DESCRIPTION,missing)

	@$(call install_lib, gettext-dummy, 0, 0, 0644, libintl)

	@$(call install_finish, gettext-dummy)

	@$(call touch)

# vim: syntax=make
