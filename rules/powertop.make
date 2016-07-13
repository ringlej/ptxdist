# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#		2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POWERTOP) += powertop

#
# Paths and names
#
POWERTOP_VERSION	:= 2.5
POWERTOP_MD5		:= 806bbcbd44fcea1f807c9582fc1f7d3e
POWERTOP		:= powertop-$(POWERTOP_VERSION)
POWERTOP_SUFFIX		:= tar.gz
POWERTOP_URL		:= https://01.org/sites/default/files/downloads/powertop/$(POWERTOP).$(POWERTOP_SUFFIX)
POWERTOP_SOURCE		:= $(SRCDIR)/$(POWERTOP).$(POWERTOP_SUFFIX)
POWERTOP_DIR		:= $(BUILDDIR)/$(POWERTOP)
POWERTOP_LICENSE	:= GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
POWERTOP_CONF_TOOL	:= autoconf
POWERTOP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_POWERTOP_PCI_SUPPORT)-pci \
	--disable-nls \
	--without-libiconv-prefix \
	--without-libintl-prefix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/powertop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, powertop)
	@$(call install_fixup, powertop,PRIORITY,optional)
	@$(call install_fixup, powertop,SECTION,base)
	@$(call install_fixup, powertop,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, powertop,DESCRIPTION,missing)

	@$(call install_copy, powertop, 0, 0, 0755, -, /usr/sbin/powertop)

	@$(call install_finish, powertop)

	@$(call touch)

# vim: syntax=make
