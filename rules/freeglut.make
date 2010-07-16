# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FREEGLUT) += freeglut

#
# Paths and names
#
FREEGLUT_VERSION	:= 2.6.0
FREEGLUT		:= freeglut-$(FREEGLUT_VERSION)
FREEGLUT_SUFFIX		:= tar.gz
FREEGLUT_URL		:= $(PTXCONF_SETUP_SFMIRROR)/freeglut/$(FREEGLUT).$(FREEGLUT_SUFFIX)
FREEGLUT_SOURCE		:= $(SRCDIR)/$(FREEGLUT).$(FREEGLUT_SUFFIX)
FREEGLUT_DIR		:= $(BUILDDIR)/$(FREEGLUT)
FREEGLUT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FREEGLUT_SOURCE):
	@$(call targetinfo)
	@$(call get, FREEGLUT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FREEGLUT_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freeglut.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  freeglut)
	@$(call install_fixup, freeglut,PRIORITY,optional)
	@$(call install_fixup, freeglut,SECTION,base)
	@$(call install_fixup, freeglut,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, freeglut,DESCRIPTION,missing)

	@$(call install_copy, freeglut, 0, 0, 0644, -, \
		/usr/lib/libglut.so.3.9.0)
	@$(call install_link, freeglut, libglut.so.3.9.0, /usr/lib/libglut.so.3)
	@$(call install_link, freeglut, libglut.so.3.9.0, /usr/lib/libglut.so)

	@$(call install_finish, freeglut)

	@$(call touch)

# vim: syntax=make
