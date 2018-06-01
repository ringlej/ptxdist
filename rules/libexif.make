# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEXIF) += libexif

#
# Paths and names
#
LIBEXIF_VERSION		:= 0.6.21
LIBEXIF_MD5		:= 27339b89850f28c8f1c237f233e05b27
LIBEXIF			:= libexif-$(LIBEXIF_VERSION)
LIBEXIF_SUFFIX		:= tar.bz2
LIBEXIF_URL		:= http://sourceforge.net/projects/libexif/files/libexif/$(LIBEXIF_VERSION)/$(LIBEXIF).$(LIBEXIF_SUFFIX)
LIBEXIF_SOURCE		:= $(SRCDIR)/$(LIBEXIF).$(LIBEXIF_SUFFIX)
LIBEXIF_DIR		:= $(BUILDDIR)/$(LIBEXIF)
LIBEXIF_LICENSE		:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEXIF_CONF_TOOL	:= autoconf
LIBEXIF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--disable-internal-docs \
	--disable-nls \
	--disable-rpath

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libexif.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libexif)
	@$(call install_fixup, libexif,PRIORITY,optional)
	@$(call install_fixup, libexif,SECTION,base)
	@$(call install_fixup, libexif,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, libexif,DESCRIPTION,missing)

	@$(call install_lib, libexif, 0, 0, 0644, libexif)

	@$(call install_finish, libexif)

	@$(call touch)

# vim: syntax=make
