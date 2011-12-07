# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATKMM) += atkmm

#
# Paths and names
#
ATKMM_VERSION	:= 2.22.6
ATKMM_MD5	:= 7c35324dd3c081a385deb7523ed6f287
ATKMM		:= atkmm-$(ATKMM_VERSION)
ATKMM_SUFFIX	:= tar.bz2
ATKMM_URL	:= http://ftp.gnome.org/pub/GNOME/sources/atkmm/2.22/$(ATKMM).$(ATKMM_SUFFIX)
ATKMM_SOURCE	:= $(SRCDIR)/$(ATKMM).$(ATKMM_SUFFIX)
ATKMM_DIR	:= $(BUILDDIR)/$(ATKMM)
ATKMM_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ATKMM_CONF_TOOL	:= autoconf
ATKMM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-documentation

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/atkmm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, atkmm)
	@$(call install_fixup, atkmm,PRIORITY,optional)
	@$(call install_fixup, atkmm,SECTION,base)
	@$(call install_fixup, atkmm,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, atkmm,DESCRIPTION,missing)

	@$(call install_lib, atkmm, 0, 0, 0644, libatkmm-1.6)

	@$(call install_finish, atkmm)

	@$(call touch)

# vim: syntax=make
