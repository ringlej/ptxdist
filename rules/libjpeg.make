# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2007, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBJPEG) += libjpeg

#
# Paths and names
#
LIBJPEG_VERSION	:= 8a
LIBJPEG_MD5	:= 5146e68be3633c597b0d14d3ed8fa2ea
LIBJPEG_SUFFIX	:= tar.gz
LIBJPEG		:= jpeg-$(LIBJPEG_VERSION)
LIBJPEG_TARBALL	:= jpegsrc.v$(LIBJPEG_VERSION).$(LIBJPEG_SUFFIX)
LIBJPEG_URL	:= http://ijg.org/files/$(LIBJPEG_TARBALL)
LIBJPEG_SOURCE	:= $(SRCDIR)/$(LIBJPEG_TARBALL)
LIBJPEG_DIR	:= $(BUILDDIR)/$(LIBJPEG)
LIBJPEG_LICENSE	:= jpeg

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBJPEG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBJPEG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBJPEG_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libjpeg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libjpeg)
	@$(call install_fixup, libjpeg,PRIORITY,optional)
	@$(call install_fixup, libjpeg,SECTION,base)
	@$(call install_fixup, libjpeg,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libjpeg,DESCRIPTION,missing)

	@$(call install_lib, libjpeg, 0, 0, 0644, libjpeg)

	@$(call install_finish, libjpeg)

	@$(call touch)

# vim: syntax=make
